--[[
    SKIDWARE REVAMPED - VAPEV4 EDITION
    Architecture inspired by VapeV4 module system
    - Clean, no emoji/cherry text
    - Log console with error capture + copy
    - Modular: Modules, Settings, Config, Console
]]

--============================================================
-- SERVICES
--============================================================
local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local HttpService       = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")

local lplr = Players.LocalPlayer
local playerGui = lplr:WaitForChild("PlayerGui")

--============================================================
-- LOG CONSOLE (captures errors + copy support)
--============================================================
local Console = {}
Console.__index = Console

function Console.new()
    local self = setmetatable({}, Console)
    self.lines = {}
    self.maxLines = 200
    self.gui = nil
    self.listFrame = nil
    self.inputBox = nil
    return self
end

function Console:log(level, msg)
    local timestamp = os.date("[%H:%M:%S]")
    local line = string.format("%s [%s] %s", timestamp, level, tostring(msg))
    table.insert(self.lines, line)
    if #self.lines > self.maxLines then
        table.remove(self.lines, 1)
    end
    print(line)
    self:refresh()
end

function Console:info(msg)  self:log("INFO",  msg) end
function Console:warn(msg)  self:log("WARN",  msg) end
function Console:error(msg) self:log("ERROR", msg) end

function Console:refresh()
    if not self.listFrame then return end
    for _, c in ipairs(self.listFrame:GetChildren()) do
        if c:IsA("TextLabel") then c:Destroy() end
    end
    for _, line in ipairs(self.lines) do
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -8, 0, 16)
        lbl.BackgroundTransparency = 1
        lbl.Text = line
        lbl.TextColor3 = line:find("%[ERROR%]")
            and Color3.fromRGB(255, 100, 100)
            or line:find("%[WARN%]")
            and Color3.fromRGB(255, 200, 100)
            or Color3.fromRGB(180, 220, 180)
        lbl.Font = Enum.Font.Code
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = self.listFrame
    end
    self.listFrame.CanvasSize = UDim2.new(0, 0, 0, #self.lines * 16 + 4)
    task.defer(function()
        if self.listFrame then
            self.listFrame.CanvasPosition = Vector2.new(0, self.listFrame.AbsoluteCanvasSize.Y)
        end
    end)
end

function Console:getAllText()
    return table.concat(self.lines, "\n")
end

function Console:copyAll()
    local text = self:getAllText()
    if setclipboard then
        setclipboard(text)
        self:info("Console contents copied to clipboard (" .. #self.lines .. " lines)")
    else
        self:warn("setclipboard not available in this executor")
    end
end

function Console:clear()
    self.lines = {}
    self:refresh()
end

local Logger = Console.new()

-- Capture global errors
local oldError = error
error = function(msg, level)
    Logger:error(tostring(msg))
    return oldError(msg, level)
end

-- Capture task.spawn errors
local oldSpawn = task.spawn
task.spawn = function(fn, ...)
    return oldSpawn(function(...)
        local ok, err = pcall(fn, ...)
        if not ok then Logger:error(err) end
    end, ...)
end

--============================================================
-- VAPE STYLE GLOBALS
--============================================================
local vape = {
    ThreadFix = false,
    Entities = {},
    TargetInfo = {
        Targets = {},
        Rotation = CFrame.new(),
        ServerPosition = Vector3.zero,
    },
    Client = {
        Get = function() return { SendToServer = function() end } end,
        ServerPosition = Vector3.zero,
    },
}

local store = {
    KillauraTarget = nil,
    matchState = 1,
    attackReach = 0,
    attackReachUpdate = tick(),
}

local entitylib = {
    isAlive = false,
    character = { RootPart = nil },
    AllPosition = {},
}

local remotes = {}

--============================================================
-- CONFIG MANAGER
--============================================================
local ConfigManager = {}
ConfigManager.__index = ConfigManager

local CONFIG_FILE = "SkidwareConfigVape.json"

function ConfigManager.new()
    local self = setmetatable({}, ConfigManager)
    self.data = {
        toggles = {},
        settings = {
            accentColor  = {255, 105, 180},
            transparency = 0.15,
            autoSave     = true,
            toggleKey    = "RightShift",
        }
    }
    return self
end

function ConfigManager:save()
    pcall(function()
        if writefile then
            writefile(CONFIG_FILE, HttpService:JSONEncode(self.data))
            Logger:info("Config saved")
        end
    end)
end

function ConfigManager:load()
    pcall(function()
        if isfile and isfile(CONFIG_FILE) then
            local raw = readfile(CONFIG_FILE)
            local decoded = HttpService:JSONDecode(raw)
            for k, v in pairs(decoded) do self.data[k] = v end
            Logger:info("Config loaded")
        end
    end)
end

function ConfigManager:getToggle(name) return self.data.toggles[name] == true end
function ConfigManager:setToggle(name, state)
    self.data.toggles[name] = state
    if self.data.settings.autoSave then self:save() end
end
function ConfigManager:getSetting(key) return self.data.settings[key] end
function ConfigManager:setSetting(key, value)
    self.data.settings[key] = value
    if self.data.settings.autoSave then self:save() end
end

local Config = ConfigManager.new()
Config:load()

--============================================================
-- MAIN GUI
--============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SkidwareRevamped"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = playerGui

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 560, 0, 380)
Main.Position = UDim2.new(0.5, -280, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
Main.BackgroundTransparency = Config:getSetting("transparency")
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 1.6
MainStroke.Color = Color3.fromRGB(255, 105, 180)
MainStroke.Transparency = 0.4

-- Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 34)
TitleBar.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
TitleBar.BackgroundTransparency = 0.15
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Position = UDim2.new(0, 14, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Skidware Revamped"
Title.TextColor3 = Color3.fromRGB(230, 230, 245)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -32, 0, 4)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 26, 0, 26)
MinBtn.Position = UDim2.new(1, -64, 0, 4)
MinBtn.BackgroundColor3 = Color3.fromRGB(160, 140, 60)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.new(1,1,1)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 14
MinBtn.BorderSizePixel = 0
MinBtn.Parent = TitleBar
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

