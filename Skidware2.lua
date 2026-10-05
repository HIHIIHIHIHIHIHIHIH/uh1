--============================================================
-- SKIDWARE REVAMPED - VAPEV4 EDITION
-- Uses actual VapeV4 Speed module logic from GitHub
-- New Blatant tab + TextBox inputs for Speed & TPWalk
--============================================================

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
local StarterGui        = game:GetService("StarterGui")
local Lighting          = game:GetService("Lighting")

local lplr = Players.LocalPlayer
local PlayerGui = lplr:WaitForChild("PlayerGui")

--============================================================
-- LOGGER
--============================================================
local Logger = {}
Logger.__index = Logger

function Logger.new()
    local self = setmetatable({}, Logger)
    self.lines    = {}
    self.maxLines = 300
    self.listFrame = nil
    return self
end

function Logger:log(level, msg)
    local line = string.format("[%s] [%s] %s", os.date("%H:%M:%S"), level, tostring(msg))
    table.insert(self.lines, line)
    if #self.lines > self.maxLines then table.remove(self.lines, 1) end
    print(line)
    self:refresh()
end

function Logger:info(m)  self:log("INFO",  m) end
function Logger:warn(m)  self:log("WARN",  m) end
function Logger:error(m) self:log("ERROR", m) end

function Logger:refresh()
    if not self.listFrame or not self.listFrame.Parent then return end
    for _, c in ipairs(self.listFrame:GetChildren()) do
        if c:IsA("TextLabel") then c:Destroy() end
    end
    for _, line in ipairs(self.lines) do
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -8, 0, 16)
        lbl.BackgroundTransparency = 1
        lbl.Text = line
        if line:find("%[ERROR%]") then
            lbl.TextColor3 = Color3.fromRGB(255, 100, 100)
        elseif line:find("%[WARN%]") then
            lbl.TextColor3 = Color3.fromRGB(255, 200, 100)
        else
            lbl.TextColor3 = Color3.fromRGB(170, 220, 180)
        end
        lbl.Font = Enum.Font.Code
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = self.listFrame
    end
    self.listFrame.CanvasSize = UDim2.new(0, 0, 0, #self.lines * 16 + 6)
    task.defer(function()
        if self.listFrame and self.listFrame.Parent then
            self.listFrame.CanvasPosition = Vector2.new(0, self.listFrame.AbsoluteCanvasSize.Y)
        end
    end)
end

function Logger:getAll()   return table.concat(self.lines, "\n") end

function Logger:copyAll()
    local txt = self:getAll()
    if setclipboard then
        setclipboard(txt)
        self:info("Copied " .. #self.lines .. " lines to clipboard")
    else
        self:warn("setclipboard unavailable")
    end
end

function Logger:clear()
    self.lines = {}
    self:refresh()
end

local Log = Logger.new()

--============================================================
-- CONFIG
--============================================================
local Config = {
    path = "SkidwareCfg.json",
    data = {
        toggles = {},
        settings = { transparency = 0.12, autoSave = true },
        values = { speed = 23, tpwalk = 60 },
    },
}

function Config:save()
    pcall(function()
        if writefile then
            writefile(self.path, HttpService:JSONEncode(self.data))
            Log:info("Config saved")
        end
    end)
end

function Config:load()
    pcall(function()
        if isfile and isfile(self.path) then
            local raw = readfile(self.path)
            local dec = HttpService:JSONDecode(raw)
            if dec.toggles  then self.data.toggles  = dec.toggles  end
            if dec.settings then self.data.settings = dec.settings end
            if dec.values   then self.data.values   = dec.values   end
            Log:info("Config loaded")
        end
    end)
end

function Config:get(name)          return self.data.toggles[name] == true end
function Config:set(name, state)
    self.data.toggles[name] = state
    if self.data.settings.autoSave then self:save() end
end
function Config:getValue(key)      return self.data.values[key] end
function Config:setValue(key, val)
    self.data.values[key] = val
    if self.data.settings.autoSave then self:save() end
end

Config:load()

--============================================================
-- MODULE REGISTRY
--============================================================
local Modules       = {}
local ActiveCleanup = {}

local function register(name, fn)
    Modules[name] = fn
end

local function runModule(name, state)
    if state then
        if ActiveCleanup[name] then
            pcall(ActiveCleanup[name])
            ActiveCleanup[name] = nil
        end
        local ok, result = pcall(Modules[name], true)
        if not ok then
            Log:error("[" .. name .. "] " .. tostring(result))
            Config:set(name, false)
            return false
        end
        if type(result) == "function" then
            ActiveCleanup[name] = result
        end
        Log:info("[" .. name .. "] ON")
    else
        if ActiveCleanup[name] then
            pcall(ActiveCleanup[name])
            ActiveCleanup[name] = nil
        end
        local ok, err = pcall(Modules[name], false)
        if not ok then Log:error("[" .. name .. "] " .. tostring(err)) end
        Log:info("[" .. name .. "] OFF")
    end
    return true
end

--============================================================
-- UI
--============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SkidwareRevamped"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 640, 0, 440)
Main.Position = UDim2.new(0.5, -320, 0.5, -220)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Main.BackgroundTransparency = Config.data.settings.transparency
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 1.5
MainStroke.Color = Color3.fromRGB(120, 130, 200)
MainStroke.Transparency = 0.35

-- Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 34)
TitleBar.BackgroundColor3 = Color3.fromRGB(26, 26, 36)
TitleBar.BackgroundTransparency = 0.1
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 400, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Skidware Revamped"
Title.TextColor3 = Color3.fromRGB(220, 220, 240)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local function titleBtn(txt, xOff, color, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 26, 0, 26)
    b.Position = UDim2.new(1, xOff, 0, 4)
    b.BackgroundColor3 = color
    b.Text = txt
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.BorderSizePixel = 0
    b.Parent = TitleBar
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(cb)
    return b
end

local MinBtn = titleBtn("-", -64, Color3.fromRGB(160, 140, 60), function()
    Main.Visible = false
end)
local CloseBtn = titleBtn("X", -32, Color3.fromRGB(180, 60, 60), function()
    ScreenGui:Destroy()
end)

local ReopenBtn = Instance.new("TextButton")
ReopenBtn.Size = UDim2.new(0, 40, 0, 40)
ReopenBtn.Position = UDim2.new(0, 20, 0.5, -20)
ReopenBtn.BackgroundColor3 = Color3.fromRGB(120, 130, 200)
ReopenBtn.Text = "S"
ReopenBtn.TextColor3 = Color3.new(1, 1, 1)
ReopenBtn.Font = Enum.Font.GothamBold
ReopenBtn.TextSize = 18
ReopenBtn.BorderSizePixel = 0
ReopenBtn.Visible = false
ReopenBtn.Parent = ScreenGui
Instance.new("UICorner", ReopenBtn).CornerRadius = UDim.new(0, 8)
ReopenBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    ReopenBtn.Visible = false
end)

