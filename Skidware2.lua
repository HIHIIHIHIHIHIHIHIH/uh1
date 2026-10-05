-- Prismware + Tabs (v6 — FIXED FONT ENUM, buttons now render)
local Players = game:GetService("Players")
local lplr = Players.LocalPlayer
local PlayerGui = lplr:WaitForChild("PlayerGui")

-- Destroy old
local old = PlayerGui:FindFirstChild("Prismware")
if old then old:Destroy() end

local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local HttpService       = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera

local isMobile = (UserInputService.TouchEnabled == true)
    and (UserInputService.MouseEnabled ~= true)

--============================================================
-- SAFE FONT PICKER (this was the crash!)
--============================================================
local function pickFont()
    local names = {"SourceSans", "Gotham", "Roboto", "Arial", "Code"}
    for _, n in ipairs(names) do
        local ok, f = pcall(function() return Enum.Font[n] end)
        if ok and f then return f end
    end
    return Enum.Font.Arial
end
local SAFE_FONT = pickFont()
local CODE_FONT = (function()
    local ok, f = pcall(function() return Enum.Font.Code end)
    if ok and f then return f end
    return SAFE_FONT
end)()

local WIN_W = isMobile and 320 or 440
local WIN_H = isMobile and 220 or 260

--============================================================
-- CONFIG
--============================================================
local Config = {
    path = "PrismCfg.json",
    data = { toggles = {}, values = { speed = 23, tpwalk = 60 } },
}
function Config:save()
    pcall(function()
        if type(writefile) == "function" then
            writefile(self.path, HttpService:JSONEncode(self.data))
        end
    end)
end
function Config:load()
    pcall(function()
        if type(isfile) == "function" and type(readfile) == "function"
            and isfile(self.path) then
            local d = HttpService:JSONDecode(readfile(self.path))
            if d.toggles then self.data.toggles = d.toggles end
            if d.values  then self.data.values  = d.values  end
        end
    end)
end
function Config:get(n)         return self.data.toggles[n] == true end
function Config:set(n, s)      self.data.toggles[n] = s; self:save() end
function Config:getValue(k)    return self.data.values[k] end
function Config:setValue(k, v) self.data.values[k] = v; self:save() end
Config:load()

--============================================================
-- MODULES
--============================================================
local Modules, Cleanups = {}, {}
local function register(name, fn) Modules[name] = fn end
local function runModule(name, state)
    if not Modules[name] then return false end
    if Cleanups[name] then pcall(Cleanups[name]); Cleanups[name] = nil end
    local ok, res = pcall(Modules[name], state)
    if not ok then warn("[" .. name .. "] " .. tostring(res)); Config:set(name, false); return false end
    if state and type(res) == "function" then Cleanups[name] = res end
    return true
end

--============================================================
-- GUI
--============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Prismware"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 10
ScreenGui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.BackgroundColor3 = Color3.fromRGB(60, 60, 68)
Main.BackgroundTransparency = 0
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0, 30, 0, 100)
Main.Size = UDim2.new(0, WIN_W, 0, WIN_H)
Main.ZIndex = 1
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
local mainStroke = Instance.new("UIStroke", Main)
mainStroke.Thickness = 3
mainStroke.Color = Color3.fromRGB(180, 160, 190)

-- Title bar
local TitleBar = Instance.new("Frame")
TitleBar.BackgroundColor3 = Color3.fromRGB(85, 85, 95)
TitleBar.BorderSizePixel = 0
TitleBar.Position = UDim2.new(0, 6, 0, 6)
TitleBar.Size = UDim2.new(1, -12, 0, 24)
TitleBar.ZIndex = 2
TitleBar.Parent = Main
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 6)

local TitleLbl = Instance.new("TextLabel")
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text = "Prismware"
TitleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
TitleLbl.Font = SAFE_FONT
TitleLbl.TextSize = 14
TitleLbl.Position = UDim2.new(0, 8, 0, 0)
TitleLbl.Size = UDim2.new(1, -80, 1, 0)
TitleLbl.ZIndex = 3
TitleLbl.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.BackgroundColor3 = Color3.fromRGB(140, 60, 60)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = SAFE_FONT
CloseBtn.TextSize = 14
CloseBtn.Position = UDim2.new(1, -22, 0, 2)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.ZIndex = 3
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 4)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui.Enabled = false end)

-- Tab bar
local TabBar = Instance.new("Frame")
TabBar.BackgroundTransparency = 1
TabBar.Position = UDim2.new(0, 6, 0, 34)
TabBar.Size = UDim2.new(1, -12, 0, 22)
TabBar.ZIndex = 2
TabBar.Parent = Main