-- Tab bar
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 30)
TabBar.Position = UDim2.new(0, 10, 0, 40)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Main

local TabList = Instance.new("UIListLayout", TabBar)
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.Padding = UDim.new(0, 6)

-- Content
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -86)
Content.Position = UDim2.new(0, 10, 0, 76)
Content.BackgroundColor3 = Color3.fromRGB(26, 26, 36)
Content.BackgroundTransparency = 0.35
Content.BorderSizePixel = 0
Content.Parent = Main
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 8)

local Pages = {}

local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.new(1, -12, 1, -12)
    page.Position = UDim2.new(0, 6, 0, 6)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.Parent = Content

    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    Pages[name] = page
    return page
end

--============================================================
-- TAB BUTTON
--============================================================
local ActiveTab = nil

local function switchTab(name)
    for n, p in pairs(Pages) do p.Visible = (n == name) end
    ActiveTab = name
end

local function createTabButton(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 92, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(38, 38, 52)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 220)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.Parent = TabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseEnter:Connect(function()
        if ActiveTab ~= name then
            TweenService:Create(btn, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(52, 52, 70)
            }):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if ActiveTab ~= name then
            TweenService:Create(btn, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(38, 38, 52)
            }):Play()
        end
    end)
    btn.MouseButton1Click:Connect(function()
        switchTab(name)
        for _, child in ipairs(TabBar:GetChildren()) do
            if child:IsA("TextButton") then
                TweenService:Create(child, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(38, 38, 52)
                }):Play()
            end
        end
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(200, 90, 140)
        }):Play()
    end)
end

--============================================================
-- TOGGLE BUTTON
--============================================================
local function createToggle(parent, name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -8, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(36, 36, 48)
    btn.Text = name .. "  [OFF]"
    btn.TextColor3 = Color3.fromRGB(220, 220, 240)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BorderSizePixel = 0
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local pad = Instance.new("UIPadding", btn)
    pad.PaddingLeft = UDim.new(0, 10)

    local state = Config:getToggle(name)

    local function refresh()
        btn.Text = name .. (state and "  [ON]" or "  [OFF]")
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = state
                and Color3.fromRGB(55, 150, 85)
                or Color3.fromRGB(36, 36, 48)
        }):Play()
    end

    refresh()

    if state then
        task.spawn(function() pcall(callback, true) end)
    end

    btn.MouseButton1Click:Connect(function()
        state = not state
        Config:setToggle(name, state)
        refresh()
        local ok, err = pcall(callback, state)
        if not ok then
            Logger:error("[" .. name .. "] " .. tostring(err))
            state = false
            Config:setToggle(name, false)
            refresh()
        end
    end)

    return btn
end

--============================================================
-- MODULES TABLE
--============================================================
local Modules = {}

local function safeWrap(name, fn)
    return function(state)
        local ok, err = pcall(fn, state)
        if not ok then
            Logger:error("[" .. name .. "] " .. tostring(err))
        end
    end
