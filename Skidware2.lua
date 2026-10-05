--[[
    PRISMWARE REVAMPED v3
    Fixed-size UI (no deferred recalc) + auto-fit window
    Modules: Real VapeV4 Speed / Killaura / Fly / NoFall
]]

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local HttpService       = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local Lighting          = game:GetService("Lighting")

local lplr = Players.LocalPlayer
local PlayerGui = lplr:WaitForChild("PlayerGui")

--============================================================
-- LOGGER
--============================================================
local Log = { lines = {}, listFrame = nil, maxLines = 300 }

function Log:add(level, msg)
    local line = string.format("[%s] [%s] %s", os.date("%H:%M:%S"), level, tostring(msg))
    table.insert(self.lines, line)
    if #self.lines > self.maxLines then table.remove(self.lines, 1) end
    print(line)
    self:refresh()
end
function Log:info(m)  self:add("INFO", m) end
function Log:warn(m)  self:add("WARN", m) end
function Log:error(m) self:add("ERROR", m) end

function Log:refresh()
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
end

function Log:copyAll()
    if setclipboard then
        setclipboard(table.concat(self.lines, "\n"))
        self:info("Copied " .. #self.lines .. " lines")
    else
        self:warn("setclipboard unavailable")
    end
end
function Log:clear() self.lines = {}; self:refresh() end

--============================================================
-- CONFIG
--============================================================
local Config = {
    path = "PrismwareCfg.json",
    data = {
        toggles  = {},
        settings = { transparency = 0.08, autoSave = true },
        values   = { speed = 23, tpwalk = 60 },
    },
}
function Config:save()
    pcall(function()
        if writefile then writefile(self.path, HttpService:JSONEncode(self.data)) end
    end)
end
function Config:load()
    pcall(function()
        if isfile and isfile(self.path) then
            local dec = HttpService:JSONDecode(readfile(self.path))
            if dec.toggles  then self.data.toggles  = dec.toggles  end
            if dec.settings then self.data.settings = dec.settings end
            if dec.values   then self.data.values   = dec.values   end
        end
    end)
end
function Config:get(n)        return self.data.toggles[n] == true end
function Config:set(n, s)
    self.data.toggles[n] = s
    if self.data.settings.autoSave then self:save() end
end
function Config:getValue(k)   return self.data.values[k] end
function Config:setValue(k,v)
    self.data.values[k] = v
    if self.data.settings.autoSave then self:save() end
end
Config:load()

--============================================================
-- MODULE REGISTRY
--============================================================
local Modules, ActiveCleanup = {}, {}
local function register(name, fn) Modules[name] = fn end

local function runModule(name, state)
    if not Modules[name] then return false end
    if state then
        if ActiveCleanup[name] then pcall(ActiveCleanup[name]); ActiveCleanup[name] = nil end
        local ok, result = pcall(Modules[name], true)
        if not ok then
            Log:error("[" .. name .. "] " .. tostring(result))
            Config:set(name, false)
            return false
        end
        if type(result) == "function" then ActiveCleanup[name] = result end
        Log:info("[" .. name .. "] ON")
    else
        if ActiveCleanup[name] then pcall(ActiveCleanup[name]); ActiveCleanup[name] = nil end
        local ok, err = pcall(Modules[name], false)
        if not ok then Log:error("[" .. name .. "] " .. tostring(err)) end
        Log:info("[" .. name .. "] OFF")
    end
    return true
end

--============================================================
-- UI CONSTANTS
--============================================================
local UI_W        = 560
local UI_H        = 400
local PAD         = 6
local TITLE_H     = 28
local TAB_H       = 24
local TAB_W       = 84
local TAB_GAP     = 3
local TOP_CONTENT = PAD + TITLE_H + 4 + TAB_H + 4

--============================================================
-- ROOT
--============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Prismware"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, UI_W, 0, UI_H)
Main.Position = UDim2.new(0.5, -UI_W/2, 0.5, -UI_H/2)
Main.BackgroundColor3 = Color3.fromRGB(165, 165, 172)
Main.BackgroundTransparency = Config.data.settings.transparency
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main)

local MainGrad = Instance.new("UIGradient", Main)
MainGrad.Rotation = -90
MainGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(94, 66, 88)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(169, 203, 187))
}

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 3
MainStroke.Color = Color3.fromRGB(255, 255, 255)

--============================================================
-- TITLE BAR
--============================================================
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, -PAD*2, 0, TITLE_H)
TitleBar.Position = UDim2.new(0, PAD, 0, PAD)
TitleBar.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TitleBar.BackgroundTransparency = 0.15
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main
Instance.new("UICorner", TitleBar)

