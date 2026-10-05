--[[
    PRISMWARE REVAMPED v2
    UI: Prismware (old Skidware) style, rebuilt with auto-resize
    Modules: Real VapeV4 code (Speed.lua, Killaura.lua, Fly.lua, NoFall.lua)
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
local Logger = {}
Logger.__index = Logger
function Logger.new()
    return setmetatable({ lines = {}, maxLines = 300, listFrame = nil }, Logger)
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
    task.defer(function()
        if self.listFrame and self.listFrame.Parent then
            local layout = self.listFrame:FindFirstChildOfClass("UIListLayout")
            local h = layout and layout.AbsoluteContentSize.Y or 0
            self.listFrame.CanvasSize = UDim2.new(0, 0, 0, h + 8)
            self.listFrame.CanvasPosition = Vector2.new(0, math.max(0, h + 8 - self.listFrame.AbsoluteSize.Y))
        end
    end)
end

function Logger:getAll() return table.concat(self.lines, "\n") end
function Logger:copyAll()
    if setclipboard then
        setclipboard(self:getAll())
        self:info("Copied " .. #self.lines .. " lines")
    else
        self:warn("setclipboard unavailable")
    end
end
function Logger:clear() self.lines = {}; self:refresh() end

local Log = Logger.new()

--============================================================
-- CONFIG
--============================================================
local Config = {
    path = "PrismwareCfg.json",
    data = {
        toggles  = {},
        settings = { transparency = 0.05, autoSave = true },
        values   = { speed = 23, tpwalk = 60 },
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
            local dec = HttpService:JSONDecode(readfile(self.path))
            if dec.toggles  then self.data.toggles  = dec.toggles  end
            if dec.settings then self.data.settings = dec.settings end
            if dec.values   then self.data.values   = dec.values   end
            Log:info("Config loaded")
        end
    end)
end
function Config:get(name)     return self.data.toggles[name] == true end
function Config:set(name, s)
    self.data.toggles[name] = s
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
local Modules       = {}
local ActiveCleanup = {}
local function register(name, fn) Modules[name] = fn end

local function runModule(name, state)
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
-- UI
--============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Prismware"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

-- Layout constants
local TAB_W        = 84
local TAB_H        = 24
local TAB_PAD      = 3
local TITLE_H      = 28
local CONTENT_PAD  = 6
local TOP_PAD      = 6

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.BackgroundColor3 = Color3.fromRGB(160, 160, 168)
Main.BackgroundTransparency = Config.data.settings.transparency
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Parent = ScreenGui
Instance.new("UICorner", Main)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 3
MainStroke.Color = Color3.fromRGB(255, 255, 255)
local MainGradStroke = Instance.new("UIGradient", MainStroke)
MainGradStroke.Rotation = -90
MainGradStroke.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(94, 66, 88)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(169, 203, 187))
}
local MainGrad = Instance.new("UIGradient", Main)
MainGrad.Rotation = -90
MainGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(94, 66, 88)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(169, 203, 187))
}

-- Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TitleBar.BackgroundTransparency = 0.2
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main
Instance.new("UICorner", TitleBar)

local Title = Instance.new("TextLabel")
Title.BackgroundTransparency = 1
Title.Text = "Prismware"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansPro
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local function titleBtn(txt, color, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 20, 0, 20)
    b.BackgroundColor3 = color
    b.BackgroundTransparency = 0.2
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansPro
    b.TextSize = 13
    b.BorderSizePixel = 0
    b.Parent = TitleBar
    Instance.new("UICorner", b)
    local st = Instance.new("UIStroke", b)
    st.Thickness = 1.5
    st.Color = Color3.fromRGB(86, 86, 86)
    b.MouseButton1Click:Connect(cb)
    return b
end

local CloseBtn = titleBtn("X", Color3.fromRGB(140, 60, 60), function() ScreenGui:Destroy() end)
local MinBtn   = titleBtn("-", Color3.fromRGB(140, 120, 60), function() Main.Visible = false end)

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

-- Tab container (grid, wraps!)
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.BackgroundTransparency = 1
TabBar.Parent = Main
local TabGrid = Instance.new("UIGridLayout", TabBar)
TabGrid.CellSize = UDim2.new(0, TAB_W, 0, TAB_H)
TabGrid.CellPadding = UDim2.new(0, TAB_PAD, 0, TAB_PAD)
TabGrid.SortOrder = Enum.SortOrder.LayoutOrder

