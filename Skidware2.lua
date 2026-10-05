-- Prismware + Tabs (v4 — no ScrollingFrames, no layout engine, guaranteed visible)
-- Compatible with old executors: no Font.new, no FontFace, no task.defer, no AutomaticCanvasSize

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local HttpService       = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")

local lplr = Players.LocalPlayer
local PlayerGui = lplr:WaitForChild("PlayerGui")
local Camera = Workspace.CurrentCamera

local isMobile = (UserInputService.TouchEnabled == true)
    and (UserInputService.MouseEnabled ~= true)
local viewport = Camera.ViewportSize

-- Window size (fixed, simple)
local WIN_W, WIN_H = 440, 260
local scaleFactor = 1
if isMobile then
    scaleFactor = math.min(viewport.X / 500, viewport.Y / 320, 1)
    if scaleFactor < 0.6 then scaleFactor = 0.6 end
end

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
-- MODULE REGISTRY
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
-- ROOT GUI
--============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Prismware"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Size = UDim2.new(1, 0, 1, 0)
Container.BackgroundTransparency = 1
Container.Parent = ScreenGui

if isMobile then
    local s = Instance.new("UIScale")
    s.Scale = scaleFactor
    s.Parent = Container
end

-- Main frame
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.BackgroundColor3 = Color3.fromRGB(181, 181, 181)
Main.BackgroundTransparency = 0
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0, 30, 0, 60)
Main.Size = UDim2.new(0, WIN_W, 0, WIN_H)
Main.Parent = Container

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = Main

local stroke = Instance.new("UIStroke")
stroke.Thickness = 4.8
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Parent = Main

local strokeGrad = Instance.new("UIGradient")
strokeGrad.Rotation = -90
strokeGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(94, 66, 88)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(169, 203, 187))
}
strokeGrad.Parent = stroke

local mainGrad = Instance.new("UIGradient")
mainGrad.Rotation = -90
mainGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(94, 66, 88)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(169, 203, 187))
}
mainGrad.Parent = Main

--============================================================
-- TITLE BAR (y=6, h=26)
--============================================================
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TitleBar.BackgroundTransparency = 0.26
TitleBar.BorderSizePixel = 0
TitleBar.Position = UDim2.new(0, 6, 0, 6)
TitleBar.Size = UDim2.new(1, -12, 0, 26)
TitleBar.Parent = Main

Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 6)
local tbs = Instance.new("UIStroke", TitleBar)
tbs.Thickness = 2.4
tbs.Color = Color3.fromRGB(86, 86, 86)

local TitleLbl = Instance.new("TextLabel")
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text = "Prismware"
TitleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
TitleLbl.Font = Enum.Font.SourceSansPro
TitleLbl.TextSize = 14
TitleLbl.Position = UDim2.new(0, 8, 0, 0)
TitleLbl.Size = UDim2.new(1, -80, 1, 0)
TitleLbl.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
CloseBtn.BackgroundTransparency = 0.26
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansPro
CloseBtn.TextSize = 14
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(1, -24, 0, 3)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 4)
local cbs = Instance.new("UIStroke", CloseBtn)
cbs.Thickness = 2.4
cbs.Color = Color3.fromRGB(86, 86, 86)

--============================================================
-- TAB BAR (y=36, h=22) — regular Frame, manual positioning
--============================================================
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.BackgroundTransparency = 1
TabBar.Position = UDim2.new(0, 6, 0, 36)
TabBar.Size = UDim2.new(1, -12, 0, 22)
TabBar.Parent = Main

--============================================================
-- CONTENT (y=62, height = WIN_H - 68)
--============================================================
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Content.BackgroundTransparency = 0.26
Content.BorderSizePixel = 0
Content.Position = UDim2.new(0, 6, 0, 62)
Content.Size = UDim2.new(1, -12, 0, WIN_H - 68)
Content.ClipsDescendants = true
Content.Parent = Main

Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 6)
local cs = Instance.new("UIStroke", Content)
cs.Thickness = 2.4
cs.Color = Color3.fromRGB(86, 86, 86)

