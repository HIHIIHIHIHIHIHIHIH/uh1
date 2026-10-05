--[[
    PRISMWARE + TABS
    - Exact original Prismware styling (frame, buttons, gradients, strokes)
    - Tab system added at top
    - Blatant tab uses real VapeV4 Speed / Killaura / Fly / NoFall code
]]

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local HttpService       = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")

local lplr = Players.LocalPlayer
local PlayerGui = lplr:WaitForChild("PlayerGui")

--============================================================
-- CONFIG (simple)
--============================================================
local Config = {
    path = "PrismCfg.json",
    data = { toggles = {}, values = { speed = 23, tpwalk = 60 } },
}
function Config:save()
    pcall(function()
        if writefile then writefile(self.path, HttpService:JSONEncode(self.data)) end
    end)
end
function Config:load()
    pcall(function()
        if isfile and isfile(self.path) then
            local d = HttpService:JSONDecode(readfile(self.path))
            if d.toggles then self.data.toggles = d.toggles end
            if d.values  then self.data.values  = d.values  end
        end
    end)
end
function Config:get(n)      return self.data.toggles[n] == true end
function Config:set(n, s)   self.data.toggles[n] = s; self:save() end
function Config:getValue(k) return self.data.values[k] end
function Config:setValue(k, v) self.data.values[k] = v; self:save() end
Config:load()

--============================================================
-- MODULE REGISTRY
--============================================================
local Modules, Cleanups = {}, {}

local function runModule(name, state)
    if not Modules[name] then return false end
    if Cleanups[name] then pcall(Cleanups[name]); Cleanups[name] = nil end
    local ok, res = pcall(Modules[name], state)
    if not ok then
        warn("[" .. name .. "] " .. tostring(res))
        Config:set(name, false)
        return false
    end
    if state and type(res) == "function" then Cleanups[name] = res end
    return true
end

local function register(name, fn) Modules[name] = fn end

--============================================================
-- BUILD UI (EXACT PRISMWARE STYLE)
--============================================================
local G2L = {}

G2L["1"] = Instance.new("ScreenGui", PlayerGui)
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
G2L["1"]["ResetOnSpawn"] = false

-- MAIN FRAME — original size + height bump for tabs
G2L["2"] = Instance.new("Frame", G2L["1"])
G2L["2"]["BorderSizePixel"] = 0
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(181, 181, 181)
G2L["2"]["Size"] = UDim2.new(0, 420, 0, 228)
G2L["2"]["Position"] = UDim2.new(0.19025, 0, 0.30388, 0)
G2L["2"]["BorderColor3"] = Color3.fromRGB(241, 241, 241)
G2L["2"]["BackgroundTransparency"] = 0

G2L["3"] = Instance.new("UICorner", G2L["2"])

G2L["4"] = Instance.new("UIStroke", G2L["2"])
G2L["4"]["Thickness"] = 4.8
G2L["4"]["Color"] = Color3.fromRGB(255, 255, 255)

G2L["5"] = Instance.new("UIGradient", G2L["4"])
G2L["5"]["Rotation"] = -90
G2L["5"]["Color"] = ColorSequence.new{
    ColorSequenceKeypoint.new(0.000, Color3.fromRGB(94, 66, 88)),
    ColorSequenceKeypoint.new(1.000, Color3.fromRGB(169, 203, 187))
}

G2L["1e"] = Instance.new("UIGradient", G2L["2"])
G2L["1e"]["Rotation"] = -90
G2L["1e"]["Color"] = ColorSequence.new{
    ColorSequenceKeypoint.new(0.000, Color3.fromRGB(94, 66, 88)),
    ColorSequenceKeypoint.new(1.000, Color3.fromRGB(169, 203, 187))
}

--============================================================
-- TAB BAR (same styling as Prismware buttons, laid out horizontally)
--============================================================
local TAB_Y     = 6
local TAB_H     = 22
local TAB_W     = 66
local TAB_GAP   = 3
local Y_OFFSET  = 32  -- shift original buttons down by this much

local TabBar = Instance.new("Frame", G2L["2"])
TabBar.Name = "TabBar"
TabBar.BackgroundTransparency = 1
TabBar.Position = UDim2.new(0, 6, 0, TAB_Y)
TabBar.Size = UDim2.new(1, -12, 0, TAB_H)

