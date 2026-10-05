--[[
    PRISMWARE REVAMPED
    UI based on Prismware (old Skidware) by @uniquadev
    Modules: Real VapeV4 code from 7GrandDadPGN/VapeV4ForRoblox
    Speed.lua / Killaura.lua / Fly.lua / NoFall.lua
    Tabs added: Blatant | Combat | Movement | Player | Settings | Console
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
    self.lines     = {}
    self.maxLines  = 300
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
    if setclipboard then
        setclipboard(self:getAll())
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
    path = "PrismwareCfg.json",
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

function Config:get(name)      return self.data.toggles[name] == true end
function Config:set(name, s)
    self.data.toggles[name] = s
    if self.data.settings.autoSave then self:save() end
end
function Config:getValue(key)  return self.data.values[key] end
function Config:setValue(key, v)
    self.data.values[key] = v
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
-- PRISMWARE-STYLE UI
--============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Prismware"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- MAIN FRAME (Prismware style: light grey base with gradient stroke)
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 560, 0, 380)
Main.Position = UDim2.new(0.5, -280, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(181, 181, 181)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

Instance.new("UICorner", Main)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 4.8
MainStroke.Color = Color3.fromRGB(255, 255, 255)

local MainGradient = Instance.new("UIGradient", MainStroke)
MainGradient.Rotation = -90
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.000, Color3.fromRGB(94, 66, 88)),
    ColorSequenceKeypoint.new(1.000, Color3.fromRGB(169, 203, 187))
}

local MainGrad = Instance.new("UIGradient", Main)
MainGrad.Rotation = -90
MainGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.000, Color3.fromRGB(94, 66, 88)),
    ColorSequenceKeypoint.new(1.000, Color3.fromRGB(169, 203, 187))
}

-- Title bar (Prismware-style but with tab space)
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, -12, 0, 28)
TitleBar.Position = UDim2.new(0, 6, 0, 6)
TitleBar.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TitleBar.BackgroundTransparency = 0.26
TitleBar.BorderColor3 = Color3.fromRGB(62, 62, 62)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main
Instance.new("UICorner", TitleBar)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Prismware"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansPro
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Close / Minimize
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 22, 0, 22)
CloseBtn.Position = UDim2.new(1, -28, 0, 3)
CloseBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
CloseBtn.BackgroundTransparency = 0.26
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansPro
CloseBtn.TextSize = 14
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 22, 0, 22)
MinBtn.Position = UDim2.new(1, -54, 0, 3)
MinBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
MinBtn.BackgroundTransparency = 0.26
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.SourceSansPro
MinBtn.TextSize = 14
MinBtn.BorderSizePixel = 0
MinBtn.Parent = TitleBar
Instance.new("UICorner", MinBtn)
MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

-- Reopen button (floating)
local ReopenBtn = Instance.new("TextButton")
ReopenBtn.Size = UDim2.new(0, 36, 0, 36)
ReopenBtn.Position = UDim2.new(0, 20, 0.5, -18)
ReopenBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ReopenBtn.BackgroundTransparency = 0.2
ReopenBtn.Text = "P"
ReopenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ReopenBtn.Font = Enum.Font.SourceSansPro
ReopenBtn.TextSize = 18
ReopenBtn.BorderSizePixel = 0
ReopenBtn.Visible = false
ReopenBtn.Parent = ScreenGui
Instance.new("UICorner", ReopenBtn)
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

--============================================================
-- TAB BAR (Prismware button style)
--============================================================
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -12, 0, 26)
TabBar.Position = UDim2.new(0, 6, 0, 40)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Main

local TabList = Instance.new("UIListLayout", TabBar)
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.Padding = UDim.new(0, 3)

-- Content area
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -12, 1, -78)
Content.Position = UDim2.new(0, 6, 0, 70)
Content.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Content.BackgroundTransparency = 0.26
Content.BorderColor3 = Color3.fromRGB(62, 62, 62)
Content.BorderSizePixel = 0
Content.Parent = Main
Instance.new("UICorner", Content)

local Pages = {}
local ActiveTabName = nil
local TabButtons = {}

local function buildPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.new(1, -10, 1, -10)
    page.Position = UDim2.new(0, 5, 0, 5)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(86, 86, 86)
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.Parent = Content

    local lay = Instance.new("UIListLayout", page)
    lay.Padding = UDim.new(0, 4)
    lay.SortOrder = Enum.SortOrder.LayoutOrder

    Pages[name] = page