--============================================================
-- STYLE HELPER
--============================================================
local function applyPrismStyle(btn)
    btn.BorderSizePixel = 0
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.BackgroundTransparency = 0.26
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansPro
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Center

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

    local s = Instance.new("UIStroke", btn)
    s.Thickness = 2.4
    s.Color = Color3.fromRGB(86, 86, 86)

    local g = Instance.new("UIGradient", btn)
    g.Rotation = -90
    g.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(27, 39, 19)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(227, 234, 178))
    }
end

--============================================================
-- PAGE SYSTEM — every widget belongs to a tab
--============================================================
local Tabs = {}          -- tabname -> { widgets = {...}, tabBtn = ... }
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
    end
    for tname, tab in pairs(Tabs) do
        if tab.tabBtn then
            TweenService:Create(tab.tabBtn, TweenInfo.new(0.12), {
                BackgroundColor3 = (tname == name)
                    and Color3.fromRGB(120, 100, 130)
                    or  Color3.fromRGB(70, 70, 70),
            }):Play()
        end
    end
end

--============================================================
-- WIDGET CREATORS (all children of Content, manual position)
--============================================================
local function makeToggle(tabName, name, x, y, w, h)
    local b = Instance.new("TextButton")
    b.Text = name
    b.Position = UDim2.new(0, x, 0, y)
    b.Size = UDim2.new(0, w, 0, h or 24)
    applyPrismStyle(b)
    b.Parent = Content
    registerWidget(tabName, b)

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 8, 0, 8)
    dot.Position = UDim2.new(1, -14, 0.5, -4)
    dot.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    dot.BorderSizePixel = 0
    dot.Parent = b
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local state = Config:get(name)
    local function refresh()
        dot.BackgroundColor3 = state
            and Color3.fromRGB(90, 220, 130)
            or  Color3.fromRGB(80, 80, 80)
        TweenService:Create(b, TweenInfo.new(0.12), {
            BackgroundColor3 = state
                and Color3.fromRGB(60, 130, 80)
                or  Color3.fromRGB(70, 70, 70),
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

    return b
end

local function makeActionButton(tabName, name, x, y, w, h, onClick)
    local b = Instance.new("TextButton")
    b.Text = name
    b.Position = UDim2.new(0, x, 0, y)
    b.Size = UDim2.new(0, w, 0, h or 24)
    applyPrismStyle(b)
    b.Parent = Content
    registerWidget(tabName, b)
    b.MouseButton1Click:Connect(onClick)
    return b
end

local function makeInput(tabName, label, defaultVal, key, x, y, w, h)
    local holder = Instance.new("Frame")
    holder.Position = UDim2.new(0, x, 0, y)
    holder.Size = UDim2.new(0, w, 0, h or 40)
    holder.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    holder.BackgroundTransparency = 0.26
    holder.BorderSizePixel = 0
    holder.Parent = Content
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 4)
    local hs = Instance.new("UIStroke", holder)
    hs.Thickness = 2.4
    hs.Color = Color3.fromRGB(86, 86, 86)
    registerWidget(tabName, holder)

    local lbl = Instance.new("TextLabel")
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.SourceSansPro
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Position = UDim2.new(0, 6, 0, 1)
    lbl.Size = UDim2.new(1, -12, 0, 14)
    lbl.Parent = holder

    local box = Instance.new("TextBox")
    box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    box.BackgroundTransparency = 0.2
    box.Text = tostring(defaultVal)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.Code
    box.TextSize = 13
    box.BorderSizePixel = 0
    box.ClearTextOnFocus = false
    box.Position = UDim2.new(0, 6, 0, 16)
    box.Size = UDim2.new(1, -12, 0, (h or 40) - 20)
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
local TAB_W, TAB_GAP = 100, 4

for i, name in ipairs(TAB_NAMES) do
    Tabs[name] = Tabs[name] or { widgets = {} }
    local b = Instance.new("TextButton")
    b.Text = name
    b.Position = UDim2.new(0, (i - 1) * (TAB_W + TAB_GAP), 0, 0)
    b.Size = UDim2.new(0, TAB_W, 1, 0)
    b.TextSize = 12
    applyPrismStyle(b)
    b.Parent = TabBar
    Tabs[name].tabBtn = b
    b.MouseButton1Click:Connect(function() switchTab(name) end)
end

--============================================================
-- MODULES
--============================================================

-- VAPE SPEED (from Blatant/Speed.lua)
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

-- KILLAURA
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

-- FLY
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

-- NOFALL
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

-- TPWALK VAPE
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
-- BUILD MAIN TAB (original Prismware layout)
--============================================================
-- Column 1 (x=6, w=98)
makeToggle("Main", "TriggerBot",  6,   6, 98)
makeToggle("Main", "TPWalk",      6,  32, 98)
makeToggle("Main", "JitterMove",  6,  58, 98)
makeActionButton("Main", "PlayerPull", 6, 84, 98, 24, function()
    for _, p in Players:GetPlayers() do
        if p ~= lplr and p.Character and p.Character:FindFirstChild("HumanoidRootPart")
            and lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (p.Character.HumanoidRootPart.Position
                - lplr.Character.HumanoidRootPart.Position).Magnitude
            if dist < 50 then
                p.Character.HumanoidRootPart.CFrame =
                    lplr.Character.HumanoidRootPart.CFrame
                    + lplr.Character.HumanoidRootPart.CFrame.LookVector * 3
                break
            end
        end
    end
end)

-- Column 2 (x=110, w=98)
makeToggle("Main", "Theme",      110,   6, 98)
makeToggle("Main", "MiniGlide",  110,  32, 98)
makeToggle("Main", "Spider",     110,  58, 98)
makeToggle("Main", "CityBoiAura",110,  84, 98)

-- Column 3 (x=214, w=88)
makeToggle("Main", "FarJump",    214,   6, 88)
makeToggle("Main", "Anti Fall",  214,  32, 88)
makeToggle("Main", "StiffSpeed", 214,  58, 88)
makeToggle("Main", "FastClick",  214,  84, 88)

-- Column 4 (x=308, w=76)
makeToggle("Main", "Speed",      308,   6, 76)
makeToggle("Main", "ACPrivate",  308,  32, 76)
makeToggle("Main", "NoFall",     308,  58, 76)
makeToggle("Main", "ACV2",       308,  84, 76)

-- Row 5 (y=112)
makeToggle("Main", "SpoofAC",      6, 112, 98)
makeToggle("Main", "SemiDisabler",110, 112, 98)
makeToggle("Main", "TPNear AC",  214, 112, 88)

--============================================================
-- BUILD BLATANT TAB (real VapeV4 modules)
--============================================================
makeToggle("Blatant", "VapeSpeed",   6,   6, 110)
makeToggle("Blatant", "Killaura",    6,  32, 110)
makeToggle("Blatant", "Fly",         6,  58, 110)
makeToggle("Blatant", "VapeNoFall",  6,  84, 110)
makeToggle("Blatant", "TPWalkVape",  6, 110, 110)

makeInput("Blatant", "Speed (studs/sec)",  Config:getValue("speed") or 23,  "speed",  130,  6, 190, 42)
makeInput("Blatant", "TPWalk (studs/sec)", Config:getValue("tpwalk") or 60, "tpwalk", 130, 54, 190, 42)

--============================================================
-- BUILD SETTINGS TAB
--============================================================
makeActionButton("Settings", "Refresh Window", 6, 6, 200, 24, function()
    print("[Prism] Refreshed UI")
end)
makeActionButton("Settings", "Save Config",  6, 32, 200, 24, function()
    Config:save()
    print("[Prism] Config saved")
end)
makeActionButton("Settings", "Load Config",  6, 58, 200, 24, function()
    Config:load()
    print("[Prism] Config loaded")
end)
makeActionButton("Settings", "Reset All",    6, 84, 200, 24, function()
    for name in pairs(Modules) do
        if Cleanups[name] then pcall(Cleanups[name]); Cleanups[name] = nil end
        Config.data.toggles[name] = false
    end
    Config:save()
    print("[Prism] Reset all modules")
end)

--============================================================
-- DRAG (mouse + touch)
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

--============================================================
-- SHOW DEFAULT TAB
--============================================================
switchTab("Main")

--============================================================
-- KEYBIND
--============================================================
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        Main.Visible = not Main.Visible
    end
end)

print("[Prismware] Loaded. Mobile: " .. tostring(isMobile)
    .. " | Scale: " .. string.format("%.2f", scaleFactor))