-- Content
local Content = Instance.new("Frame")
Content.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
Content.BorderSizePixel = 0
Content.Position = UDim2.new(0, 6, 0, 60)
Content.Size = UDim2.new(1, -12, 1, -66)
Content.ZIndex = 2
Content.Parent = Main
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 6)

--============================================================
-- STYLE
--============================================================
local function styleButton(btn)
    btn.BorderSizePixel = 0
    btn.BackgroundColor3 = Color3.fromRGB(100, 100, 110)
    btn.BackgroundTransparency = 0
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = SAFE_FONT
    btn.TextSize = 12
    btn.ZIndex = 3

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 4)
    c.Parent = btn

    local s = Instance.new("UIStroke")
    s.Thickness = 1.5
    s.Color = Color3.fromRGB(150, 150, 170)
    s.Parent = btn
end

--============================================================
-- TAB SYSTEM
--============================================================
local Tabs = {}
local ActiveTab = "Main"

local function registerWidget(tabName, widget)
    if not Tabs[tabName] then Tabs[tabName] = { widgets = {} } end
    table.insert(Tabs[tabName].widgets, widget)
    widget.Visible = (tabName == ActiveTab)
end

local function switchTab(name)
    ActiveTab = name
    for tname, tab in pairs(Tabs) do
        local visible = (tname == name)
        for _, w in ipairs(tab.widgets) do
            w.Visible = visible
        end
        if tab.tabBtn then
            tab.tabBtn.BackgroundColor3 = (tname == name)
                and Color3.fromRGB(140, 110, 150)
                or  Color3.fromRGB(80, 80, 90)
        end
    end
end

--============================================================
-- WIDGETS
--============================================================
local function makeToggle(tabName, name, x, y, w, h)
    local b = Instance.new("TextButton")
    b.Text = name
    b.Position = UDim2.new(0, x, 0, y)
    b.Size = UDim2.new(0, w, 0, h or 22)
    styleButton(b)
    b.Parent = Content
    registerWidget(tabName, b)

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 8, 0, 8)
    dot.Position = UDim2.new(1, -12, 0.5, -4)
    dot.BackgroundColor3 = Color3.fromRGB(90, 90, 100)
    dot.BorderSizePixel = 0
    dot.ZIndex = 4
    dot.Parent = b
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local state = Config:get(name)
    local function refresh()
        dot.BackgroundColor3 = state
            and Color3.fromRGB(90, 220, 130)
            or  Color3.fromRGB(90, 90, 100)
        b.BackgroundColor3 = state
            and Color3.fromRGB(60, 140, 90)
            or  Color3.fromRGB(100, 100, 110)
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
    return b
end

local function makeActionButton(tabName, name, x, y, w, h, onClick)
    local b = Instance.new("TextButton")
    b.Text = name
    b.Position = UDim2.new(0, x, 0, y)
    b.Size = UDim2.new(0, w, 0, h or 22)
    styleButton(b)
    b.Parent = Content
    registerWidget(tabName, b)
    b.MouseButton1Click:Connect(onClick)
    return b
end

local function makeInput(tabName, label, defaultVal, key, x, y, w, h)
    local holder = Instance.new("Frame")
    holder.Position = UDim2.new(0, x, 0, y)
    holder.Size = UDim2.new(0, w, 0, h or 42)
    holder.BackgroundColor3 = Color3.fromRGB(100, 100, 110)
    holder.BorderSizePixel = 0
    holder.ZIndex = 3
    holder.Parent = Content
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 4)
    local hs = Instance.new("UIStroke", holder)
    hs.Thickness = 1.5
    hs.Color = Color3.fromRGB(150, 150, 170)
    registerWidget(tabName, holder)

    local lbl = Instance.new("TextLabel")
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = SAFE_FONT
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Position = UDim2.new(0, 6, 0, 1)
    lbl.Size = UDim2.new(1, -12, 0, 14)
    lbl.ZIndex = 4
    lbl.Parent = holder

    local box = Instance.new("TextBox")
    box.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    box.Text = tostring(defaultVal)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = CODE_FONT
    box.TextSize = 13
    box.BorderSizePixel = 0
    box.ClearTextOnFocus = false
    box.Position = UDim2.new(0, 6, 0, 17)
    box.Size = UDim2.new(1, -12, 0, (h or 42) - 22)
    box.ZIndex = 4
    box.Parent = holder
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 3)

    box.FocusLost:Connect(function()
        local num = tonumber(box.Text)
        if num then
            Config:setValue(key, num)
            print("[Prism] " .. label .. " = " .. tostring(num))
        else
            box.Text = tostring(Config:getValue(key))
        end
    end)
    return holder