local TitleLbl = Instance.new("TextLabel")
TitleLbl.Size = UDim2.new(1, -80, 1, 0)
TitleLbl.Position = UDim2.new(0, 10, 0, 0)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text = "Prismware"
TitleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLbl.Font = Enum.Font.SourceSansPro
TitleLbl.TextSize = 14
TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
TitleLbl.Parent = TitleBar

local function titleBtn(txt, xOff, bgColor, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 20, 0, 20)
    b.Position = UDim2.new(1, xOff, 0, 4)
    b.BackgroundColor3 = bgColor
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansPro
    b.TextSize = 13
    b.BorderSizePixel = 0
    b.Parent = TitleBar
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
    return b
end

titleBtn("X", -24, Color3.fromRGB(140, 60, 60), function() ScreenGui:Destroy() end)
titleBtn("-", -48, Color3.fromRGB(140, 120, 60), function() Main.Visible = false end)

-- Reopen
local ReopenBtn = Instance.new("TextButton")
ReopenBtn.Size = UDim2.new(0, 40, 0, 40)
ReopenBtn.Position = UDim2.new(0, 20, 0.5, -20)
ReopenBtn.BackgroundColor3 = Color3.fromRGB(120, 130, 200)
ReopenBtn.Text = "P"
ReopenBtn.TextColor3 = Color3.new(1, 1, 1)
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
-- TAB BAR (manual positioning)
--============================================================
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Size = UDim2.new(1, -PAD*2, 0, TAB_H)
TabBar.Position = UDim2.new(0, PAD, 0, PAD + TITLE_H + 4)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Main

--============================================================
-- CONTENT
--============================================================
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -PAD*2, 1, -(TOP_CONTENT + PAD))
Content.Position = UDim2.new(0, PAD, 0, TOP_CONTENT)
Content.BackgroundColor3 = Color3.fromRGB(70, 70, 75)
Content.BackgroundTransparency = 0.2
Content.BorderSizePixel = 0
Content.Parent = Main
Instance.new("UICorner", Content)
local ContentStroke = Instance.new("UIStroke", Content)
ContentStroke.Thickness = 1.5
ContentStroke.Color = Color3.fromRGB(120, 120, 140)

--============================================================
-- PAGE / TAB BUTTON BUILDERS
--============================================================
local Pages       = {}
local TabButtons  = {}
local TabOrder    = {}

local function buildPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.new(1, -8, 1, -8)
    page.Position = UDim2.new(0, 4, 0, 4)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(140, 140, 160)
    page.ScrollingDirection = Enum.ScrollingDirection.Y
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.Parent = Content

    local lay = Instance.new("UIListLayout", page)
    lay.Padding = UDim.new(0, 4)
    lay.SortOrder = Enum.SortOrder.LayoutOrder

    Pages[name] = page
    table.insert(TabOrder, name)
end

local function switchTab(name)
    for n, p in pairs(Pages) do p.Visible = (n == name) end
    for n, b in pairs(TabButtons) do
        TweenService:Create(b, TweenInfo.new(0.15), {
            BackgroundColor3 = (n == name)
                and Color3.fromRGB(110, 120, 190)
                or  Color3.fromRGB(70, 70, 80),
        }):Play()
    end
end

local function buildTabButton(name, index)
    local b = Instance.new("TextButton")
    b.Name = name
    b.Size = UDim2.new(0, TAB_W, 1, 0)
    b.Position = UDim2.new(0, (index - 1) * (TAB_W + TAB_GAP), 0, 0)
    b.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
    b.Text = name
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansPro
    b.TextSize = 13
    b.BorderSizePixel = 0
    b.Parent = TabBar
    Instance.new("UICorner", b)

    local st = Instance.new("UIStroke", b)
    st.Thickness = 2
    st.Color = Color3.fromRGB(120, 120, 140)

    b.MouseButton1Click:Connect(function() switchTab(name) end)
    TabButtons[name] = b
end