-- Content
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Content.BackgroundTransparency = 0.2
Content.BorderSizePixel = 0
Content.Parent = Main
Instance.new("UICorner", Content)
local ContentStroke = Instance.new("UIStroke", Content)
ContentStroke.Thickness = 1.5
ContentStroke.Color = Color3.fromRGB(86, 86, 86)

local Pages = {}
local TabButtons = {}
local ActiveTabName = nil
local TabOrder = {}
local CONTENT_MIN_H = 220

-- Forward declarations
local recalcLayout

local function buildPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 120)
    page.ScrollingDirection = Enum.ScrollingDirection.Y
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.Parent = Content

    local pad = Instance.new("UIPadding", page)
    pad.PaddingTop = UDim.new(0, 4)
    pad.PaddingBottom = UDim.new(0, 4)
    pad.PaddingLeft = UDim.new(0, 4)
    pad.PaddingRight = UDim.new(0, 4)

    local lay = Instance.new("UIListLayout", page)
    lay.Padding = UDim.new(0, 4)
    lay.SortOrder = Enum.SortOrder.LayoutOrder

    Pages[name] = page
    table.insert(TabOrder, name)
    return page
end

local function buildTabButton(name)
    local b = Instance.new("TextButton")
    b.Name = name
    b.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    b.BackgroundTransparency = 0.2
    b.Text = name
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansPro
    b.TextSize = 13
    b.BorderSizePixel = 0
    b.Parent = TabBar
    Instance.new("UICorner", b)
    local st = Instance.new("UIStroke", b)
    st.Thickness = 2
    st.Color = Color3.fromRGB(86, 86, 86)

    b.MouseButton1Click:Connect(function()
        for n, p in pairs(Pages) do p.Visible = (n == name) end
        ActiveTabName = name
        for n, btn in pairs(TabButtons) do
            TweenService:Create(btn, TweenInfo.new(0.15), {
                BackgroundColor3 = (n == name) and Color3.fromRGB(110, 120, 190) or Color3.fromRGB(70, 70, 70),
            }):Play()
        end
    end)
    TabButtons[name] = b
end

--============================================================
-- WIDGETS
--============================================================
local function forceCanvas(page)
    task.defer(function()
        if not page or not page.Parent then return end
        local lay = page:FindFirstChildOfClass("UIListLayout")
        if lay then
            page.CanvasSize = UDim2.new(0, 0, 0, lay.AbsoluteContentSize.Y + 12)
        end
    end)
end

local function createToggle(parent, name)
    local page = parent
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 26)
    b.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
    b.BackgroundTransparency = 0.1
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
    stroke.Color = Color3.fromRGB(110, 110, 130)

    local pad = Instance.new("UIPadding", b)
    pad.PaddingLeft = UDim.new(0, 10)

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 10, 0, 10)
    dot.Position = UDim2.new(1, -18, 0.5, -5)
    dot.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    dot.BorderSizePixel = 0
    dot.Parent = b
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local state = Config:get(name)
    local function refresh()
        dot.BackgroundColor3 = state and Color3.fromRGB(80, 220, 120) or Color3.fromRGB(80, 80, 80)
        TweenService:Create(b, TweenInfo.new(0.15), {
            BackgroundColor3 = state and Color3.fromRGB(60, 130, 80) or Color3.fromRGB(80, 80, 90),
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

    forceCanvas(page)
end

local function createInput(parent, label, defaultVal, key)
    local page = parent
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, 0, 0, 52)
    holder.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
    holder.BackgroundTransparency = 0.1
    holder.BorderSizePixel = 0
    holder.Parent = page
    Instance.new("UICorner", holder)
    local stroke = Instance.new("UIStroke", holder)
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(110, 110, 130)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 0, 18)
    lbl.Position = UDim2.new(0, 8, 0, 2)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
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
    box.PlaceholderText = "number"
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
            Log:warn("Invalid number for " .. label)
        end
    end)

    forceCanvas(page)
end