-- helper: make a button in Prismware style
local function makePrismButton(parent, text, pos, size, cb)
    local b = Instance.new("TextButton", parent)
    b.BorderSizePixel = 0
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.TextSize = 14
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    b.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]],
        Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    b.BackgroundTransparency = 0.26
    b.Size = size
    b.BorderColor3 = Color3.fromRGB(62, 62, 62)
    b.Text = text
    b.Position = pos
    if cb then b.MouseButton1Click:Connect(cb) end

    Instance.new("UICorner", b)

    local st = Instance.new("UIStroke", b)
    st.Thickness = 2.4
    st.Color = Color3.fromRGB(86, 86, 86)

    local gr = Instance.new("UIGradient", b)
    gr.Rotation = -90
    gr.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),
        ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))
    }

    return b
end

--============================================================
-- TABS
--============================================================
local TAB_NAMES = { "Main", "Blatant", "Settings" }
local TabButtons = {}
local Pages      = {}
local ActiveTab  = "Main"

-- Page containers — invisible, just hold button references
for _, name in ipairs(TAB_NAMES) do
    Pages[name] = {}
end

-- The Main frame the widgets parent to (all buttons go in here, we just show/hide)
local ButtonHolder = Instance.new("Frame", G2L["2"])
ButtonHolder.Name = "ButtonHolder"
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Position = UDim2.new(0, 0, 0, 0)
ButtonHolder.Size = UDim2.new(1, 0, 1, 0)

local function switchTab(name)
    ActiveTab = name
    for n, page in pairs(Pages) do
        local visible = (n == name)
        for _, widget in ipairs(page) do
            if widget and widget.Parent then widget.Visible = visible end
        end
    end
    -- Highlight active tab
    for n, b in pairs(TabButtons) do
        b.BackgroundColor3 = (n == name)
            and Color3.fromRGB(120, 100, 130)
            or  Color3.fromRGB(70, 70, 70)
    end
end

-- Build tab buttons
for i, name in ipairs(TAB_NAMES) do
    local b = makePrismButton(
        TabBar,
        name,
        UDim2.new(0, (i-1) * (TAB_W + TAB_GAP), 0, 0),
        UDim2.new(0, TAB_W, 1, 0),
        function() switchTab(name) end
    )
    b.TextSize = 13
    b.TextXAlignment = Enum.TextXAlignment.Center
    TabButtons[name] = b
end

--============================================================
-- WIDGET FACTORY (adds to a page)
--============================================================
local function addButton(page, text, x, y, w, h, onClick)
    local b = makePrismButton(
        ButtonHolder,
        text,
        UDim2.new(0, x, 0, y + Y_OFFSET),
        UDim2.new(0, w, 0, h or 23),
        onClick
    )
    table.insert(Pages[page], b)
    return b
end

local function addToggle(page, name, x, y, w)
    local b = makePrismButton(
        ButtonHolder,
        name,
        UDim2.new(0, x, 0, y + Y_OFFSET),
        UDim2.new(0, w, 0, 23),
        nil
    )
    table.insert(Pages[page], b)

    local state = Config:get(name)
    local function refresh()
        b.BackgroundColor3 = state
            and Color3.fromRGB(60, 130, 80)
            or  Color3.fromRGB(70, 70, 70)
    end
    refresh()

    b.MouseButton1Click:Connect(function()
        state = not state
        local ok = runModule(name, state)
        if not ok then state = false end
        Config:set(name, state)
        refresh()
    end)
    return b
end

local function addInput(page, label, x, y, w, key, default)
    -- Prismware style: label above a small TextBox in one button-sized holder
    local holder = makePrismButton(
        ButtonHolder,
        "",
        UDim2.new(0, x, 0, y + Y_OFFSET),
        UDim2.new(0, w, 0, 40),
        nil
    )
    holder.Text = ""
    table.insert(Pages[page], holder)

    local lbl = Instance.new("TextLabel", holder)
    lbl.Size = UDim2.new(1, -8, 0, 14)
    lbl.Position = UDim2.new(0, 4, 0, 2)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.SourceSansPro
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = holder

    local box = Instance.new("TextBox", holder)
    box.Size = UDim2.new(1, -8, 0, 18)
    box.Position = UDim2.new(0, 4, 0, 18)
    box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    box.BackgroundTransparency = 0.2
    box.Text = tostring(default)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.Code
    box.TextSize = 12
    box.BorderSizePixel = 0
    box.ClearTextOnFocus = false
    box.Parent = holder
    Instance.new("UICorner", box)

    box.FocusLost:Connect(function()
        local num = tonumber(box.Text)
        if num then
            Config:setValue(key, num)
            print(label .. " = " .. num)
        else
            box.Text = tostring(Config:getValue(key))
        end
    end)