--============================================================
-- WIDGETS
--============================================================
local function createToggle(page, name)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 26)
    b.BackgroundColor3 = Color3.fromRGB(80, 80, 95)
    b.Text = name
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansPro
    b.TextSize = 13
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.BorderSizePixel = 0
    b.Parent = page
    Instance.new("UICorner", b)

    local stroke = Instance.new("UIStroke", b)
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(120, 120, 140)

    local pad = Instance.new("UIPadding", b)
    pad.PaddingLeft = UDim.new(0, 10)

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 10, 0, 10)
    dot.Position = UDim2.new(1, -18, 0.5, -5)
    dot.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
    dot.BorderSizePixel = 0
    dot.Parent = b
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local state = Config:get(name)
    local function refresh()
        dot.BackgroundColor3 = state and Color3.fromRGB(90, 220, 130) or Color3.fromRGB(80, 80, 90)
        TweenService:Create(b, TweenInfo.new(0.15), {
            BackgroundColor3 = state and Color3.fromRGB(60, 130, 80) or Color3.fromRGB(80, 80, 95),
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
    holder.Size = UDim2.new(1, 0, 0, 52)
    holder.BackgroundColor3 = Color3.fromRGB(80, 80, 95)
    holder.BorderSizePixel = 0
    holder.Parent = page
    Instance.new("UICorner", holder)
    local stroke = Instance.new("UIStroke", holder)
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(120, 120, 140)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 0, 18)
    lbl.Position = UDim2.new(0, 8, 0, 2)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(230, 230, 245)
    lbl.Font = Enum.Font.SourceSansPro
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = holder

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, -16, 0, 24)
    box.Position = UDim2.new(0, 8, 0, 22)
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
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
            Log:info(label .. " = " .. num)
        else
            box.Text = tostring(Config:getValue(key))
            Log:warn("Invalid number")
        end
    end)
end

--============================================================
-- AUTO-FIT HEIGHT
--============================================================
local function recalcHeight()
    local maxH = 200
    for _, page in pairs(Pages) do
        local lay = page:FindFirstChildOfClass("UIListLayout")
        if lay then
            maxH = math.max(maxH, lay.AbsoluteContentSize.Y)
        end
    end
    local newH = math.clamp(TOP_CONTENT + maxH + PAD + 20, 320, 720)
    Main.Size = UDim2.new(0, UI_W, 0, newH)
    Log:info("Window fit -> " .. math.floor(newH) .. "px tall")
end

--============================================================
-- MODULES — REAL VAPEV4 CODE
--============================================================