--============================================================
-- AUTO-RESIZE
--============================================================
function recalcLayout()
    -- Tab grid height (wraps to multiple rows if needed)
    local n = #TabOrder
    local perRow = math.max(1, math.floor((Main.AbsoluteSize.X - CONTENT_PAD * 2 + TAB_PAD) / (TAB_W + TAB_PAD)))
    -- Use target width instead of AbsoluteSize since we are resizing
    local targetW = math.max(Main.AbsoluteSize.X, 480)
    perRow = math.max(1, math.floor((targetW - CONTENT_PAD * 2 + TAB_PAD) / (TAB_W + TAB_PAD)))
    local rows = math.ceil(n / perRow)
    local tabH = rows * (TAB_H + TAB_PAD) - TAB_PAD

    -- Content height from largest page
    local maxContentH = CONTENT_MIN_H
    for _, page in pairs(Pages) do
        local lay = page:FindFirstChildOfClass("UIListLayout")
        if lay then
            maxContentH = math.max(maxContentH, lay.AbsoluteContentSize.Y + 16)
        end
    end

    local totalH = TOP_PAD + TITLE_H + 6 + tabH + CONTENT_PAD + maxContentH + CONTENT_PAD
    local totalW = math.max(480, CONTENT_PAD * 2 + perRow * (TAB_W + TAB_PAD) - TAB_PAD)
    totalW = math.max(totalW, 480)

    -- Apply
    Main.Size = UDim2.new(0, totalW, 0, totalH)

    TitleBar.Size  = UDim2.new(1, -CONTENT_PAD * 2, 0, TITLE_H)
    TitleBar.Position = UDim2.new(0, CONTENT_PAD, 0, TOP_PAD)

    Title.Size = UDim2.new(1, -80, 1, 0)
    Title.Position = UDim2.new(0, 8, 0, 0)

    CloseBtn.Position = UDim2.new(1, -22, 0, 4)
    MinBtn.Position   = UDim2.new(1, -46, 0, 4)

    TabBar.Size = UDim2.new(1, -CONTENT_PAD * 2, 0, tabH)
    TabBar.Position = UDim2.new(0, CONTENT_PAD, 0, TOP_PAD + TITLE_H + 6)

    Content.Size = UDim2.new(1, -CONTENT_PAD * 2, 0, maxContentH + CONTENT_PAD * 2)
    Content.Position = UDim2.new(0, CONTENT_PAD, 0, TOP_PAD + TITLE_H + 6 + tabH + CONTENT_PAD)

    for _, page in pairs(Pages) do
        page.Size = UDim2.new(1, 0, 1, 0)
        page.Position = UDim2.new(0, 0, 0, 0)
    end
end

-- Auto-recalc whenever AbsoluteSize changes internally
Main:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
    -- debounce
    if Main:GetAttribute("resizing") then return end
    Main:SetAttribute("resizing", true)
    task.delay(0.05, function()
        Main:SetAttribute("resizing", false)
    end)
end)

--============================================================
-- MODULES — REAL VAPEV4 CODE
--============================================================

-- Speed (from Blatant/Speed.lua)
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
                if part and part.Parent then part.CustomPhysicalProperties = old end
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
        local st = humanoid:GetState()
        if st == Enum.HumanoidStateType.Climbing then return end

        local velo = (root.AssemblyLinearVelocity * Vector3.new(1,0,1)).Magnitude
        local moveDir = humanoid.MoveDirection
        local target = Config:getValue("speed") or 23
        local destination = moveDir * math.max(target - velo, 0) * dt

        rayCheck.FilterDescendantsInstances = { char, Workspace.CurrentCamera }
        rayCheck.CollisionGroup = root.CollisionGroup
        local ray = Workspace:Raycast(root.Position, destination, rayCheck)
        if ray then destination = (ray.Position + ray.Normal) - root.Position end

        root.CFrame = root.CFrame + destination
        root.AssemblyLinearVelocity = (moveDir * velo) + Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)

        if (st == Enum.HumanoidStateType.Running or st == Enum.HumanoidStateType.Landed)
            and moveDir ~= Vector3.zero then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)

    return function() conn:Disconnect(); updateFriction(false) end
end)