end

--============================================================
-- TAB 1: MAIN (original Prismware modules)
--============================================================
-- Column 1
addToggle("Main", "TriggerBot",   6,   7, 93)
addToggle("Main", "TPWalk",       6,  37, 93)
addToggle("Main", "JitterMove",   6,  67, 93)
addButton("Main", "PlayerPull Use /", 6, 98, 104, 23, function()
    -- /pull command: pulls nearest player toward you
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

-- Column 2
addToggle("Main", "Theme",      110,   7, 93)
addToggle("Main", "MiniGlide",  110,  37, 93)
addToggle("Main", "Spider",     110,  67, 93)
addToggle("Main", "CityBoiAura",118,  98, 85)

-- Column 3
addToggle("Main", "FarJump",    212,   7, 85)
addToggle("Main", "Anti Fall",  212,  37, 85)
addToggle("Main", "StiffSpeed", 212,  67, 85)
addToggle("Main", "FastClick",  212,  98, 85)

-- Column 4
addToggle("Main", "Speed",      306,  37, 77)
addToggle("Main", "ACPrivate",  306,  67, 77)
addToggle("Main", "NoFall",     306,  98, 57)

-- Row 5 (anticheat row)
addToggle("Main", "SpoofAC",     6, 127, 85)
addToggle("Main", "SemiDisabler",99, 127, 85)
addToggle("Main", "TPNear AC",  196, 127, 85)
addToggle("Main", "ACV2",       283, 127, 71)

--============================================================
-- TAB 2: BLATANT (Real VapeV4 modules)
--============================================================

-- SPEED — from VapeV4 Blatant/Speed.lua
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

-- KILLAURA — from VapeV4 Blatant/Killaura.lua
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

-- FLY — from VapeV4 Blatant/Fly.lua
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

-- NOFALL — from VapeV4 Blatant/NoFall.lua
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

-- TPWALK — Vape style with input
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

-- Blatant tab buttons
addToggle("Blatant", "VapeSpeed",   6,   7, 100)
addToggle("Blatant", "Killaura",    6,  37, 100)
addToggle("Blatant", "Fly",         6,  67, 100)
addToggle("Blatant", "VapeNoFall",  6,  98, 100)
addToggle("Blatant", "TPWalkVape", 110,   7, 100)

addInput("Blatant", "Speed (studs/sec)",  110, 37, 150, "speed",  Config:getValue("speed") or 23)
addInput("Blatant", "TPWalk (studs/sec)", 110, 82, 150, "tpwalk", Config:getValue("tpwalk") or 60)

--============================================================
-- TAB 3: SETTINGS
--============================================================
local noteLabel = Instance.new("TextLabel", ButtonHolder)
noteLabel.TextWrapped = true
noteLabel.BorderSizePixel = 0
noteLabel.TextSize = 11
noteLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
noteLabel.FontFace = Font.new([[rbxasset://fonts/families/Ubuntu.json]],
    Enum.FontWeight.Regular, Enum.FontStyle.Normal)
noteLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
noteLabel.BackgroundTransparency = 1
noteLabel.Size = UDim2.new(0, 240, 0, 42)
noteLabel.Text = "RightShift toggles the window. Config saves automatically to PrismCfg.json."
noteLabel.Position = UDim2.new(0, 6, 0, 6 + Y_OFFSET)
noteLabel.Parent = ButtonHolder
local noteGrad = Instance.new("UIGradient", noteLabel)
noteGrad.Rotation = -90
noteGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.000, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 129, 0))
}
table.insert(Pages["Settings"], noteLabel)