end

-- Combat modules
Modules.Killaura = safeWrap("Killaura", function(state)
    if not state then return end
    local remote = ReplicatedStorage:FindFirstChild("SwordRemote", true)
    if not remote then
        Logger:warn("Killaura: SwordRemote not found")
        return
    end
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not Config:getToggle("Killaura") then
            if conn then conn:Disconnect() end
            return
        end
        local char = lplr.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local tool = char:FindFirstChildWhichIsA("Tool")
        if not root or not tool then return end

        local myPos = root.Position
        local facing = root.CFrame.LookVector * Vector3.new(1, 0, 1)

        local closest, closestDist = nil, math.huge
        for _, plr in Players:GetPlayers() do
            if plr == lplr or not plr.Character then continue end
            local tRoot = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if not tRoot or not hum or hum.Health <= 0 then continue end
            local delta = tRoot.Position - myPos
            local dist = delta.Magnitude
            if dist < closestDist and dist <= 18 then
                local angle = math.acos(facing:Dot((delta * Vector3.new(1,0,1)).Unit))
                if angle < math.rad(120) then
                    closest, closestDist = plr, dist
                end
            end
        end

        if closest then
            local tRoot = closest.Character.HumanoidRootPart
            local dir = CFrame.lookAt(myPos, tRoot.Position).LookVector
            local pos = myPos + dir * math.max(closestDist - 14.399, 0)
            pcall(function()
                remote:FireServer({
                    weapon = tool,
                    chargedAttack = {chargeRatio = 0},
                    entityInstance = closest.Character,
                    validate = {
                        raycast = {
                            cameraPosition = {value = pos},
                            cursorDirection = {value = dir}
                        },
                        targetPosition = {value = tRoot.Position},
                        selfPosition = {value = pos}
                    }
                })
            end)
            root.CFrame = CFrame.lookAt(myPos, Vector3.new(tRoot.Position.X, myPos.Y, tRoot.Position.Z))
        end
    end)
end)

Modules.FastClick = safeWrap("FastClick", function(state)
    local sc = ReplicatedStorage:FindFirstChild("SwordController", true)
    if sc and sc:IsA("ModuleScript") then
        local ok, mod = pcall(require, sc)
        if ok and mod and state then
            mod.isClickingTooFast = function(self)
                self.lastSwing = os.clock()
                return false
            end
            Logger:info("FastClick hooked SwordController")
        end
    else
        Logger:warn("FastClick: SwordController not found")
    end
end)

Modules.CityBoiAura = safeWrap("CityBoiAura", function(state)
    if not state then return end
    local remote = ReplicatedStorage:FindFirstChild("SwordRemote", true)
    if not remote then return end
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not Config:getToggle("CityBoiAura") then
            if conn then conn:Disconnect() end
            return
        end
        local char = lplr.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local tool = char:FindFirstChildWhichIsA("Tool")
        if not root or not tool then return end
        for _, plr in Players:GetPlayers() do
            if plr == lplr or not plr.Character then continue end
            local tRoot = plr.Character:FindFirstChild("HumanoidRootPart")
            if tRoot and (root.Position - tRoot.Position).Magnitude <= 14.4 then
                pcall(function()
                    remote:FireServer({
                        weapon = tool,
                        chargedAttack = {chargeRatio = 0},
                        entityInstance = plr.Character,
                        validate = {
                            raycast = {
                                cameraPosition = {value = root.Position},
                                cursorDirection = {value = (tRoot.Position - root.Position).Unit}
                            },
                            targetPosition = {value = tRoot.Position},
                            selfPosition = {value = root.Position}
                        }
                    })
                end)
            end
        end
    end)
end)

-- Movement modules
Modules.Speed = safeWrap("Speed", function(state)
    local char = lplr.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = state and 50 or 16
    end
end)

Modules.Spider = safeWrap("Spider", function(state)
    if not state then return end
    local conn
    conn = RunService.PreSimulation:Connect(function(dt)
        if not Config:getToggle("Spider") then
            if conn then conn:Disconnect() end
            return
        end
        local char = lplr.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not root or not hum then return end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then return end

        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Blacklist
        params.FilterDescendantsInstances = {char}

        local origin = root.Position - Vector3.new(0, hum.HipHeight - 0.5, 0)
        local hit = Workspace:Raycast(origin, hum.MoveDirection * 2.5, params)
        if hit and hit.Normal.Y == 0 then
            hum:ChangeState(Enum.HumanoidStateType.Climbing)
            root.Velocity = root.Velocity * Vector3.new(1, 0, 1) + Vector3.new(0, 30, 0)
        end
    end)
end)