Main:GetPropertyChangedSignal("Visible"):Connect(function()
    if not Main.Visible then
        task.wait(0.05)
        if not Main.Visible then ReopenBtn.Visible = true end
    else
        ReopenBtn.Visible = false
    end
end)

-- Tab bar
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 30)
TabBar.Position = UDim2.new(0, 10, 0, 40)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Main

local TabList = Instance.new("UIListLayout", TabBar)
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.Padding = UDim.new(0, 4)

-- Content
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -86)
Content.Position = UDim2.new(0, 10, 0, 76)
Content.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
Content.BackgroundTransparency = 0.25
Content.BorderSizePixel = 0
Content.Parent = Main
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 8)

local Pages = {}
local ActiveTabName = nil
local TabButtons = {}

local function buildPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.new(1, -12, 1, -12)
    page.Position = UDim2.new(0, 6, 0, 6)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(120, 130, 200)
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.Parent = Content
    local lay = Instance.new("UIListLayout", page)
    lay.Padding = UDim.new(0, 5)
    lay.SortOrder = Enum.SortOrder.LayoutOrder
    Pages[name] = page
end

local function switchTab(name)
    for n, p in pairs(Pages) do p.Visible = (n == name) end
    ActiveTabName = name
    for n, b in pairs(TabButtons) do
        TweenService:Create(b, TweenInfo.new(0.15), {
            BackgroundColor3 = (n == name)
                and Color3.fromRGB(120, 130, 200)
                or Color3.fromRGB(38, 38, 52)
        }):Play()
    end
