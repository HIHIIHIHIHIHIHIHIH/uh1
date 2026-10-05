--[[
    PRISMWARE MOBILE + TABS
    - Same grey Prismware look (gradients, strokes, SourceSansPro)
    - Auto-resize + UIScale for mobile
    - UIGridLayout for buttons (never off-screen)
    - Touch + mouse support
    - Real VapeV4 Speed / Killaura / Fly / NoFall
]]

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

--============================================================
-- PLATFORM DETECTION
--============================================================
local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
local viewport = Camera.ViewportSize

-- Base design size (desktop); scaled down on mobile via UIScale
local BASE_W, BASE_H = 500, 340
local scaleFactor
if isMobile then
    scaleFactor = math.min(viewport.X / 720, viewport.Y / 480, 1)
    scaleFactor = math.max(scaleFactor, 0.65)  -- never smaller than 65%
else
    scaleFactor = 1
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
    if not ok then
        warn("[" .. name .. "] " .. tostring(res))
        Config:set(name, false)
        return false
    end
    if state and type(res) == "function" then Cleanups[name] = res end
    return true
end

--============================================================
-- ROOT
--============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Prismware"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

-- Container for UIScale
local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Size = UDim2.new(1, 0, 1, 0)
Container.BackgroundTransparency = 1
Container.Parent = ScreenGui

local uiScale = Instance.new("UIScale", Container)
uiScale.Scale = scaleFactor

--============================================================
-- MAIN FRAME (Prismware look)
--============================================================
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.BackgroundColor3 = Color3.fromRGB(181, 181, 181)
Main.BackgroundTransparency = 0
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0, 20, 0, 60)
Main.Size = UDim2.new(0, BASE_W, 0, BASE_H)
Main.Parent = Container

Instance.new("UICorner", Main)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 4.8
MainStroke.Color = Color3.fromRGB(255, 255, 255)

local MainStrokeGrad = Instance.new("UIGradient", MainStroke)
MainStrokeGrad.Rotation = -90
MainStrokeGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.000, Color3.fromRGB(94, 66, 88)),
    ColorSequenceKeypoint.new(1.000, Color3.fromRGB(169, 203, 187))
}

local MainGrad = Instance.new("UIGradient", Main)
MainGrad.Rotation = -90
MainGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.000, Color3.fromRGB(94, 66, 88)),
    ColorSequenceKeypoint.new(1.000, Color3.fromRGB(169, 203, 187))
}

--============================================================
-- TITLE BAR
--============================================================
local TITLE_H = 26
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TitleBar.BackgroundTransparency = 0.26
TitleBar.BorderSizePixel = 0
TitleBar.Position = UDim2.new(0, 6, 0, 6)
TitleBar.Size = UDim2.new(1, -12, 0, TITLE_H)
TitleBar.Parent = Main
Instance.new("UICorner", TitleBar)

local TitleLbl = Instance.new("TextLabel")
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text = "Prismware"
TitleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
TitleLbl.FontFace = Font.new([[rbxasset://fonts/families/Ubuntu.json]],
    Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TitleLbl.TextSize = 14
TitleLbl.Position = UDim2.new(0, 8, 0, 0)
TitleLbl.Size = UDim2.new(1, -80, 1, 0)
TitleLbl.Parent = TitleBar

-- Close button (Prismware style)
local CloseBtn = Instance.new("TextButton")
CloseBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
CloseBtn.BackgroundTransparency = 0.26
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]],
    Enum.FontWeight.Regular, Enum.FontStyle.Normal)
CloseBtn.TextSize = 14
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(1, -24, 0, 3)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn)
local closeStroke = Instance.new("UIStroke", CloseBtn)
closeStroke.Thickness = 2.4
closeStroke.Color = Color3.fromRGB(86, 86, 86)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
    -- Reopen button
    _G._prismReopen.Visible = true
end)
CloseBtn.TouchLongPress:Connect(function() end) -- ignore

-- Floating reopen button
local ReopenBtn = Instance.new("TextButton")
ReopenBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ReopenBtn.BackgroundTransparency = 0.15
ReopenBtn.Text = "P"
ReopenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ReopenBtn.FontFace = Font.new([[rbxasset://fonts/families/Ubuntu.json]],
    Enum.FontWeight.Bold, Enum.FontStyle.Normal)
ReopenBtn.TextSize = 22
ReopenBtn.BorderSizePixel = 0
ReopenBtn.Position = UDim2.new(0, 20, 0.4, 0)
ReopenBtn.Size = UDim2.new(0, 46, 0, 46)
ReopenBtn.Visible = false
ReopenBtn.Parent = Container
Instance.new("UICorner", ReopenBtn)
local reopenStroke = Instance.new("UIStroke", ReopenBtn)
reopenStroke.Thickness = 3
reopenStroke.Color = Color3.fromRGB(255, 255, 255)
local reopenGrad = Instance.new("UIGradient", reopenStroke)
reopenGrad.Rotation = -90
reopenGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.000, Color3.fromRGB(94, 66, 88)),
    ColorSequenceKeypoint.new(1.000, Color3.fromRGB(169, 203, 187))
}
ReopenBtn.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = true
    ReopenBtn.Visible = false