Modules.Fly = safeWrap("Fly", function(state)
    if not state then return end
    local char = lplr.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Velocity = Vector3.zero
    bv.Parent = root
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not Config:getToggle("Fly") then
            if conn then conn:Disconnect() end
            bv:Destroy()
            return
        end
        local cam = Workspace.CurrentCamera
        bv.Velocity = cam.CFrame.LookVector * 50
    end)
end)

Modules.MiniGlide = safeWrap("MiniGlide", function(state)
    if not state then return end
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not Config:getToggle("MiniGlide") then
            if conn then conn:Disconnect() end
            return
        end
        local char = lplr.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if hum and root and hum.FloorMaterial == Enum.Material.Air then
            root.Velocity = Vector3.new(root.Velocity.X, math.max(root.Velocity.Y, -2), root.Velocity.Z)
        end
    end)
end)

Modules.StiffSpeed = safeWrap("StiffSpeed", function(state)
    if not state then return end
    local conn
    conn = RunService.Heartbeat:Connect(function(dt)
        if not Config:getToggle("StiffSpeed") then
            if conn then conn:Disconnect() end
            return
        end
        local char = lplr.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not root or not hum then return end
        hum.PlatformStand = true
        local move = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += root.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= root.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= root.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += root.CFrame.RightVector end
        if move.Magnitude > 0 then
            root.CFrame = root.CFrame + move.Unit * 100 * dt
        end
    end)
end)

Modules.FarJump = safeWrap("FarJump", function(state)
    if not state then return end
    UserInputService.JumpRequest:Connect(function()
        if not Config:getToggle("FarJump") then return end
        local char = lplr.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            root.Velocity = root.Velocity + root.CFrame.LookVector * 80 + Vector3.new(0, 60, 0)
        end
    end)
end)

-- Player modules
Modules.TriggerBot = safeWrap("TriggerBot", function(state)
    if not state then return end
    local mouse = lplr:GetMouse()
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not Config:getToggle("TriggerBot") then
            if conn then conn:Disconnect() end
            return
        end
        if not mouse.Target then return end
        local model = mouse.Target:FindFirstAncestorWhichIsA("Model")
        if not model then return end
        local hum = model:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return end
        local plr = Players:GetPlayerFromCharacter(model)
        if not plr or plr == lplr then return end
        local myRoot = lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart")
        local tRoot = model:FindFirstChild("HumanoidRootPart")
        if myRoot and tRoot and (myRoot.Position - tRoot.Position).Magnitude <= 20 then
            mouse1click()
        end
    end)
end)

Modules.AutoClicker = safeWrap("AutoClicker", function(state)
    if not state then return end
    task.spawn(function()
        while Config:getToggle("AutoClicker") do
            mouse1click()
            task.wait(0.05)
        end
    end)
end)

Modules.HitboxExpander = safeWrap("HitboxExpander", function(state)
    for _, plr in Players:GetPlayers() do
        if plr ~= lplr and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Size = state and Vector3.new(10, 10, 10) or Vector3.new(2, 2, 1)
                hrp.Transparency = state and 0.6 or 1
                hrp.CanCollide = false
            end
        end
    end
end)

Modules.NoFall = safeWrap("NoFall", function(state)
    if not state then return end
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not Config:getToggle("NoFall") then
            if conn then conn:Disconnect() end
            return
        end
        local char = lplr.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum and hum:GetState() == Enum.HumanoidStateType.Freefall then
            hum:ChangeState(Enum.HumanoidStateType.Landed)
        end
    end)
end)

Modules.AntiFall = safeWrap("AntiFall", function(state)
    Modules.NoFall(state)
end)

Modules.InfiniteJump = safeWrap("InfiniteJump", function(state)
    if not state then return end
    UserInputService.JumpRequest:Connect(function()
        if not Config:getToggle("InfiniteJump") then return end
        local char = lplr.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)
end)

-- Render modules
Modules.Fullbright = safeWrap("Fullbright", function(state)
    local lighting = game:GetService("Lighting")
    if state then
        lighting.Ambient = Color3.fromRGB(180, 180, 180)
        lighting.Brightness = 3
    else
        lighting.Ambient = Color3.fromRGB(70, 70, 70)
        lighting.Brightness = 2
    end
end)