end

--============================================================
-- TAB BUTTONS
--============================================================
local TAB_NAMES = { "Main", "Blatant", "Settings" }
local TAB_W = isMobile and 68 or 90
local TAB_GAP = 4

for i, name in ipairs(TAB_NAMES) do
    Tabs[name] = Tabs[name] or { widgets = {} }
    local b = Instance.new("TextButton")
    b.Text = name
    b.Position = UDim2.new(0, (i - 1) * (TAB_W + TAB_GAP), 0, 0)
    b.Size = UDim2.new(0, TAB_W, 1, 0)
    b.TextSize = 12
    styleButton(b)
    b.Parent = TabBar
    Tabs[name].tabBtn = b
    b.MouseButton1Click:Connect(function() switchTab(name) end)
end

--============================================================
-- MODULE IMPLEMENTATIONS
--============================================================

-- VapeSpeed
register("VapeSpeed", function(state)
    if not state then
        local c = lplr.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed = 16 end
        end
        return
    end
    local rayCheck = RaycastParams.new()
    rayCheck.RespectCanCollide = true
    local frictionParts = {}

    local function updateFriction(enable)
        if not enable then
            for p, old in pairs(frictionParts) do
                if p and p.Parent then p.CustomPhysicalProperties = old end
            end
            frictionParts = {}
            return
        end
        local c = lplr.Character
        if not c then return end
        for _, part in ipairs(c:GetDescendants()) do
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
        local c = lplr.Character
        if not c then return end
        local root = c:FindFirstChild("HumanoidRootPart")
        local hum  = c:FindFirstChildOfClass("Humanoid")
        if not root or not hum or hum.Health <= 0 then return end
        local st = hum:GetState()
        if st == Enum.HumanoidStateType.Climbing then return end
        local velo = (root.AssemblyLinearVelocity * Vector3.new(1,0,1)).Magnitude
        local moveDir = hum.MoveDirection
        local target = Config:getValue("speed") or 23
        local dest = moveDir * math.max(target - velo, 0) * dt
        rayCheck.FilterDescendantsInstances = { c, Workspace.CurrentCamera }
        rayCheck.CollisionGroup = root.CollisionGroup
        local ray = Workspace:Raycast(root.Position, dest, rayCheck)
        if ray then dest = (ray.Position + ray.Normal) - root.Position end
        root.CFrame = root.CFrame + dest
        root.AssemblyLinearVelocity = (moveDir * velo) + Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)
        if (st == Enum.HumanoidStateType.Running or st == Enum.HumanoidStateType.Landed)
            and moveDir ~= Vector3.zero then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
    return function() conn:Disconnect(); updateFriction(false) end
end)

-- Killaura
register("Killaura", function(state)
    if not state then return end
    local remote = ReplicatedStorage:FindFirstChild("AttackEntity", true)
        or ReplicatedStorage:FindFirstChild("SwordRemote", true)
    if not remote then warn("Killaura: remote not found") return end
    local conn = RunService.Heartbeat:Connect(function()
        local c = lplr.Character
        if not c or not c.PrimaryPart then return end
        local tool = c:FindFirstChildWhichIsA("Tool")
        if not tool then return end
        local selfpos = c.PrimaryPart.Position
        local facing = c.PrimaryPart.CFrame.LookVector * Vector3.new(1,0,1)
        local best, bestD = nil, math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p == lplr or not p.Character or not p.Character.PrimaryPart then continue end
            local h = p.Character:FindFirstChildOfClass("Humanoid")
            if not h or h.Health <= 0 then continue end
            local delta = p.Character.PrimaryPart.Position - selfpos
            local d = delta.Magnitude
            if d > 28 then continue end
            local ang = math.acos(math.clamp(facing:Dot((delta * Vector3.new(1,0,1)).Unit), -1, 1))
            if ang > math.rad(180) then continue end
            if d < bestD then best, bestD = p, d end
        end
        if best then
            local tr = best.Character.PrimaryPart
            local dir = CFrame.lookAt(selfpos, tr.Position).LookVector
            local pos = selfpos + dir * math.max(bestD - 14.399, 0)
            pcall(function()
                remote:FireServer({
                    weapon = tool,
                    chargedAttack = { chargeRatio = 0 },
                    entityInstance = best.Character,
                    validate = {
                        raycast = { cameraPosition = { value = pos }, cursorDirection = { value = dir } },
                        targetPosition = { value = tr.Position },
                        selfPosition = { value = pos }
                    }
                })
            end)
            c.PrimaryPart.CFrame = CFrame.lookAt(selfpos,
                Vector3.new(tr.Position.X, selfpos.Y + 0.001, tr.Position.Z))
        end
    end)
    return function() conn:Disconnect() end
end)