addButton("Settings", "Save Config", 6, 55, 100, 23, function()
    Config:save()
    print("[Prism] Config saved")
end)
addButton("Settings", "Load Config", 110, 55, 100, 23, function()
    Config:load()
    print("[Prism] Config loaded")
end)
addButton("Settings", "Reset All Modules", 6, 85, 204, 23, function()
    for name in pairs(Modules) do
        if Cleanups[name] then pcall(Cleanups[name]); Cleanups[name] = nil end
        Config.data.toggles[name] = false
    end
    Config:save()
    print("[Prism] All modules reset")
end)

--============================================================
-- SIMPLE FALLBACK IMPLEMENTATIONS (for Main tab toggles)
--============================================================
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

register("Theme", function(state)
    local c = lplr.Character
    if not c then return end
    local hl = game:GetService("Lighting")
    if state then
        hl.Ambient = Color3.fromRGB(140, 60, 80)
    end
    return function()
        hl.Ambient = Color3.fromRGB(70, 70, 70)
    end
end)

register("MiniGlide", function(state)
    if not state then return end
    local conn = RunService.Heartbeat:Connect(function()
        local c = lplr.Character
        if not c then return end
        local hum = c:FindFirstChildOfClass("Humanoid")
        local root = c:FindFirstChild("HumanoidRootPart")
        if hum and root and hum.FloorMaterial == Enum.Material.Air then
            local v = root.AssemblyLinearVelocity
            root.AssemblyLinearVelocity = Vector3.new(v.X, math.max(v.Y, -2), v.Z)
        end
    end)
    return function() conn:Disconnect() end
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

register("CityBoiAura", function(state) end)

register("FarJump", function(state)
    if not state then return end
    local conn = UserInputService.JumpRequest:Connect(function()
        local c = lplr.Character
        if not c then return end
        local root = c:FindFirstChild("HumanoidRootPart")
        if root then
            root.AssemblyLinearVelocity = root.AssemblyLinearVelocity
                + root.CFrame.LookVector * 80 + Vector3.new(0, 60, 0)
        end
    end)
    return function() conn:Disconnect() end
end)

register("Anti Fall", function(state)
    if not state then return end
    local conn = RunService.Heartbeat:Connect(function()
        local c = lplr.Character
        if not c then return end
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum and hum:GetState() == Enum.HumanoidStateType.Freefall then
            hum:ChangeState(Enum.HumanoidStateType.Landed)
        end
    end)
    return function() conn:Disconnect() end
end)

register("StiffSpeed", function(state)
    if not state then
        local c = lplr.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then h.PlatformStand = false; h.AutoRotate = true end
        end
        return
    end
    local conn = RunService.Heartbeat:Connect(function(dt)
        local c = lplr.Character
        if not c then return end
        local root = c:FindFirstChild("HumanoidRootPart")
        local hum  = c:FindFirstChildOfClass("Humanoid")
        if not root or not hum then return end
        hum.PlatformStand = true
        hum.AutoRotate = false
        local move = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += root.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= root.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= root.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += root.CFrame.RightVector end
        if move.Magnitude > 0 then
            root.CFrame = root.CFrame + move.Unit * 150 * dt
        end
    end)
    return function() conn:Disconnect() end
end)

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

register("NoFall", function(state)
    if not state then return end
    local conn = RunService.Heartbeat:Connect(function()
        local c = lplr.Character
        if not c then return end
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum and hum:GetState() == Enum.HumanoidStateType.Freefall then
            hum:ChangeState(Enum.HumanoidStateType.Landed)
        end
    end)
    return function() conn:Disconnect() end
end)

register("SpoofAC", function(state) end)
register("SemiDisabler", function(state) end)
register("TPNear AC", function(state) end)
register("ACV2", function(state) end)

--============================================================
-- DRAG (Prismware UIDrag)
--============================================================
do
    local UIS = UserInputService
    local frame = G2L["2"]
    local dragToggle, dragStart, startPos
    local dragSpeed = 0.15

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragToggle = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            if dragToggle then
                local delta = input.Position - dragStart
                local pos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                game:GetService("TweenService"):Create(frame,
                    TweenInfo.new(dragSpeed), {Position = pos}):Play()
            end
        end
    end)
end

--============================================================
-- INIT
--============================================================
switchTab("Main")

UserInputService.InputBegan:Connect(function(i, gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.RightShift then
        G2L["2"].Visible = not G2L["2"].Visible
    end
end)

print("[Prismware] Loaded. RightShift toggles the window.")