-- Misc modules
Modules.TPWalk = safeWrap("TPWalk", function(state)
    if not state then return end
    local conn
    conn = RunService.Heartbeat:Connect(function(dt)
        if not Config:getToggle("TPWalk") then
            if conn then conn:Disconnect() end
            return
        end
        local char = lplr.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if root and hum and hum.MoveDirection.Magnitude > 0 then
            root.CFrame = root.CFrame + hum.MoveDirection * 60 * dt
        end
    end)
end)

Modules.JitterMove = safeWrap("JitterMove", function(state)
    if not state then return end
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not Config:getToggle("JitterMove") then
            if conn then conn:Disconnect() end
            return
        end
        local char = lplr.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = root.CFrame + Vector3.new(
                math.random(-10, 10) / 100, 0, math.random(-10, 10) / 100
            )
        end
    end)
end)

Modules.AutoRespawn = safeWrap("AutoRespawn", function(state)
    if not state then return end
    lplr.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        pcall(function() char:BreakJoints() end)
    end)
end)

Modules.Theme = safeWrap("Theme", function(state)
    local overlay = ScreenGui:FindFirstChild("ThemeOverlay")
    if not overlay then
        overlay = Instance.new("Frame")
        overlay.Name = "ThemeOverlay"
        overlay.Size = UDim2.new(1, 0, 1, 0)
        overlay.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
        overlay.BackgroundTransparency = 1
        overlay.BorderSizePixel = 0
        overlay.ZIndex = 0
        overlay.Parent = ScreenGui
    end
    TweenService:Create(overlay, TweenInfo.new(0.6), {
        BackgroundTransparency = state and 0.8 or 1
    }):Play()
end)

-- AC-related (kept as named toggles, actual logic game-specific)
for _, name in ipairs({"SpoofAC", "SemiDisabler", "TPNearAC", "ACV2", "ACPrivate", "PlayerPull"}) do
    Modules[name] = safeWrap(name, function(state)
        Logger:info(name .. " -> " .. (state and "ON" or "OFF"))
    end)
end

--============================================================
-- BUILD TABS
--============================================================
createPage("Combat")
createPage("Movement")
createPage("Player")
createPage("Render")
createPage("Misc")
createPage("Settings")
createPage("Console")

createTabButton("Combat")
createTabButton("Movement")
createTabButton("Player")
createTabButton("Render")
createTabButton("Misc")
createTabButton("Settings")
createTabButton("Console")

switchTab("Combat")
TweenService:Create(TabBar:GetChildren()[1], TweenInfo.new(0.2), {
    BackgroundColor3 = Color3.fromRGB(200, 90, 140)
}):Play()

-- Populate
createToggle(Pages["Combat"], "Killaura",      Modules.Killaura)
createToggle(Pages["Combat"], "CityBoiAura",   Modules.CityBoiAura)
createToggle(Pages["Combat"], "FastClick",     Modules.FastClick)
createToggle(Pages["Combat"], "TriggerBot",    Modules.TriggerBot)
createToggle(Pages["Combat"], "AutoClicker",   Modules.AutoClicker)
createToggle(Pages["Combat"], "HitboxExpander",Modules.HitboxExpander)

createToggle(Pages["Movement"], "Speed",       Modules.Speed)
createToggle(Pages["Movement"], "Spider",      Modules.Spider)
createToggle(Pages["Movement"], "Fly",         Modules.Fly)
createToggle(Pages["Movement"], "MiniGlide",   Modules.MiniGlide)
createToggle(Pages["Movement"], "StiffSpeed",  Modules.StiffSpeed)
createToggle(Pages["Movement"], "FarJump",     Modules.FarJump)
createToggle(Pages["Movement"], "TPWalk",      Modules.TPWalk)
createToggle(Pages["Movement"], "JitterMove",  Modules.JitterMove)

createToggle(Pages["Player"], "NoFall",        Modules.NoFall)
createToggle(Pages["Player"], "AntiFall",      Modules.AntiFall)
createToggle(Pages["Player"], "InfiniteJump",  Modules.InfiniteJump)
createToggle(Pages["Player"], "AutoRespawn",   Modules.AutoRespawn)

createToggle(Pages["Render"], "Fullbright",    Modules.Fullbright)
createToggle(Pages["Render"], "Theme",         Modules.Theme)

createToggle(Pages["Misc"], "SpoofAC",         Modules.SpoofAC)
createToggle(Pages["Misc"], "SemiDisabler",    Modules.SemiDisabler)
createToggle(Pages["Misc"], "TPNearAC",        Modules.TPNearAC)
createToggle(Pages["Misc"], "ACV2",            Modules.ACV2)
createToggle(Pages["Misc"], "ACPrivate",       Modules.ACPrivate)
createToggle(Pages["Misc"], "PlayerPull",      Modules.PlayerPull)