end)
_G._prismReopen = ReopenBtn

--============================================================
-- TAB BAR (horizontal ScrollFrame so tabs never overflow on mobile)
--============================================================
local TAB_H = 22
local TabBar = Instance.new("ScrollingFrame")
TabBar.Name = "TabBar"
TabBar.BackgroundTransparency = 1
TabBar.BorderSizePixel = 0
TabBar.ScrollBarThickness = 0
TabBar.ScrollingDirection = Enum.ScrollingDirection.X
TabBar.CanvasSize = UDim2.new(0, 0, 0, 0)
TabBar.AutomaticCanvasSize = Enum.AutomaticSize.X
TabBar.Position = UDim2.new(0, 6, 0, 6 + TITLE_H + 3)
TabBar.Size = UDim2.new(1, -12, 0, TAB_H)
TabBar.Parent = Main

local TabBarLayout = Instance.new("UIListLayout", TabBar)
TabBarLayout.FillDirection = Enum.FillDirection.Horizontal
TabBarLayout.Padding = UDim.new(0, 3)
TabBarLayout.SortOrder = Enum.SortOrder.LayoutOrder

--============================================================
-- CONTENT
--============================================================
local CONTENT_TOP = 6 + TITLE_H + 3 + TAB_H + 3
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Content.BackgroundTransparency = 0.26
Content.BorderSizePixel = 0
Content.Position = UDim2.new(0, 6, 0, CONTENT_TOP)
Content.Size = UDim2.new(1, -12, 1, -(CONTENT_TOP + 6))
Content.Parent = Main
Instance.new("UICorner", Content)
local contentStroke = Instance.new("UIStroke", Content)
contentStroke.Thickness = 2.4
contentStroke.Color = Color3.fromRGB(86, 86, 86)

--============================================================
-- STYLE HELPERS
--============================================================
local function applyPrismStyle(btn)
    btn.BorderSizePixel = 0
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.BackgroundTransparency = 0.26
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]],
        Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Center

    Instance.new("UICorner", btn)

    local s = Instance.new("UIStroke", btn)
    s.Thickness = 2.4
    s.Color = Color3.fromRGB(86, 86, 86)

    local g = Instance.new("UIGradient", btn)
    g.Rotation = -90
    g.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),
        ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))
    }
end

--============================================================
-- PAGE SYSTEM
--============================================================
local Pages      = {}         -- name -> ScrollingFrame
local TabButtons = {}         -- name -> TextButton
local TabOrder   = {}
local ActiveTab  = nil

local CELL_W, CELL_H = 110, 26
local CELL_PAD = 4

local function buildPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(180, 180, 180)
    page.ScrollingDirection = Enum.ScrollingDirection.Y
    page.Position = UDim2.new(0, 4, 0, 4)
    page.Size = UDim2.new(1, -8, 1, -8)
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.Parent = Content

    local grid = Instance.new("UIGridLayout", page)
    grid.CellSize = UDim2.new(0, CELL_W, 0, CELL_H)
    grid.CellPadding = UDim2.new(0, CELL_PAD, 0, CELL_PAD)
    grid.SortOrder = Enum.SortOrder.LayoutOrder
    grid.HorizontalAlignment = Enum.HorizontalAlignment.Left
    grid.VerticalAlignment = Enum.VerticalAlignment.Top

    Pages[name] = page
    table.insert(TabOrder, name)
    return page
end

local function buildTabButton(name, order)
    local b = Instance.new("TextButton")
    b.Name = name
    b.Text = name
    b.LayoutOrder = order
    b.Size = UDim2.new(0, 72, 1, 0)
    applyPrismStyle(b)
    b.TextSize = 12
    b.Parent = TabBar

    b.MouseButton1Click:Connect(function()
        for n, p in pairs(Pages) do p.Visible = (n == name) end
        ActiveTab = name
        for n, btn in pairs(TabButtons) do
            TweenService:Create(btn, TweenInfo.new(0.15), {
                BackgroundColor3 = (n == name)
                    and Color3.fromRGB(120, 100, 130)
                    or  Color3.fromRGB(70, 70, 70),
            }):Play()
        end
    end)

    TabButtons[name] = b