end

local function buildTabButton(name)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 82, 1, 0)
    b.BackgroundColor3 = Color3.fromRGB(38, 38, 52)
    b.Text = name
    b.TextColor3 = Color3.fromRGB(210, 210, 230)
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 11
    b.BorderSizePixel = 0
    b.Parent = TabBar
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function() switchTab(name) end)
    TabButtons[name] = b
end

--============================================================
-- WIDGETS
--============================================================

-- Toggle widget
local function createToggle(parent, name)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -6, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(36, 36, 48)
    b.Text = name
    b.TextColor3 = Color3.fromRGB(220, 220, 240)
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 12
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.BorderSizePixel = 0
    b.Parent = parent
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)

    local pad = Instance.new("UIPadding", b)
    pad.PaddingLeft = UDim.new(0, 12)

    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 8, 0, 8)
    indicator.Position = UDim2.new(1, -18, 0.5, -4)
    indicator.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
    indicator.BorderSizePixel = 0
    indicator.Parent = b
    Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)

    local state = Config:get(name)

    local function refresh()
        indicator.BackgroundColor3 = state
            and Color3.fromRGB(90, 220, 130)
            or  Color3.fromRGB(80, 80, 100)
        TweenService:Create(b, TweenInfo.new(0.15), {
            BackgroundColor3 = state
                and Color3.fromRGB(52, 90, 68)
                or  Color3.fromRGB(36, 36, 48)
        }):Play()
    end
    refresh()

    if state and Modules[name] then
        task.spawn(function()
            local ok = runModule(name, true)
            if not ok then state = false; Config:set(name, false); refresh() end
        end)
    end

    b.MouseButton1Click:Connect(function()
        state = not state
        local ok = runModule(name, state)
        if not ok then state = false end
        Config:set(name, state)
        refresh()
    end)
end

-- TextBox input widget
local function createInput(parent, label, defaultVal, key)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, -6, 0, 52)
    holder.BackgroundColor3 = Color3.fromRGB(36, 36, 48)
    holder.BorderSizePixel = 0
    holder.Parent = parent
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 0, 18)
    lbl.Position = UDim2.new(0, 8, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(200, 200, 220)
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = holder

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, -16, 0, 26)
    box.Position = UDim2.new(0, 8, 0, 22)
    box.BackgroundColor3 = Color3.fromRGB(26, 26, 34)
    box.Text = tostring(defaultVal)
    box.TextColor3 = Color3.fromRGB(220, 220, 240)
    box.Font = Enum.Font.Code
    box.TextSize = 13
    box.BorderSizePixel = 0
    box.ClearTextOnFocus = false
    box.Parent = holder
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)

    box.FocusLost:Connect(function()
        local num = tonumber(box.Text)
        if num then
            Config:setValue(key, num)
            Log:info(label .. " set to " .. num)
        else
            box.Text = tostring(Config:getValue(key))
            Log:warn("Invalid number for " .. label)
        end
    end)
end

--============================================================
-- MODULES
--============================================================