-- Fly
register("Fly", function(state)
    if not state then
        local c = lplr.Character
        if c and c.PrimaryPart then
            local bv = c.PrimaryPart:FindFirstChild("PrismFly")
            if bv then bv:Destroy() end
        end
        return
    end
    local c = lplr.Character
    if not c or not c.PrimaryPart then return end
    local bv = Instance.new("BodyVelocity")
    bv.Name = "PrismFly"
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Velocity = Vector3.zero
    bv.Parent = c.PrimaryPart
    local cam = Workspace.CurrentCamera
    local conn = RunService.PreSimulation:Connect(function()
        local ch = lplr.Character
        if not ch or not ch.PrimaryPart or not bv.Parent then return end
        bv.Velocity = cam.CFrame.LookVector * 50
    end)
    return function() conn:Disconnect(); bv:Destroy() end
end)

-- NoFall
register("VapeNoFall", function(state)
    if not state then return end
    local rayParams = RaycastParams.new()
    local tracked, extraGravity = 0, 0
    local conn = RunService.PreSimulation:Connect(function(dt)
        local c = lplr.Character
        if not c then return end
        local root = c:FindFirstChild("HumanoidRootPart")
        local hum  = c:FindFirstChildOfClass("Humanoid")
        if not root or not hum then return end
        if root.AssemblyLinearVelocity.Y < -85 then
            rayParams.FilterDescendantsInstances = { c, Workspace.CurrentCamera }
            local rSize = root.Size.Y/2 + hum.HipHeight
            local ray = Workspace:Blockcast(root.CFrame, Vector3.new(3,3,3),
                Vector3.new(0, (tracked*0.1) - rSize, 0), rayParams)
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

register("TPWalkVape", function(state)
    if not state then return end
    local conn = RunService.Heartbeat:Connect(function(dt)
        local c = lplr.Character
        if not c then return end
        local root = c:FindFirstChild("HumanoidRootPart")
        local hum  = c:FindFirstChildOfClass("Humanoid")
        if root and hum and hum.MoveDirection.Magnitude > 0 then
            local sp = Config:getValue("tpwalk") or 60
            root.CFrame = root.CFrame + hum.MoveDirection * sp * dt
        end
    end)
    return function() conn:Disconnect() end
end)

-- Fallbacks
register("TriggerBot", function(state)
    if not state then return end
    local mouse = lplr:GetMouse()
    local last = 0
    local conn = RunService.Heartbeat:Connect(function()
        if tick() - last < 0.08 then return end
        if not mouse.Target then return end
        local m = mouse.Target:FindFirstAncestorWhichIsA("Model")
        if not m then return end
        local h = m:FindFirstChildOfClass("Humanoid")
        if not h or h.Health <= 0 then return end
        local p = Players:GetPlayerFromCharacter(m)
        if not p or p == lplr then return end
        local mr = lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart")
        local tr = m:FindFirstChild("HumanoidRootPart")
        if mr and tr and (mr.Position - tr.Position).Magnitude <= 20 then
            mouse1click(); last = tick()
        end
    end)
    return function() conn:Disconnect() end
end)

register("TPWalk", function(state)
    if not state then return end
    local conn = RunService.Heartbeat:Connect(function(dt)
        local c = lplr.Character
        if not c then return end
        local root = c:FindFirstChild("HumanoidRootPart")
        local hum  = c:FindFirstChildOfClass("Humanoid")
        if root and hum and hum.MoveDirection.Magnitude > 0 then
            root.CFrame = root.CFrame + hum.MoveDirection * 60 * dt
        end
    end)
    return function() conn:Disconnect() end
end)

register("JitterMove", function(state)
    if not state then return end
    local conn = RunService.Heartbeat:Connect(function()
        local c = lplr.Character
        if not c then return end
        local root = c:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = root.CFrame
                + Vector3.new(math.random(-10,10)/100, 0, math.random(-10,10)/100)
        end
    end)
    return function() conn:Disconnect() end
end)

register("Theme", function(state) end)
register("MiniGlide", function(state) end)
register("Spider", function(state) end)
register("CityBoiAura", function(state) end)
register("FarJump", function(state) end)
register("Anti Fall", function(state) end)
register("StiffSpeed", function(state) end)
register("FastClick", function(state) end)
register("Speed", function(state)
    if not state then
        local c = lplr.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed = 16 end
        end
        return
    end
    local c = lplr.Character
    if c then
        local h = c:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = 50 end
    end
    return function()
        local cc = lplr.Character
        if cc then
            local h = cc:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed = 16 end
        end
    end
end)
register("ACPrivate", function(state) end)
register("NoFall", function(state) end)
register("SpoofAC", function(state) end)
register("SemiDisabler", function(state) end)
register("TPNear AC", function(state) end)
register("ACV2", function(state) end)

--============================================================
-- BUILD BUTTONS
--============================================================
local C1, C2, C3, C4 = 6, 110, 210, 300
local R1, R2, R3, R4, R5 = 4, 30, 56, 82, 108
local W1, W2, W3 = 100, 96, 84

-- Main
makeToggle("Main", "TriggerBot", C1, R1, W1)
makeToggle("Main", "TPWalk",     C1, R2, W1)
makeToggle("Main", "JitterMove", C1, R3, W1)
makeActionButton("Main", "PlayerPull", C1, R4, W1, 22, function()
    for _, p in Players:GetPlayers() do
        if p ~= lplr and p.Character and p.Character:FindFirstChild("HumanoidRootPart")
            and lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") then
            p.Character.HumanoidRootPart.CFrame =
                lplr.Character.HumanoidRootPart.CFrame
                + lplr.Character.HumanoidRootPart.CFrame.LookVector * 3
            break
        end
    end
end)

makeToggle("Main", "Theme",      C2, R1, W2)
makeToggle("Main", "MiniGlide",  C2, R2, W2)
makeToggle("Main", "Spider",     C2, R3, W2)
makeToggle("Main", "CityBoiAura",C2, R4, W2)

makeToggle("Main", "FarJump",    C3, R1, W3)
makeToggle("Main", "Anti Fall",  C3, R2, W3)
makeToggle("Main", "StiffSpeed", C3, R3, W3)
makeToggle("Main", "FastClick",  C3, R4, W3)

makeToggle("Main", "Speed",      C4, R1, 68)
makeToggle("Main", "ACPrivate",  C4, R2, 68)
makeToggle("Main", "NoFall",     C4, R3, 68)
makeToggle("Main", "ACV2",       C4, R4, 68)

makeToggle("Main", "SpoofAC",     C1, R5, W1)
makeToggle("Main", "SemiDisabler",C2, R5, W2)
makeToggle("Main", "TPNear AC",   C3, R5, W3)

-- Blatant
makeToggle("Blatant", "VapeSpeed",  C1, R1, 120)
makeToggle("Blatant", "Killaura",   C1, R2, 120)
makeToggle("Blatant", "Fly",        C1, R3, 120)
makeToggle("Blatant", "VapeNoFall", C1, R4, 120)
makeToggle("Blatant", "TPWalkVape", C1, R5, 120)

makeInput("Blatant", "Speed (studs/sec)",  Config:getValue("speed") or 23,  "speed",  140, R1, 150, 42)
makeInput("Blatant", "TPWalk (studs/sec)", Config:getValue("tpwalk") or 60, "tpwalk", 140, R1 + 46, 150, 42)

-- Settings
makeActionButton("Settings", "Refresh Window", C1, R1, 180, 22, function()
    print("[Prism] Refreshed")
end)
makeActionButton("Settings", "Save Config",  C1, R2, 180, 22, function()
    Config:save(); print("[Prism] Saved")
end)
makeActionButton("Settings", "Load Config",  C1, R3, 180, 22, function()
    Config:load(); print("[Prism] Loaded")
end)
makeActionButton("Settings", "Reset All",    C1, R4, 180, 22, function()
    for name in pairs(Modules) do
        if Cleanups[name] then pcall(Cleanups[name]); Cleanups[name] = nil end
        Config.data.toggles[name] = false
    end
    Config:save()
    print("[Prism] Reset all")
end)

--============================================================
-- INIT
--============================================================
switchTab("Main")

--============================================================
-- DRAG
--============================================================
do
    local dragging, dragStart, startPos
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- Keybind
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

print("[Prismware] Loaded on " .. (isMobile and "mobile" or "PC")
    .. " | Font: " .. tostring(SAFE_FONT))