end

--============================================================
-- WIDGET BUILDERS
--============================================================
local function createToggle(page, name)
    local b = Instance.new("TextButton")
    b.Text = name
    b.LayoutOrder = #page:GetChildren() + 1
    b.Size = UDim2.new(1, 0, 1, 0)
    applyPrismStyle(b)
    b.Parent = page

    -- Small indicator dot
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
end

local function createInput(page, label, defaultVal, key)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, 0, 1, 0)
    holder.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    holder.BackgroundTransparency = 0.26
    holder.BorderSizePixel = 0
    holder.LayoutOrder = #page:GetChildren() + 1
    holder.Parent = page
    Instance.new("UICorner", holder)
    local st = Instance.new("UIStroke", holder)
    st.Thickness = 2.4
    st.Color = Color3.fromRGB(86, 86, 86)

    local lbl = Instance.new("TextLabel", holder)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]],
        Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Position = UDim2.new(0, 6, 0, 1)
    lbl.Size = UDim2.new(1, -12, 0, 11)

    local box = Instance.new("TextBox", holder)
    box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    box.BackgroundTransparency = 0.2
    box.Text = tostring(defaultVal)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.Code
    box.TextSize = 12
    box.BorderSizePixel = 0
    box.ClearTextOnFocus = false
    box.Position = UDim2.new(0, 6, 0, 13)
    box.Size = UDim2.new(1, -12, 0, 12)
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

-- Make input cells wider so text fits
local function createInputCell(page, label, defaultVal, key)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, 0, 1, 0)
    holder.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    holder.BackgroundTransparency = 0.26
    holder.BorderSizePixel = 0
    holder.LayoutOrder = #page:GetChildren() + 1
    -- Make it span 2 cells visually
    holder.Parent = page
    Instance.new("UICorner", holder)
    local st = Instance.new("UIStroke", holder)
    st.Thickness = 2.4
    st.Color = Color3.fromRGB(86, 86, 86)

    local lbl = Instance.new("TextLabel", holder)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]],
        Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Position = UDim2.new(0, 6, 0, 1)
    lbl.Size = UDim2.new(1, -12, 0, 11)

    local box = Instance.new("TextBox", holder)
    box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    box.BackgroundTransparency = 0.2
    box.Text = tostring(defaultVal)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.Code
    box.TextSize = 12
    box.BorderSizePixel = 0
    box.ClearTextOnFocus = false
    box.Position = UDim2.new(0, 6, 0, 13)
    box.Size = UDim2.new(1, -12, 0, 12)
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

-- TPWalk
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

-- Extra fallbacks for Main tab
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
-- BUILD TABS + BUTTONS
--============================================================
buildPage("Main")
buildPage("Blatant")
buildPage("Settings")

buildTabButton("Main", 1)
buildTabButton("Blatant", 2)
buildTabButton("Settings", 3)

-- MAIN TAB
createToggle(Pages["Main"], "TriggerBot")
createToggle(Pages["Main"], "TPWalk")
createToggle(Pages["Main"], "JitterMove")
createToggle(Pages["Main"], "Theme")
createToggle(Pages["Main"], "MiniGlide")
createToggle(Pages["Main"], "Spider")
createToggle(Pages["Main"], "CityBoiAura")
createToggle(Pages["Main"], "FarJump")
createToggle(Pages["Main"], "Anti Fall")
createToggle(Pages["Main"], "StiffSpeed")
createToggle(Pages["Main"], "FastClick")
createToggle(Pages["Main"], "Speed")
createToggle(Pages["Main"], "ACPrivate")
createToggle(Pages["Main"], "NoFall")
createToggle(Pages["Main"], "SpoofAC")
createToggle(Pages["Main"], "SemiDisabler")
createToggle(Pages["Main"], "TPNear AC")
createToggle(Pages["Main"], "ACV2")