--============================================================
-- SPEED — ACTUAL VAPEV4 CODE
-- From: src/games/bedwars/6872274481 - game/Blatant/Speed.lua
-- Uses PreSimulation + CustomPhysicalProperties + wall raycast
--============================================================
register("Speed", function(state)
    if not state then
        local char = lplr.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 16 end
        end
        return
    end

    local SPEED_VALUE = Config:getValue("speed") or 23
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude
    rayParams.RespectCanCollide = true

    local frictionParts = {}

    -- Apply low-friction physics (Vape exact)
    local function updateFriction(enable)
        if not enable then
            for part, old in pairs(frictionParts) do
                if part and part.Parent then
                    part.CustomPhysicalProperties = old
                end
            end
            frictionParts = {}
            return
        end
        local char = lplr.Character
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                if not frictionParts[part] then
                    frictionParts[part] = part.CustomPhysicalProperties
                    part.CustomPhysicalProperties = PhysicalProperties.new(0.001, 0.1, 0.3, 1, 1)
                end
            end
        end
    end

    updateFriction(true)

    local conn = RunService.PreSimulation:Connect(function(dt)
        local char = lplr.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not root or not humanoid or humanoid.Health <= 0 then return end
        if humanoid:GetState() == Enum.HumanoidStateType.Climbing then return end

        local velo = (root.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude
        local moveDir = humanoid.MoveDirection
        local target = Config:getValue("speed") or 23
        local destination = moveDir * math.max(target - velo, 0) * dt

        rayParams.FilterDescendantsInstances = { char, Workspace.CurrentCamera }
        local ray = Workspace:Raycast(root.Position, destination, rayParams)
        if ray then
            destination = ray.Position + ray.Normal - root.Position
        end

        root.CFrame = root.CFrame + destination
        root.AssemblyLinearVelocity = Vector3.new(
            moveDir.X * velo,
            root.AssemblyLinearVelocity.Y,
            moveDir.Z * velo
        )

        if (humanoid:GetState() == Enum.HumanoidStateType.Running
            or humanoid:GetState() == Enum.HumanoidStateType.Landed)
            and moveDir.Magnitude > 0 then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)

    return function()
        conn:Disconnect()
        updateFriction(false)
    end
end)

--============================================================
-- TPWALK — Uses Config value for speed
--============================================================
register("TPWalk", function(state)
    if not state then return end
    local conn = RunService.Heartbeat:Connect(function(dt)
        local char = lplr.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum  = char:FindFirstChildOfClass("Humanoid")
        if root and hum and hum.MoveDirection.Magnitude > 0 then
            local speed = Config:getValue("tpwalk") or 60
            root.CFrame = root.CFrame + hum.MoveDirection * speed * dt
        end
    end)
    return function() conn:Disconnect() end
end)

--============================================================
-- OTHER MODULES (VapeV4 patterns)
--============================================================

register("Killaura", function(state)
    if not state then return end
    local remote = ReplicatedStorage:FindFirstChild("SwordRemote", true)
        or ReplicatedStorage:FindFirstChild("AttackEntity", true)
    if not remote then Log:warn("Killaura: no attack remote found") end

    local conn = RunService.Heartbeat:Connect(function()
        local char = lplr.Character
        if not char or not char.PrimaryPart then return end
        local tool = char:FindFirstChildWhichIsA("Tool")
        if not tool or not remote then return end

        local myPos = char.PrimaryPart.Position
        local facing = char.PrimaryPart.CFrame.LookVector * Vector3.new(1, 0, 1)

        local best, bestD = nil, math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= lplr and p.Character and p.Character.PrimaryPart then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local delta = p.Character.PrimaryPart.Position - myPos
                    local d = delta.Magnitude
                    if d < bestD and d <= 18 then
                        local ang = math.acos(math.clamp(facing:Dot((delta * Vector3.new(1,0,1)).Unit), -1, 1))
                        if ang < math.rad(120) then best, bestD = p, d end
                    end
                end
            end
        end

        if best then
            local tRoot = best.Character.PrimaryPart
            local dir = CFrame.lookAt(myPos, tRoot.Position).LookVector
            local pos = myPos + dir * math.max(bestD - 14.399, 0)
            pcall(function()
                remote:FireServer({
                    weapon = tool,
                    chargedAttack = { chargeRatio = 0 },
                    entityInstance = best.Character,
                    validate = {
                        raycast = {
                            cameraPosition = { value = pos },
                            cursorDirection = { value = dir }
                        },
                        targetPosition = { value = tRoot.Position },
                        selfPosition = { value = pos }
                    }
                })
            end)
            char.PrimaryPart.CFrame = CFrame.lookAt(myPos,
                Vector3.new(tRoot.Position.X, myPos.Y, tRoot.Position.Z))
        end
    end)
    return function() conn:Disconnect() end
end)

register("TriggerBot", function(state)
    if not state then return end
    local mouse = lplr:GetMouse()
    local last = 0
    local conn = RunService.Heartbeat:Connect(function()
        if tick() - last < 0.08 then return end
        if not mouse.Target then return end
        local model = mouse.Target:FindFirstAncestorWhichIsA("Model")
        if not model then return end
        local hum = model:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return end
        local p = Players:GetPlayerFromCharacter(model)
        if not p or p == lplr then return end
        local myRoot = lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart")
        local tRoot = model:FindFirstChild("HumanoidRootPart")
        if myRoot and tRoot and (myRoot.Position - tRoot.Position).Magnitude <= 20 then
            mouse1click()
            last = tick()
        end
    end)
    return function() conn:Disconnect() end
end)

register("FastClick", function(state)
    if not state then return end
    local bedwars = ReplicatedStorage:FindFirstChild("Bedwars")
    local sc = bedwars and bedwars:FindFirstChild("Modules")
        and bedwars.Modules:FindFirstChild("SwordController")
    if not sc then Log:warn("FastClick: SwordController not found") return end

    local ok, mod = pcall(require, sc)
    if not ok or not mod then Log:warn("FastClick: require failed") return end

    local original = mod.isClickingTooFast
    mod.isClickingTooFast = function(self)
        self.lastSwing = os.clock()
        return false
    end

    return function()
        if original then mod.isClickingTooFast = original end
    end
end)

register("Spider", function(state)
    if not state then return end
    local conn = RunService.PreSimulation:Connect(function(dt)
        local c = lplr.Character
        if not c then return end
        local root = c:FindFirstChild("HumanoidRootPart")
        local hum  = c:FindFirstChildOfClass("Humanoid")
        if not root or not hum then return end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then return end

        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = { c, Workspace.CurrentCamera }

        local origin = root.Position - Vector3.new(0, hum.HipHeight - 0.5, 0)
        local hit = Workspace:Raycast(origin, hum.MoveDirection * 2.5, params)
        if hit and hit.Normal.Y == 0 then
            hum:ChangeState(Enum.HumanoidStateType.Climbing)
            root.AssemblyLinearVelocity = root.AssemblyLinearVelocity * Vector3.new(1,0,1)
                + Vector3.new(0, 30, 0)
        end
    end)
    return function() conn:Disconnect() end
end)

register("Fly", function(state)
    if not state then
        local c = lplr.Character
        if c and c.PrimaryPart then
            local bv = c.PrimaryPart:FindFirstChild("SkidFly")
            if bv then bv:Destroy() end
        end
        return
    end
    local c = lplr.Character
    if not c or not c.PrimaryPart then return end
    local bv = Instance.new("BodyVelocity")
    bv.Name = "SkidFly"
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Velocity = Vector3.zero
    bv.Parent = c.PrimaryPart

    local conn = RunService.Heartbeat:Connect(function()
        local ch = lplr.Character
        if not ch or not ch.PrimaryPart or not bv.Parent then return end
        local cam = Workspace.CurrentCamera
        bv.Velocity = cam.CFrame.LookVector * 50
    end)
    return function()
        conn:Disconnect()
        bv:Destroy()
    end
end)

register("NoFall", function(state)
    if not state then return end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude

    local conn = RunService.PreSimulation:Connect(function(dt)
        local c = lplr.Character
        if not c then return end
        local root = c:FindFirstChild("HumanoidRootPart")
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not root or not hum then return end

        params.FilterDescendantsInstances = { c, Workspace.CurrentCamera }

        if root.AssemblyLinearVelocity.Y < -85 then
            local hit = Workspace:Blockcast(
                root.CFrame,
                Vector3.new(3, 3, 3),
                Vector3.new(0, -10, 0),
                params
            )
            if not hit then
                root.AssemblyLinearVelocity = Vector3.new(
                    root.AssemblyLinearVelocity.X, -86, root.AssemblyLinearVelocity.Z)
            end
        end
    end)
    return function() conn:Disconnect() end
end)

register("AntiFall", function(state)
    return Modules.NoFall and Modules.NoFall(state)
end)

register("Fullbright", function(state)
    local oldAmbient, oldBright = Lighting.Ambient, Lighting.Brightness
    if state then
        Lighting.Ambient = Color3.fromRGB(180, 180, 180)
        Lighting.Brightness = 3
    else
        Lighting.Ambient = oldAmbient
        Lighting.Brightness = oldBright
    end
end)

register("InfiniteJump", function(state)
    if not state then return end
    local conn = UserInputService.JumpRequest:Connect(function()
        local c = lplr.Character
        local hum = c and c:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)
    return function() conn:Disconnect() end
end)

--============================================================
-- BUILD TABS
--============================================================
buildPage("Blatant")
buildPage("Combat")
buildPage("Movement")
buildPage("Player")
buildPage("Settings")
buildPage("Console")

buildTabButton("Blatant")
buildTabButton("Combat")
buildTabButton("Movement")
buildTabButton("Player")
buildTabButton("Settings")
buildTabButton("Console")

-- Populate BLATANT tab (Vape-style)
createToggle(Pages["Blatant"], "Speed")
createToggle(Pages["Blatant"], "TPWalk")
createToggle(Pages["Blatant"], "Spider")
createToggle(Pages["Blatant"], "Fly")

-- Populate COMBAT
createToggle(Pages["Combat"], "Killaura")
createToggle(Pages["Combat"], "TriggerBot")
createToggle(Pages["Combat"], "FastClick")

-- Populate MOVEMENT
createToggle(Pages["Movement"], "InfiniteJump")
createToggle(Pages["Movement"], "NoFall")
createToggle(Pages["Movement"], "AntiFall")

-- Populate PLAYER
createToggle(Pages["Player"], "Fullbright")

--============================================================
-- BLATANT TAB INPUTS (Speed & TPWalk)
--============================================================
createInput(Pages["Blatant"], "Speed (studs/sec)", Config:getValue("speed") or 23, "speed")
createInput(Pages["Blatant"], "TPWalk (studs/sec)", Config:getValue("tpwalk") or 60, "tpwalk")

--============================================================
-- SETTINGS TAB
--============================================================
do
    local sliderHolder = Instance.new("Frame")
    sliderHolder.Size = UDim2.new(1, -6, 0, 48)
    sliderHolder.BackgroundColor3 = Color3.fromRGB(36, 36, 48)
    sliderHolder.BorderSizePixel = 0
    sliderHolder.Parent = Pages["Settings"]
    Instance.new("UICorner", sliderHolder).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 0, 18)
    lbl.Position = UDim2.new(0, 8, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = "Transparency: " .. string.format("%.2f", Config.data.settings.transparency)
    lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = sliderHolder

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, -16, 0, 8)
    slider.Position = UDim2.new(0, 8, 0, 30)
    slider.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
    slider.BorderSizePixel = 0
    slider.Parent = sliderHolder
    Instance.new("UICorner", slider).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(Config.data.settings.transparency, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(120, 130, 200)
    fill.BorderSizePixel = 0
    fill.Parent = slider
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    slider.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((i.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            lbl.Text = "Transparency: " .. string.format("%.2f", rel)
            Config.data.settings.transparency = rel
            Main.BackgroundTransparency = rel
        end
    end)

    local function actionBtn(text, y, cb)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0.48, -4, 0, 30)
        b.Position = UDim2.new(0, 4, 0, y)
        b.BackgroundColor3 = Color3.fromRGB(120, 130, 200)
        b.Text = text
        b.TextColor3 = Color3.new(1, 1, 1)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 12
        b.BorderSizePixel = 0
        b.Parent = Pages["Settings"]
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
        b.MouseButton1Click:Connect(cb)
        return b
    end

    actionBtn("Save Config", 56, function() Config:save() end)
    local lb = actionBtn("Load Config", 56, function()
        Config:load()
        Main.BackgroundTransparency = Config.data.settings.transparency
    end)
    lb.Position = UDim2.new(0.52, 0, 0, 56)

    actionBtn("Reset All", 92, function()
        for name, _ in pairs(Modules) do
            if ActiveCleanup[name] then
                pcall(ActiveCleanup[name])
                ActiveCleanup[name] = nil
            end
            Config.data.toggles[name] = false
        end
        Config:save()
        Log:info("All modules reset")
    end)
    local cb2 = actionBtn("Clear Config File", 92, function()
        pcall(function()
            if delfile and isfile and isfile(Config.path) then
                delfile(Config.path)
                Log:info("Config file deleted")
            end
        end)
    end)
    cb2.Position = UDim2.new(0.52, 0, 0, 92)
end

--============================================================
-- CONSOLE TAB
--============================================================
do
    local page = Pages["Console"]

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -8, 1, -78)
    scroll.Position = UDim2.new(0, 4, 0, 4)
    scroll.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 4
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.Parent = page
    Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 6)

    Log.listFrame = scroll

    local function btn(text, xOff, yOff, w, cb)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(w, -4, 0, 28)
        b.Position = UDim2.new(xOff, 4, 1, yOff)
        b.BackgroundColor3 = Color3.fromRGB(120, 130, 200)
        b.Text = text
        b.TextColor3 = Color3.new(1, 1, 1)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 11
        b.BorderSizePixel = 0
        b.Parent = page
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
        b.MouseButton1Click:Connect(cb)
        return b
    end

    btn("Copy Log",     0,    -70, 0.32, function() Log:copyAll() end)
    btn("Copy Errors",  0.33, -70, 0.32, function()
        local errs = {}
        for _, l in ipairs(Log.lines) do
            if l:find("%[ERROR%]") then table.insert(errs, l) end
        end
        if setclipboard then
            setclipboard(table.concat(errs, "\n"))
            Log:info("Copied " .. #errs .. " error lines")
        end
    end)
    btn("Clear",        0.66, -70, 0.32, function() Log:clear(); Log:info("Console cleared") end)

    btn("Export to File", 0, -36, 1.0, function()
        pcall(function()
            if writefile then
                writefile("SkidwareLog.txt", Log:getAll())
                Log:info("Exported to SkidwareLog.txt")
            else
                Log:warn("writefile not available")
            end
        end)
    end)
end

Log:refresh()
Log:info("Console initialised")

--============================================================
-- DRAG
--============================================================
do
    local dragging, dragStart, startPos
    TitleBar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = i.Position
            startPos = Main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local d = i.Position - dragStart
            Main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
end

--============================================================
-- DEFAULT TAB + TOGGLE KEY
--============================================================
switchTab("Blatant")

UserInputService.InputBegan:Connect(function(i, gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.RightShift then
        Main.Visible = not Main.Visible
    end
end)

--============================================================
-- DONE
--============================================================
Log:info("Skidware Revamped loaded")
Log:info("RightShift toggles the window")
Log:info("Errors are captured automatically")