-- Killaura (from Blatant/Killaura.lua)
register("Killaura", function(state)
    if not state then return end
    local AttackRemote = ReplicatedStorage:FindFirstChild("AttackEntity", true)
        or ReplicatedStorage:FindFirstChild("SwordRemote", true)
    if not AttackRemote then Log:warn("Killaura: remote not found") return end

    local conn = RunService.Heartbeat:Connect(function()
        local char = lplr.Character
        if not char or not char.PrimaryPart then return end
        local tool = char:FindFirstChildWhichIsA("Tool")
        if not tool then return end

        local selfpos = char.PrimaryPart.Position
        local facing = char.PrimaryPart.CFrame.LookVector * Vector3.new(1,0,1)

        local best, bestD = nil, math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p == lplr or not p.Character or not p.Character.PrimaryPart then continue end
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if not hum or hum.Health <= 0 then continue end
            local delta = p.Character.PrimaryPart.Position - selfpos
            local d = delta.Magnitude
            if d > 28 then continue end
            local ang = math.acos(math.clamp(facing:Dot((delta * Vector3.new(1,0,1)).Unit), -1, 1))
            if ang > math.rad(180) then continue end
            if d < bestD then best, bestD = p, d end
        end

        if best then
            local tRoot = best.Character.PrimaryPart
            local dir = CFrame.lookAt(selfpos, tRoot.Position).LookVector
            local pos = selfpos + dir * math.max(bestD - 14.399, 0)
            pcall(function()
                AttackRemote:FireServer({
                    weapon = tool,
                    chargedAttack = { chargeRatio = 0 },
                    entityInstance = best.Character,
                    validate = {
                        raycast = { cameraPosition = { value = pos }, cursorDirection = { value = dir } },
                        targetPosition = { value = tRoot.Position },
                        selfPosition = { value = pos }
                    }
                })
            end)
            char.PrimaryPart.CFrame = CFrame.lookAt(
                selfpos, Vector3.new(tRoot.Position.X, selfpos.Y + 0.001, tRoot.Position.Z))
        end
    end)
    return function() conn:Disconnect() end
end)

-- Fly (from Blatant/Fly.lua)
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

    local bv = Instance.new("BodyVelocity")
    bv.Name = "PrismFly"
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Velocity = Vector3.zero
    bv.Parent = char.PrimaryPart

    local cam = Workspace.CurrentCamera
    local conn = RunService.PreSimulation:Connect(function()
        local ch = lplr.Character
        if not ch or not ch.PrimaryPart or not bv.Parent then return end
        bv.Velocity = cam.CFrame.LookVector * 50
    end)
    return function() conn:Disconnect(); bv:Destroy() end
end)

-- NoFall (from Blatant/NoFall.lua)
register("NoFall", function(state)
    if not state then return end
    local rayParams = RaycastParams.new()
    local tracked = 0
    local extraGravity = 0

    local conn = RunService.PreSimulation:Connect(function(dt)
        local char = lplr.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not root or not hum then return end
        if root.AssemblyLinearVelocity.Y < -85 then
            rayParams.FilterDescendantsInstances = { char, Workspace.CurrentCamera }
            local rootSize = root.Size.Y / 2 + hum.HipHeight
            local ray = Workspace:Blockcast(root.CFrame, Vector3.new(3,3,3),
                Vector3.new(0, (tracked * 0.1) - rootSize, 0), rayParams)
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

-- TPWalk (Vape pattern)
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

-- Extra stubs
register("TriggerBot", function(state)
    if not state then return end
    local mouse = lplr:GetMouse()
    local last = 0
    local conn = RunService.Heartbeat:Connect(function()
        if tick() - last < 0.08 then return end
        if not mouse.Target then return end
        local m = mouse.Target:FindFirstAncestorWhichIsA("Model")
        if not m then return end
        local hum = m:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return end
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

for _, n in ipairs({"Blatant","Combat","Movement","Player","Settings","Console"}) do
    buildTabButton(n)
end

-- Blatant tab
createToggle(Pages["Blatant"], "Speed")
createToggle(Pages["Blatant"], "Killaura")
createToggle(Pages["Blatant"], "Fly")
createToggle(Pages["Blatant"], "NoFall")
createToggle(Pages["Blatant"], "TPWalk")
createInput(Pages["Blatant"], "Speed (studs/sec)", Config:getValue("speed") or 23, "speed")
createInput(Pages["Blatant"], "TPWalk (studs/sec)", Config:getValue("tpwalk") or 60, "tpwalk")

-- Combat tab
createToggle(Pages["Combat"], "TriggerBot")

-- Movement tab
createToggle(Pages["Movement"], "InfiniteJump")

-- Player tab
createToggle(Pages["Player"], "Fullbright")

--============================================================
-- SETTINGS TAB
--============================================================
do
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, 0, 0, 50)
    holder.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
    holder.BackgroundTransparency = 0.1
    holder.BorderSizePixel = 0
    holder.Parent = Pages["Settings"]
    Instance.new("UICorner", holder)
    local st = Instance.new("UIStroke", holder)
    st.Thickness = 2; st.Color = Color3.fromRGB(110, 110, 130)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 0, 18)
    lbl.Position = UDim2.new(0, 8, 0, 2)
    lbl.BackgroundTransparency = 1
    lbl.Text = "Transparency: " .. string.format("%.2f", Config.data.settings.transparency)
    lbl.TextColor3 = Color3.fromRGB(220,220,240)
    lbl.Font = Enum.Font.SourceSansPro
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = holder

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, -16, 0, 10)
    slider.Position = UDim2.new(0, 8, 0, 24)
    slider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
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

    local function actionBtn(text, cb, order)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 0, 26)
        b.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
        b.BackgroundTransparency = 0.1
        b.Text = text
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Font = Enum.Font.SourceSansPro
        b.TextSize = 13
        b.BorderSizePixel = 0
        b.LayoutOrder = order
        b.Parent = Pages["Settings"]
        Instance.new("UICorner", b)
        local st2 = Instance.new("UIStroke", b)
        st2.Thickness = 2; st2.Color = Color3.fromRGB(110, 110, 130)
        b.MouseButton1Click:Connect(cb)
        forceCanvas(Pages["Settings"])
    end

    actionBtn("Fit Window to Content", function()
        recalcLayout()
        Log:info("Window refit")
    end, 100)
    actionBtn("Save Config", function() Config:save() end, 101)
    actionBtn("Load Config", function()
        Config:load()
        Main.BackgroundTransparency = Config.data.settings.transparency
    end, 102)
    actionBtn("Reset All Modules", function()
        for name in pairs(Modules) do
            if ActiveCleanup[name] then pcall(ActiveCleanup[name]); ActiveCleanup[name] = nil end
            Config.data.toggles[name] = false
        end
        Config:save()
        Log:info("All modules reset")
    end, 103)