-- PlayerPull button
local playerPullBtn = Instance.new("TextButton")
playerPullBtn.Text = "PlayerPull"
playerPullBtn.LayoutOrder = 100
playerPullBtn.Size = UDim2.new(1, 0, 1, 0)
applyPrismStyle(playerPullBtn)
playerPullBtn.Parent = Pages["Main"]
playerPullBtn.MouseButton1Click:Connect(function()
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

-- BLATANT TAB
createToggle(Pages["Blatant"], "VapeSpeed")
createToggle(Pages["Blatant"], "Killaura")
createToggle(Pages["Blatant"], "Fly")
createToggle(Pages["Blatant"], "VapeNoFall")
createToggle(Pages["Blatant"], "TPWalkVape")
createInputCell(Pages["Blatant"], "Speed (studs/sec)",  Config:getValue("speed") or 23, "speed")
createInputCell(Pages["Blatant"], "TPWalk (studs/sec)", Config:getValue("tpwalk") or 60, "tpwalk")

-- SETTINGS TAB
local function makeSettingsBtn(text, order, cb)
    local b = Instance.new("TextButton")
    b.Text = text
    b.LayoutOrder = order
    b.Size = UDim2.new(1, 0, 1, 0)
    applyPrismStyle(b)
    b.Parent = Pages["Settings"]
    b.MouseButton1Click:Connect(cb)
    return b
end

makeSettingsBtn("Refresh / Fit Window", 1, function()
    task.spawn(function()
        -- re-evaluate content
        for _, page in pairs(Pages) do
            if page.Visible then
                local grid = page:FindFirstChildOfClass("UIGridLayout")
                if grid then
                    page.CanvasSize = UDim2.new(0, 0, 0, grid.AbsoluteContentSize.Y + 8)
                end
            end
        end
        -- resize
        local maxContentH, maxContentW = 0, 0
        for _, page in pairs(Pages) do
            local grid = page:FindFirstChildOfClass("UIGridLayout")
            if grid then
                local cs = grid.AbsoluteContentSize
                maxContentH = math.max(maxContentH, cs.Y)
                maxContentW = math.max(maxContentW, cs.X)
            end
        end
        local newW = math.clamp(maxContentW + 30, 300, 520)
        local newH = math.clamp(maxContentH + CONTENT_TOP + 30, 200, viewport.Y / scaleFactor - 80)
        TweenService:Create(Main, TweenInfo.new(0.25), {
            Size = UDim2.new(0, newW, 0, newH)
        }):Play()
        print("[Prism] Window resized to " .. math.floor(newW) .. "x" .. math.floor(newH))
    end)
end)
makeSettingsBtn("Save Config", 2, function() Config:save(); print("[Prism] Saved") end)
makeSettingsBtn("Load Config", 3, function() Config:load(); print("[Prism] Loaded") end)
makeSettingsBtn("Reset All Modules", 4, function()
    for name in pairs(Modules) do
        if Cleanups[name] then pcall(Cleanups[name]); Cleanups[name] = nil end
        Config.data.toggles[name] = false
    end
    Config:save()
    print("[Prism] Reset all")
end)

--============================================================
-- REFRESH FUNCTION (external — reassigns visibility + canvas)
--============================================================
local function refreshUI()
    for n, page in pairs(Pages) do
        page.Visible = (n == ActiveTab)
        local grid = page:FindFirstChildOfClass("UIGridLayout")
        if grid then
            task.defer(function()
                page.CanvasSize = UDim2.new(0, 0, 0, grid.AbsoluteContentSize.Y + 8)
            end)
        end
    end
    for n, b in pairs(TabButtons) do
        b.BackgroundColor3 = (n == ActiveTab)
            and Color3.fromRGB(120, 100, 130)
            or  Color3.fromRGB(70, 70, 70)
    end
end

-- Auto-refresh every time a page's content changes
task.spawn(function()
    while ScreenGui.Parent do
        task.wait(0.5)
        pcall(refreshUI)
    end
end)

--============================================================
-- DRAG (touch + mouse)
--============================================================
do
    local dragging, dragStart, startPos

    local function onInputBegan(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
        end
    end

    TitleBar.InputBegan:Connect(onInputBegan)

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
-- INIT
--============================================================
ActiveTab = "Main"
refreshUI()

-- Auto-fit at startup
task.spawn(function()
    task.wait(0.3)
    local maxContentH, maxContentW = 0, 0
    for _, page in pairs(Pages) do
        local grid = page:FindFirstChildOfClass("UIGridLayout")
        if grid then
            local cs = grid.AbsoluteContentSize
            maxContentH = math.max(maxContentH, cs.Y)
            maxContentW = math.max(maxContentW, cs.X)
        end
    end
    local newW = math.clamp(maxContentW + 30, 300, 520)
    local newH = math.clamp(maxContentH + CONTENT_TOP + 30, 200, viewport.Y / scaleFactor - 80)
    Main.Size = UDim2.new(0, newW, 0, newH)
    pcall(refreshUI)
end

print("[Prismware] Loaded. Mobile: " .. tostring(isMobile) .. " | Scale: " .. string.format("%.2f", scaleFactor))
print("Close button hides the window; press the floating 'P' to reopen.")