-- SPEED — adapted from Blatant/Speed.lua
register("Speed", function(state)
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

-- KILLAURA — adapted from Blatant/Killaura.lua
register("Killaura", function(state)
    if not state then return end
    local remote = ReplicatedStorage:FindFirstChild("AttackEntity", true)
        or ReplicatedStorage:FindFirstChild("SwordRemote", true)
    if not remote then Log:warn("Killaura: remote not found") return end

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

-- FLY — adapted from Blatant/Fly.lua
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

-- NOFALL — adapted from Blatant/NoFall.lua
register("NoFall", function(state)
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

-- TPWALK — Vape-style with input
register("TPWalk", function(state)
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

-- Simple stubs
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

register("Fullbright", function(state)
    local oa, ob = Lighting.Ambient, Lighting.Brightness
    if state then
        Lighting.Ambient = Color3.fromRGB(180,180,180)
        Lighting.Brightness = 3
    else
        Lighting.Ambient = oa
        Lighting.Brightness = ob
    end
end)

register("InfiniteJump", function(state)
    if not state then return end
    local conn = UserInputService.JumpRequest:Connect(function()
        local c = lplr.Character
        local h = c and c:FindFirstChildOfClass("Humanoid")
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
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

for i, n in ipairs(TabOrder) do
    buildTabButton(n, i)
end

-- Blatant
createToggle(Pages["Blatant"], "Speed")
createInput (Pages["Blatant"], "Speed (studs/sec)",  Config:getValue("speed") or 23, "speed")
createToggle(Pages["Blatant"], "Killaura")
createToggle(Pages["Blatant"], "Fly")
createToggle(Pages["Blatant"], "NoFall")
createToggle(Pages["Blatant"], "TPWalk")
createInput (Pages["Blatant"], "TPWalk (studs/sec)", Config:getValue("tpwalk") or 60, "tpwalk")

-- Combat
createToggle(Pages["Combat"], "TriggerBot")

-- Movement
createToggle(Pages["Movement"], "InfiniteJump")

-- Player
createToggle(Pages["Player"], "Fullbright")

--============================================================
-- SETTINGS TAB
--============================================================
do
    local page = Pages["Settings"]

    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, 0, 0, 50)
    holder.BackgroundColor3 = Color3.fromRGB(80, 80, 95)
    holder.BorderSizePixel = 0
    holder.Parent = page
    Instance.new("UICorner", holder)
    local st = Instance.new("UIStroke", holder)
    st.Thickness = 2; st.Color = Color3.fromRGB(120, 120, 140)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 0, 18)
    lbl.Position = UDim2.new(0, 8, 0, 2)
    lbl.BackgroundTransparency = 1
    lbl.Text = "Transparency: " .. string.format("%.2f", Config.data.settings.transparency)
    lbl.TextColor3 = Color3.fromRGB(230, 230, 245)
    lbl.Font = Enum.Font.SourceSansPro
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = holder

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, -16, 0, 10)
    slider.Position = UDim2.new(0, 8, 0, 24)
    slider.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
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

    local function actionBtn(text, order, cb)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 0, 26)
        b.BackgroundColor3 = Color3.fromRGB(80, 80, 95)
        b.Text = text
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Font = Enum.Font.SourceSansPro
        b.TextSize = 13
        b.BorderSizePixel = 0
        b.LayoutOrder = order
        b.Parent = page
        Instance.new("UICorner", b)
        local st2 = Instance.new("UIStroke", b)
        st2.Thickness = 2; st2.Color = Color3.fromRGB(120, 120, 140)
        b.MouseButton1Click:Connect(cb)
    end

    actionBtn("Fit Window to Content", 100, recalcHeight)
    actionBtn("Save Config", 101, function() Config:save() Log:info("Saved") end)
    actionBtn("Load Config", 102, function()
        Config:load()
        Main.BackgroundTransparency = Config.data.settings.transparency
        Log:info("Loaded")
    end)
    actionBtn("Reset All Modules", 103, function()
        for name in pairs(Modules) do
            if ActiveCleanup[name] then pcall(ActiveCleanup[name]); ActiveCleanup[name] = nil end
            Config.data.toggles[name] = false
        end
        Config:save()
        Log:info("All modules reset")
    end)
end

--============================================================
-- CONSOLE TAB
--============================================================
do
    local page = Pages["Console"]

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 0, 220)
    scroll.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 4
    scroll.ScrollingDirection = Enum.ScrollingDirection.Y
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.LayoutOrder = 1
    scroll.Parent = page
    Instance.new("UICorner", scroll)

    local pad = Instance.new("UIPadding", scroll)
    pad.PaddingTop = UDim.new(0, 4)
    pad.PaddingBottom = UDim.new(0, 4)
    pad.PaddingLeft = UDim.new(0, 4)
    pad.PaddingRight = UDim.new(0, 4)

    local lay = Instance.new("UIListLayout", scroll)
    lay.Padding = UDim.new(0, 0)

    Log.listFrame = scroll

    local function btn(text, order, cb)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 0, 24)
        b.BackgroundColor3 = Color3.fromRGB(80, 80, 95)
        b.Text = text
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Font = Enum.Font.SourceSansPro
        b.TextSize = 12
        b.BorderSizePixel = 0
        b.LayoutOrder = order
        b.Parent = page
        Instance.new("UICorner", b)
        local st = Instance.new("UIStroke", b)
        st.Thickness = 2; st.Color = Color3.fromRGB(120, 120, 140)
        b.MouseButton1Click:Connect(cb)
    end

    btn("Copy Full Log", 2, function() Log:copyAll() end)
    btn("Copy Errors Only", 3, function()
        local errs = {}
        for _, l in ipairs(Log.lines) do
            if l:find("%[ERROR%]") then table.insert(errs, l) end
        end
        if setclipboard then
            setclipboard(table.concat(errs, "\n"))
            Log:info("Copied " .. #errs .. " errors")
        end
    end)
    btn("Clear Console", 4, function() Log:clear(); Log:info("Cleared") end)
end

--============================================================
-- DRAG
--============================================================
do
    local dragging, dragStart, startPos
    TitleBar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = i.Position
            startPos = Main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
            or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - dragStart
            Main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

--============================================================
-- INIT
--============================================================
Log:info("Prismware v3 loaded")
Log:info("Tabs: " .. table.concat(TabOrder, ", "))

-- Default tab
switchTab("Blatant")

-- Auto-fit the window height based on tallest page
task.spawn(function()
    task.wait(0.3)
    local ok, err = pcall(recalcHeight)
    if not ok then Log:error("recalcHeight: " .. tostring(err)) end
    task.wait(0.3)
    pcall(recalcHeight)
end)

-- Keybind
UserInputService.InputBegan:Connect(function(i, gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.RightShift then
        Main.Visible = not Main.Visible
    end
end)

Log:info("RightShift toggles the window")