end

local function switchTab(name)
    for n, p in pairs(Pages) do p.Visible = (n == name) end
    ActiveTabName = name
    for n, b in pairs(TabButtons) do
        TweenService:Create(b, TweenInfo.new(0.15), {
            BackgroundColor3 = (n == name)
                and Color3.fromRGB(86, 86, 86)
                or  Color3.fromRGB(70, 70, 70)
        }):Play()
    end
end

local function buildTabButton(name)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 82, 1, 0)
    b.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    b.BackgroundTransparency = 0.26
    b.Text = name
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansPro
    b.TextSize = 13
    b.BorderSizePixel = 0
    b.Parent = TabBar
    Instance.new("UICorner", b)

    local stroke = Instance.new("UIStroke", b)
    stroke.Thickness = 2.4
    stroke.Color = Color3.fromRGB(86, 86, 86)

    b.MouseButton1Click:Connect(function() switchTab(name) end)
    TabButtons[name] = b
end

--============================================================
-- WIDGETS (Prismware style)
--============================================================

-- Toggle button (Prismware style)
local function createToggle(parent, name)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -4, 0, 23)
    b.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    b.BackgroundTransparency = 0.26
    b.Text = name
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansPro
    b.TextSize = 14
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.BorderColor3 = Color3.fromRGB(62, 62, 62)
    b.BorderSizePixel = 0
    b.Parent = parent
    Instance.new("UICorner", b)

    local stroke = Instance.new("UIStroke", b)
    stroke.Thickness = 2.4
    stroke.Color = Color3.fromRGB(86, 86, 86)

    local grad = Instance.new("UIGradient", b)
    grad.Rotation = -90
    grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),
        ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))
    }

    local pad = Instance.new("UIPadding", b)
    pad.PaddingLeft = UDim.new(0, 10)

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 8, 0, 8)
    dot.Position = UDim2.new(1, -16, 0.5, -4)
    dot.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    dot.BorderSizePixel = 0
    dot.Parent = b
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local state = Config:get(name)

    local function refresh()
        dot.BackgroundColor3 = state
            and Color3.fromRGB(60, 180, 60)
            or  Color3.fromRGB(60, 60, 60)
        TweenService:Create(b, TweenInfo.new(0.15), {
            BackgroundColor3 = state
                and Color3.fromRGB(52, 90, 68)
                or  Color3.fromRGB(70, 70, 70)
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

-- Input widget (Prismware style)
local function createInput(parent, label, defaultVal, key)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, -4, 0, 48)
    holder.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    holder.BackgroundTransparency = 0.26
    holder.BorderColor3 = Color3.fromRGB(62, 62, 62)
    holder.BorderSizePixel = 0
    holder.Parent = parent
    Instance.new("UICorner", holder)

    local stroke = Instance.new("UIStroke", holder)
    stroke.Thickness = 2.4
    stroke.Color = Color3.fromRGB(86, 86, 86)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 0, 16)
    lbl.Position = UDim2.new(0, 8, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.SourceSansPro
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = holder

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, -16, 0, 22)
    box.Position = UDim2.new(0, 8, 0, 22)
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    box.Text = tostring(defaultVal)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.Code
    box.TextSize = 13
    box.BorderSizePixel = 0
    box.ClearTextOnFocus = false
    box.Parent = holder
    Instance.new("UICorner", box)

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
-- MODULES (Real VapeV4 code adapted)
--============================================================

--============================================================
-- SPEED — from VapeV4 Speed.lua
-- PreSimulation + frictionTable + WallCheck + AutoJump
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

    local rayCheck = RaycastParams.new()
    rayCheck.RespectCanCollide = true

    local frictionParts = {}

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

        local state = humanoid:GetState()
        if state == Enum.HumanoidStateType.Climbing then return end

        local velo = (root.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude
        local moveDir = humanoid.MoveDirection
        local target = Config:getValue("speed") or 23
        local destination = moveDir * math.max(target - velo, 0) * dt

        -- WallCheck (from Vape)
        rayCheck.FilterDescendantsInstances = { char, Workspace.CurrentCamera }
        rayCheck.CollisionGroup = root.CollisionGroup
        local ray = Workspace:Raycast(root.Position, destination, rayCheck)
        if ray then
            destination = (ray.Position + ray.Normal) - root.Position
        end

        root.CFrame = root.CFrame + destination
        root.AssemblyLinearVelocity = (moveDir * velo) + Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)

        -- AutoJump (from Vape)
        if (state == Enum.HumanoidStateType.Running or state == Enum.HumanoidStateType.Landed)
            and moveDir ~= Vector3.zero then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)

    return function()
        conn:Disconnect()
        updateFriction(false)
    end