--============================================================
-- SETTINGS TAB
--============================================================
local function createSlider(parent, label, min, max, default, callback)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, -8, 0, 46)
    holder.BackgroundColor3 = Color3.fromRGB(36, 36, 48)
    holder.BorderSizePixel = 0
    holder.Parent = parent
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 0, 18)
    lbl.Position = UDim2.new(0, 8, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = label .. ": " .. string.format("%.2f", default)
    lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = holder

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, -16, 0, 8)
    slider.Position = UDim2.new(0, 8, 0, 28)
    slider.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
    slider.BorderSizePixel = 0
    slider.Parent = holder
    Instance.new("UICorner", slider).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(200, 90, 140)
    fill.BorderSizePixel = 0
    fill.Parent = slider
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            local val = min + (max - min) * rel
            lbl.Text = label .. ": " .. string.format("%.2f", val)
            callback(val)
        end
    end)
end

createSlider(Pages["Settings"], "Transparency", 0, 0.9,
    Config:getSetting("transparency"),
    function(v)
        Config:setSetting("transparency", v)
        Main.BackgroundTransparency = v
    end)

local function createActionBtn(parent, text, cb)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.48, -4, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(200, 90, 140)
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(cb)
    return btn
end

local SaveBtn = createActionBtn(Pages["Settings"], "Save Config", function()
    Config:save()
    Logger:info("Save button clicked")
end)
SaveBtn.Position = UDim2.new(0, 4, 0, 0)

local LoadBtn = createActionBtn(Pages["Settings"], "Load Config", function()
    Config:load()
    Logger:info("Load button clicked")
end)
LoadBtn.Position = UDim2.new(0.52, 0, 0, 0)

--============================================================
-- CONSOLE TAB
--============================================================
local consoleFrame = Pages["Console"]

local consoleScroll = Instance.new("ScrollingFrame")
consoleScroll.Size = UDim2.new(1, -8, 1, -80)
consoleScroll.Position = UDim2.new(0, 4, 0, 4)
consoleScroll.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
consoleScroll.BorderSizePixel = 0
consoleScroll.ScrollBarThickness = 4
consoleScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
consoleScroll.Parent = consoleFrame
Instance.new("UICorner", consoleScroll).CornerRadius = UDim.new(0, 6)

Logger.listFrame = consoleScroll

local consoleBtnRow = Instance.new("Frame")
consoleBtnRow.Size = UDim2.new(1, -8, 0, 30)
consoleBtnRow.Position = UDim2.new(0, 4, 1, -66)
consoleBtnRow.BackgroundTransparency = 1
consoleBtnRow.Parent = consoleFrame

local CopyBtn = createActionBtn(consoleBtnRow, "Copy Errors", function()
    Logger:copyAll()
end)
CopyBtn.Position = UDim2.new(0, 0, 0, 0)

local ClearBtn = createActionBtn(consoleBtnRow, "Clear Console", function()
    Logger:clear()
    Logger:info("Console cleared")
end)
ClearBtn.Position = UDim2.new(0.52, 0, 0, 0)

local ExportBtn = createActionBtn(consoleFrame, "Export to File", function()
    if writefile then
        pcall(function()
            writefile("SkidwareLog.txt", Logger:getAllText())
            Logger:info("Log exported to SkidwareLog.txt")
        end)
    else
        Logger:warn("writefile not available")
    end
end)
ExportBtn.Size = UDim2.new(1, -8, 0, 28)
ExportBtn.Position = UDim2.new(0, 4, 1, -30)

Logger:refresh()
Logger:info("Console initialised")

--============================================================
-- DRAGGING
--============================================================
local dragging, dragInput, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

--============================================================
-- CLOSE / MINIMIZE
--============================================================
CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(Main, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    task.wait(0.25)
    ScreenGui:Destroy()
end)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    TweenService:Create(Main, TweenInfo.new(0.25), {
        Size = minimized and UDim2.new(0, 560, 0, 34) or UDim2.new(0, 560, 0, 380)
    }):Play()
end)

--============================================================
-- TOGGLE KEYBIND
--============================================================
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

--============================================================
-- DONE
--============================================================
Logger:info("Skidware Revamped loaded")
Logger:info("Press RightShift to toggle GUI")
Logger:info("Errors will be captured automatically")