end

--============================================================
-- CONSOLE TAB
--============================================================
do
    local page = Pages["Console"]

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 0, 200)
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
    lay.SortOrder = Enum.SortOrder.LayoutOrder

    Log.listFrame = scroll

    local function btn(text, order, cb)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 0, 24)
        b.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
        b.BackgroundTransparency = 0.1
        b.Text = text
        b.TextColor3 = Color3.fromRGB(255,255,255)
        b.Font = Enum.Font.SourceSansPro
        b.TextSize = 12
        b.BorderSizePixel = 0
        b.LayoutOrder = order
        b.Parent = page
        Instance.new("UICorner", b)
        local st = Instance.new("UIStroke", b)
        st.Thickness = 2; st.Color = Color3.fromRGB(110, 110, 130)
        b.MouseButton1Click:Connect(cb)
    end

    btn("Copy Log",      2, function() Log:copyAll() end)
    btn("Copy Errors",   3, function()
        local errs = {}
        for _, l in ipairs(Log.lines) do
            if l:find("%[ERROR%]") then table.insert(errs, l) end
        end
        if setclipboard then
            setclipboard(table.concat(errs, "\n"))
            Log:info("Copied " .. #errs .. " error lines")
        end
    end)
    btn("Clear Console", 4, function() Log:clear(); Log:info("Console cleared") end)
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
Log:refresh()
Log:info("Prismware v2 loaded")
Log:info("Real VapeV4 modules: Speed, Killaura, Fly, NoFall")

-- Set initial tab
for n, p in pairs(Pages) do p.Visible = (n == "Blatant") end
ActiveTabName = "Blatant"
if TabButtons["Blatant"] then
    TabButtons["Blatant"].BackgroundColor3 = Color3.fromRGB(110, 120, 190)
end

-- Initial size + recalc after everything is laid out
Main.Size = UDim2.new(0, 480, 0, 300)
task.defer(function()
    task.wait(0.1)
    recalcLayout()
    -- Recalc again after layouts settle
    task.wait(0.15)
    recalcLayout()
end)

-- Auto-recalc on tab add / page changes
for _, page in pairs(Pages) do
    local lay = page:FindFirstChildOfClass("UIListLayout")
    if lay then
        lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            forceCanvas(page)
        end)
    end
end

-- Keybind
UserInputService.InputBegan:Connect(function(i, gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.RightShift then
        Main.Visible = not Main.Visible
    end
end)

Log:info("RightShift toggles the window")