end)

--============================================================
-- KILLAURA — from VapeV4 Killaura.lua
-- Uses AttackEntity remote + validation table
--============================================================
register("Killaura", function(state)
    if not state then return end

    local AttackRemote = ReplicatedStorage:FindFirstChild("AttackEntity", true)
        or ReplicatedStorage:FindFirstChild("SwordRemote", true)
    if not AttackRemote then
        Log:warn("Killaura: AttackEntity remote not found")
        return
    end

    local conn = RunService.Heartbeat:Connect(function()
        local char = lplr.Character
        if not char or not char.PrimaryPart then return end
        local tool = char:FindFirstChildWhichIsA("Tool")
        if not tool then return end

        local selfpos = char.PrimaryPart.Position
        local localfacing = char.PrimaryPart.CFrame.LookVector * Vector3.new(1, 0, 1)

        local best, bestDist = nil, math.huge
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr == lplr then continue end
            local targetChar = plr.Character
            if not targetChar or not targetChar.PrimaryPart then continue end
            local hum = targetChar:FindFirstChildOfClass("Humanoid")
            if not hum or hum.Health <= 0 then continue end

            local delta = targetChar.PrimaryPart.Position - selfpos
            local dist = delta.Magnitude
            if dist > 28 then continue end

            local angle = math.acos(math.clamp(localfacing:Dot((delta * Vector3.new(1, 0, 1)).Unit), -1, 1))
            if angle > math.rad(180) then continue end

            if dist < bestDist then
                best, bestDist = plr, dist
            end
        end

        if best then
            local tRoot = best.Character.PrimaryPart
            local dir = CFrame.lookAt(selfpos, tRoot.Position).LookVector
            local pos = selfpos + dir * math.max(bestDist - 14.399, 0)

            pcall(function()
                AttackRemote:FireServer({
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

            -- Face target (from Vape)
            char.PrimaryPart.CFrame = CFrame.lookAt(
                selfpos,
                Vector3.new(tRoot.Position.X, selfpos.Y + 0.001, tRoot.Position.Z)
            )
        end
    end)

    return function() conn:Disconnect() end
end)

--============================================================
-- FLY — from VapeV4 Fly.lua
--============================================================
register("Fly", function(state)
    if not state then
        local char = lplr.Character
        if char and char.PrimaryPart then
            local bv = char.PrimaryPart:FindFirstChild("PrismFly")
            if bv then bv:Destroy() end
        end
        return
    end

    local char = lplr.Character
    if not char or not char.PrimaryPart then return end

    local rayCheck = RaycastParams.new()
    rayCheck.RespectCanCollide = true

    local bv = Instance.new("BodyVelocity")
    bv.Name = "PrismFly"
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Velocity = Vector3.zero
    bv.Parent = char.PrimaryPart

    local conn = RunService.PreSimulation:Connect(function(dt)
        local ch = lplr.Character
        if not ch or not ch.PrimaryPart or not bv.Parent then return end

        local root = ch.PrimaryPart
        local humanoid = ch:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end

        local moveDir = humanoid.MoveDirection
        local velo = 23
        local destination = moveDir * math.max(velo, 0) * dt

        rayCheck.FilterDescendantsInstances = { ch, Workspace.CurrentCamera }
        rayCheck.CollisionGroup = root.CollisionGroup

        local ray = Workspace:Raycast(root.Position, destination, rayCheck)
        if ray then
            destination = (ray.Position + ray.Normal) - root.Position
        end

        root.CFrame = root.CFrame + destination
        bv.Velocity = (moveDir * velo) + Vector3.new(0, 0, 0)
    end)

    return function()
        conn:Disconnect()
        bv:Destroy()
    end
end)

--============================================================
-- NOFALL — from VapeV4 NoFall.lua (Gravity mode)
--============================================================
register("NoFall", function(state)
    if not state then return end

    local rayParams = RaycastParams.new()
    local tracked = 0
    local extraGravity = 0

    local conn = RunService.PreSimulation:Connect(function(dt)
        local char = lplr.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not root or not humanoid or humanoid.Health <= 0 then return end

        if root.AssemblyLinearVelocity.Y < -85 then
            rayParams.FilterDescendantsInstances = { char, Workspace.CurrentCamera }
            rayParams.CollisionGroup = root.CollisionGroup
            local rootSize = root.Size.Y / 2 + humanoid.HipHeight

            local ray = Workspace:Blockcast(
                root.CFrame,
                Vector3.new(3, 3, 3),
                Vector3.new(0, (tracked * 0.1) - rootSize, 0),
                rayParams
            )

            if not ray then
                root.AssemblyLinearVelocity = Vector3.new(
                    root.AssemblyLinearVelocity.X, -86, root.AssemblyLinearVelocity.Z)
                root.CFrame = root.CFrame + Vector3.new(0, extraGravity * dt, 0)
                extraGravity = extraGravity + (-Workspace.Gravity * dt)
            else
                extraGravity = 0
            end
        end
        tracked = tracked + 1
    end)

    return function() conn:Disconnect() end
end)

--============================================================
-- OTHER MODULES (simplified from VapeV4 patterns)
--============================================================
register("AntiFall", function(state)
    if not state then return end
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude
    local platform = nil
    local lastSafeY = 0

    local conn = RunService.Heartbeat:Connect(function()
        local char = lplr.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        rayParams.FilterDescendantsInstances = { char }
        local ray = Workspace:Raycast(root.Position + Vector3.new(0, 3, 0),
            Vector3.new(0, -120, 0), rayParams)
        if ray and ray.Instance.CanCollide then
            lastSafeY = ray.Position.Y + 4
        end

        if root.AssemblyLinearVelocity.Y < -40 then
            if not platform then
                platform = Instance.new("Part")
                platform.Size = Vector3.new(12, 1.5, 12)
                platform.Anchored = true
                platform.CanCollide = true
                platform.Transparency = 1
                platform.CanQuery = false
                platform.Parent = Workspace
            end
            platform.Position = Vector3.new(root.Position.X, lastSafeY - 1, root.Position.Z)
        elseif platform then
            platform:Destroy()
            platform = nil
        end
    end)

    return function()
        conn:Disconnect()
        if platform then platform:Destroy() end
    end
end)

register("LongJump", function(state)
    if not state then return end
    local cam = Workspace.CurrentCamera
    local speed, maxSpeed, accel = 0, 45, 2.8
    local dir = Vector3.zero

    local conn = RunService.Heartbeat:Connect(function(dt)
        local char = lplr.Character
        if not char or not char.PrimaryPart then return end
        local look = cam.CFrame.LookVector * Vector3.new(1, 0, 1)
        if look.Magnitude < 0.01 then return end
        look = look.Unit

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            speed = math.min(speed + accel * dt * 60, maxSpeed)
            dir = dir:Lerp(look, 12 * dt)
        else
            speed = math.max(speed - 1.2 * dt * 60, 0)
        end
        if speed > 0 then
            local vel = dir * speed
            local v = char.PrimaryPart.AssemblyLinearVelocity
            char.PrimaryPart.AssemblyLinearVelocity = Vector3.new(vel.X, v.Y, vel.Z)
        end
    end)

    return function() conn:Disconnect() end
end)

register("Spider", function(state)
    if not state then return end
    local conn = RunService.PreSimulation:Connect(function(dt)
        local char = lplr.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum  = char:FindFirstChildOfClass("Humanoid")
        if not root or not hum then return end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then return end

        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = { char, Workspace.CurrentCamera }

        local origin = root.Position - Vector3.new(0, hum.HipHeight - 0.5, 0)
        local hit = Workspace:Raycast(origin, hum.MoveDirection * 2.5, params)
        if hit and hit.Normal.Y == 0 then
            hum:ChangeState(Enum.HumanoidStateType.Climbing)
            root.AssemblyLinearVelocity = root.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
                + Vector3.new(0, 30, 0)
        end
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

-- Blatant (VapeV4 modules)
createToggle(Pages["Blatant"], "Speed")
createToggle(Pages["Blatant"], "Killaura")
createToggle(Pages["Blatant"], "Fly")
createToggle(Pages["Blatant"], "NoFall")
createToggle(Pages["Blatant"], "AntiFall")
createToggle(Pages["Blatant"], "LongJump")
createToggle(Pages["Blatant"], "Spider")

-- Combat
createToggle(Pages["Combat"], "TriggerBot")
createToggle(Pages["Combat"], "FastClick")
createToggle(Pages["Combat"], "HitboxExpander")

-- Movement
createToggle(Pages["Movement"], "TPWalk")
createToggle(Pages["Movement"], "JitterMove")
createToggle(Pages["Movement"], "InfiniteJump")

-- Player
createToggle(Pages["Player"], "Fullbright")
createToggle(Pages["Player"], "AutoRespawn")

-- Inputs on Blatant tab
createInput(Pages["Blatant"], "Speed (studs/sec)", Config:getValue("speed") or 23, "speed")
createInput(Pages["Blatant"], "TPWalk (studs/sec)", Config:getValue("tpwalk") or 60, "tpwalk")

--============================================================
-- SETTINGS TAB
--============================================================
do
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, -4, 0, 48)
    holder.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    holder.BackgroundTransparency = 0.26
    holder.BorderColor3 = Color3.fromRGB(62, 62, 62)
    holder.BorderSizePixel = 0
    holder.Parent = Pages["Settings"]
    Instance.new("UICorner", holder)

    local stroke = Instance.new("UIStroke", holder)
    stroke.Thickness = 2.4
    stroke.Color = Color3.fromRGB(86, 86, 86)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 0, 16)
    lbl.Position = UDim2.new(0, 8, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = "Transparency: " .. string.format("%.2f", Config.data.settings.transparency)
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.SourceSansPro
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = holder

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, -16, 0, 8)
    slider.Position = UDim2.new(0, 8, 0, 26)
    slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    slider.BorderSizePixel = 0
    slider.Parent = holder
    Instance.new("UICorner", slider)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(Config.data.settings.transparency, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(120, 130, 200)
    fill.BorderSizePixel = 0
    fill.Parent = slider
    Instance.new("UICorner", fill)

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
        b.Size = UDim2.new(0.48, -4, 0, 23)
        b.Position = UDim2.new(0, 4, 0, y)
        b.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        b.BackgroundTransparency = 0.26
        b.Text = text
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Font = Enum.Font.SourceSansPro
        b.TextSize = 13
        b.BorderSizePixel = 0
        b.Parent = Pages["Settings"]
        Instance.new("UICorner", b)

        local stroke2 = Instance.new("UIStroke", b)
        stroke2.Thickness = 2.4
        stroke2.Color = Color3.fromRGB(86, 86, 86)

        b.MouseButton1Click:Connect(cb)
        return b
    end

    actionBtn("Save Config", 52, function() Config:save() end)
    local lb = actionBtn("Load Config", 52, function()
        Config:load()
        Main.BackgroundTransparency = Config.data.settings.transparency
    end)
    lb.Position = UDim2.new(0.52, 0, 0, 52)
end

--============================================================
-- CONSOLE TAB
--============================================================
do
    local page = Pages["Console"]

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -6, 1, -70)
    scroll.Position = UDim2.new(0, 3, 0, 3)
    scroll.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 4
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.Parent = page
    Instance.new("UICorner", scroll)

    Log.listFrame = scroll

    local function btn(text, xOff, w, cb)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(w, -4, 0, 22)
        b.Position = UDim2.new(xOff, 4, 1, -26)
        b.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        b.BackgroundTransparency = 0.26
        b.Text = text
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Font = Enum.Font.SourceSansPro
        b.TextSize = 12
        b.BorderSizePixel = 0
        b.Parent = page
        Instance.new("UICorner", b)

        local stroke3 = Instance.new("UIStroke", b)
        stroke3.Thickness = 2.4
        stroke3.Color = Color3.fromRGB(86, 86, 86)

        b.MouseButton1Click:Connect(cb)
        return b
    end

    btn("Copy", 0, 0.32, function() Log:copyAll() end)
    btn("Copy Errors", 0.33, 0.32, function()
        local errs = {}
        for _, l in ipairs(Log.lines) do
            if l:find("%[ERROR%]") then table.insert(errs, l) end
        end
        if setclipboard then
            setclipboard(table.concat(errs, "\n"))
            Log:info("Copied " .. #errs .. " error lines")
        end
    end)
    btn("Clear", 0.66, 0.32, function() Log:clear(); Log:info("Console cleared") end)
end

Log:refresh()
Log:info("Prismware Revamped loaded")
Log:info("Real VapeV4 modules: Speed, Killaura, Fly, NoFall")

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
-- DEFAULT TAB + KEYBIND
--============================================================
switchTab("Blatant")

UserInputService.InputBegan:Connect(function(i, gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.RightShift then
        Main.Visible = not Main.Visible
    end
end)

Log:info("Press RightShift to toggle the window")
