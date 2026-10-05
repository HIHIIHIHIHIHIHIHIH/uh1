-- Prismware + VapeV4 (v8)
-- Fixes: Fullbright toggle, NoClickDelay+AutoClick, Killaura guarded, AntiFall added, Fly removed
-- New tab: Prism (all original Prismware features)

local Players = game:GetService("Players")
local lplr = Players.LocalPlayer
local PlayerGui = lplr:WaitForChild("PlayerGui")

local old = PlayerGui:FindFirstChild("Prismware")
if old then old:Destroy() end

local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local HttpService       = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local Lighting          = game:GetService("Lighting")
local Camera = Workspace.CurrentCamera

local isMobile = (UserInputService.TouchEnabled == true)
    and (UserInputService.MouseEnabled ~= true)

--============================================================
-- SAFE FONT
--============================================================
local function pickFont()
    local names = {"SourceSans", "Gotham", "Roboto", "Arial"}
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

local WIN_W = isMobile and 350 or 470
local WIN_H = isMobile and 250 or 290

--============================================================
-- CONFIG
--============================================================
local Config = {
    path = "PrismCfg.json",
    data = { toggles = {}, values = { speed = 23, tpwalk = 60, reach = 18, cps = 15 } },
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
-- BEDWARS BRIDGE
--============================================================
local bedwars = _G.bedwars or {
    CombatConstant = _G.CombatConstant or { RAYCAST_SWORD_CHARACTER_DISTANCE = 14.4 },
    SwordController = _G.SwordController or {},
    Shop = _G.Shop or { ShopItems = {} },
}

local function findRemote(name)
    local r = ReplicatedStorage:FindFirstChild(name, true)
    if r then return r end
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if remotes then
        r = remotes:FindFirstChild(name)
        if r then return r end
    end
    return nil
end

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
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0, 30, 0, 100)
Main.Size = UDim2.new(0, WIN_W, 0, WIN_H)
Main.ZIndex = 1
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
local mainStroke = Instance.new("UIStroke", Main)
mainStroke.Thickness = 3
mainStroke.Color = Color3.fromRGB(180, 160, 190)

-- Title
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

-- Tabs
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
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = SAFE_FONT
    btn.TextSize = 12
    btn.ZIndex = 3
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    local s = Instance.new("UIStroke", btn)
    s.Thickness = 1.5
    s.Color = Color3.fromRGB(150, 150, 170)
end

--============================================================
-- TAB SYSTEM
--============================================================
local Tabs = {}
local ActiveTab = "Combat"

local function registerWidget(tabName, widget)
    if not Tabs[tabName] then Tabs[tabName] = { widgets = {} } end
    table.insert(Tabs[tabName].widgets, widget)
    widget.Visible = (tabName == ActiveTab)
end

local function switchTab(name)
    ActiveTab = name
    for tname, tab in pairs(Tabs) do
        for _, w in ipairs(tab.widgets) do
            w.Visible = (tname == name)
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
            if key == "reach" and Config:get("Reach") then
                if bedwars.CombatConstant then
                    bedwars.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = num + 2
                end
            end
            print("[Prism] " .. label .. " = " .. tostring(num))
        else
            box.Text = tostring(Config:getValue(key))
        end
    end)
    return holder
end

--============================================================
-- TABS
--============================================================
local TAB_NAMES = { "Combat", "Blatant", "Utility", "Render", "Prism", "Settings" }
local TAB_W = isMobile and 54 or 70
local TAB_GAP = 2

for i, name in ipairs(TAB_NAMES) do
    Tabs[name] = Tabs[name] or { widgets = {} }
    local b = Instance.new("TextButton")
    b.Text = name
    b.Position = UDim2.new(0, (i - 1) * (TAB_W + TAB_GAP), 0, 0)
    b.Size = UDim2.new(0, TAB_W, 1, 0)
    b.TextSize = isMobile and 10 or 11
    styleButton(b)
    b.Parent = TabBar
    Tabs[name].tabBtn = b
    b.MouseButton1Click:Connect(function() switchTab(name) end)
end

--============================================================
-- COMBAT MODULES
--============================================================

-- KILLAURA (from VapeV4 Blatant/Killaura.lua, guarded)
register("Killaura", function(state)
    if not state then return end
    local AttackRemote = findRemote("AttackEntity") or findRemote("SwordRemote")
    if not AttackRemote then
        warn("Killaura: AttackEntity remote not found. Module will idle.")
    end

    local Boxes = {}
    for i = 1, 10 do
        local box = Instance.new("BoxHandleAdornment")
        box.Adornee = nil
        box.AlwaysOnTop = true
        box.Size = Vector3.new(3, 5, 3)
        box.CFrame = CFrame.new(0, -0.5, 0)
        box.ZIndex = 0
        box.Parent = Camera
        Boxes[i] = box
    end

    local conn = RunService.Heartbeat:Connect(function()
        local char = lplr.Character
        if not char or not char.PrimaryPart then return end
        local tool = char:FindFirstChildWhichIsA("Tool")
        if not tool then
            for _, box in ipairs(Boxes) do box.Adornee = nil; box.Transparency = 1 end
            return
        end

        local selfpos = char.PrimaryPart.Position
        local facing = char.PrimaryPart.CFrame.LookVector * Vector3.new(1, 0, 1)

        local attacked = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p == lplr or not p.Character or not p.Character.PrimaryPart then continue end
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if not hum or hum.Health <= 0 then continue end

            local delta = p.Character.PrimaryPart.Position - selfpos
            local dist = delta.Magnitude
            if dist > 28 then continue end

            local ang = math.acos(math.clamp(facing:Dot((delta * Vector3.new(1,0,1)).Unit), -1, 1))
            if ang > math.rad(180) then continue end

            table.insert(attacked, {
                Entity = { RootPart = p.Character.PrimaryPart, Character = p.Character },
                Check = dist > 14.4 and {Hue=0.6,Sat=0.8,Value=1,Opacity=0.5} or {Hue=0,Sat=0.8,Value=1,Opacity=0.6}
            })

            if dist <= 14.4 and AttackRemote then
                local dir = CFrame.lookAt(selfpos, p.Character.PrimaryPart.Position).LookVector
                local pos = selfpos + dir * math.max(dist - 14.399, 0)
                pcall(function()
                    AttackRemote:FireServer({
                        weapon = tool,
                        chargedAttack = { chargeRatio = 0 },
                        entityInstance = p.Character,
                        validate = {
                            raycast = {
                                cameraPosition = { value = pos },
                                cursorDirection = { value = dir }
                            },
                            targetPosition = { value = p.Character.PrimaryPart.Position },
                            selfPosition = { value = pos }
                        }
                    })
                end)
            end
        end

        for i, box in ipairs(Boxes) do
            local data = attacked[i]
            if data then
                box.Adornee = data.Entity.RootPart
                box.Color3 = Color3.fromHSV(data.Check.Hue, data.Check.Sat, data.Check.Value)
                box.Transparency = 1 - data.Check.Opacity
            else
                box.Adornee = nil
                box.Transparency = 1
            end
        end

        if attacked[1] then
            local vec = attacked[1].Entity.RootPart.Position * Vector3.new(1, 0, 1)
            char.PrimaryPart.CFrame = CFrame.lookAt(
                char.PrimaryPart.Position,
                Vector3.new(vec.X, char.PrimaryPart.Position.Y + 0.001, vec.Z)
            )
        end
    end)

    return function()
        conn:Disconnect()
        for _, box in ipairs(Boxes) do
            pcall(function() box:Destroy() end)
        end
    end
end)

--============================================================
-- NOCLICKDELAY + AUTOCLICK (VapeV4 Combat)
--============================================================
local oldClickCheck = nil

register("NoClickDelay", function(state)
    if state then
        local sc = bedwars.SwordController
        if sc and sc.isClickingTooFast then
            oldClickCheck = sc.isClickingTooFast
            sc.isClickingTooFast = function(self)
                self.lastSwing = os.clock()
                return false
            end
            print("[NoClickDelay] Hooked SwordController")
        else
            local bRS = ReplicatedStorage:FindFirstChild("Bedwars")
            if bRS then
                local mods = bRS:FindFirstChild("Modules")
                if mods then
                    local sc2 = mods:FindFirstChild("SwordController")
                    if sc2 and sc2:IsA("ModuleScript") then
                        local ok, m = pcall(require, sc2)
                        if ok and m and m.isClickingTooFast then
                            oldClickCheck = m.isClickingTooFast
                            m.isClickingTooFast = function(self)
                                self.lastSwing = os.clock()
                                return false
                            end
                            bedwars.SwordController = m
                            print("[NoClickDelay] Hooked via ModuleScript")
                        end
                    end
                end
            end
        end

        -- Built-in autoclick
        local last = 0
        local acConn = RunService.Heartbeat:Connect(function()
            local cps = Config:getValue("cps") or 15
            local interval = 1 / cps
            if tick() - last < interval then return end
            local char = lplr.Character
            if not char then return end
            local tool = char:FindFirstChildWhichIsA("Tool")
            if not tool then return end
            pcall(function() mouse1click() end)
            last = tick()
        end)

        return function()
            acConn:Disconnect()
            if bedwars.SwordController and oldClickCheck then
                bedwars.SwordController.isClickingTooFast = oldClickCheck
                oldClickCheck = nil
            end
        end
    end
end)

--============================================================
-- REACH (VapeV4 Combat)
--============================================================
register("Reach", function(state)
    if state then
        local range = Config:getValue("reach") or 18
        if bedwars.CombatConstant then
            bedwars.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = range + 2
        end
        if _G.CombatConstant then
            _G.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = range + 2
        end
    else
        if bedwars.CombatConstant then
            bedwars.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = 14.4
        end
        if _G.CombatConstant then
            _G.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = 14.4
        end
    end
end)

--============================================================
-- ANTIFALL (invisible platform under you)
--============================================================
register("AntiFall", function(state)
    if not state then return end
    local rayParams = RaycastParams.new()
    if Enum.RaycastFilterType.Exclude then
        rayParams.FilterType = Enum.RaycastFilterType.Exclude
    else
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    end
    rayParams.FilterDescendantsInstances = { lplr.Character }

    local platform = nil
    local lastSafeY = 0

    local conn = RunService.Heartbeat:Connect(function()
        local char = lplr.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        -- Update safe Y from raycast down
        rayParams.FilterDescendantsInstances = { char }
        local hit = Workspace:Raycast(root.Position + Vector3.new(0, 3, 0),
            Vector3.new(0, -200, 0), rayParams)
        if hit and hit.Instance.CanCollide then
            lastSafeY = hit.Position.Y + 4
        end

        -- Falling fast? Create platform
        if root.AssemblyLinearVelocity.Y < -40 then
            if not platform then
                platform = Instance.new("Part")
                platform.Size = Vector3.new(14, 1.5, 14)
                platform.Anchored = true
                platform.CanCollide = true
                platform.Transparency = 1
                platform.CanQuery = false
                platform.Parent = Workspace
            end
            platform.Position = Vector3.new(root.Position.X, lastSafeY - 1, root.Position.Z)
            -- Fake grounded state
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                pcall(function()
                    hum:ChangeState(Enum.HumanoidStateType.Landed)
                end)
            end
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

--============================================================
-- UTILITY
--============================================================
register("ShopTierBypass", function(state)
    if state then
        local shop = bedwars.Shop
        if shop and shop.ShopItems then
            local tiered, nexttier = {}, {}
            for _, v in ipairs(shop.ShopItems) do
                tiered[v] = v.tiered
                nexttier[v] = v.nextTier
                v.nextTier = nil
                v.tiered = nil
            end
            _G._shopTiered = tiered
            _G._shopNextTier = nexttier
        end
    else
        if _G._shopTiered then
            for i, v in pairs(_G._shopTiered) do i.tiered = v end
            for i, v in pairs(_G._shopNextTier) do i.nextTier = v end
            _G._shopTiered = nil
            _G._shopNextTier = nil
        end
    end
end)

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

--============================================================
-- RENDER
--============================================================
register("BedESP", function(state)
    local Reference = {}
    local Folder = Instance.new("Folder")
    Folder.Name = "BedESP"
    Folder.Parent = Camera

    local function Added(bed)
        if not Config:get("BedESP") then return end
        local BedFolder = Instance.new("Folder")
        BedFolder.Parent = Folder
        Reference[bed] = BedFolder

        local parts = bed:GetChildren()
        table.sort(parts, function(a, b) return a.Name > b.Name end)

        for _, part in ipairs(parts) do
            if part:IsA("BasePart") and part.Name ~= "Blanket" then
                local handle = Instance.new("BoxHandleAdornment")
                handle.Size = part.Size + Vector3.new(0.01, 0.01, 0.01)
                handle.AlwaysOnTop = true
                handle.ZIndex = 2
                handle.Visible = true
                handle.Adornee = part
                handle.Color3 = part.Color
                if part.Name == "Legs" then
                    handle.Color3 = Color3.fromRGB(167, 112, 64)
                    handle.Size = part.Size + Vector3.new(0.01, -1, 0.01)
                    handle.CFrame = CFrame.new(0, -0.4, 0)
                    handle.ZIndex = 0
                end
                handle.Parent = BedFolder
            end
        end
        table.clear(parts)
    end

    if state then
        local c1 = CollectionService:GetInstanceAddedSignal("bed"):Connect(function(bed)
            task.delay(0.2, function() Added(bed) end)
        end)
        local c2 = CollectionService:GetInstanceRemovedSignal("bed"):Connect(function(bed)
            if Reference[bed] then
                Reference[bed]:Destroy()
                Reference[bed] = nil
            end
        end)
        for _, bed in CollectionService:GetTagged("bed") do
            Added(bed)
        end
        return function()
            c1:Disconnect()
            c2:Disconnect()
            Folder:ClearAllChildren()
            table.clear(Reference)
        end
    end
end)

--============================================================
-- FULLBRIGHT — FIXED (captures originals once)
--============================================================
local fullbrightOriginals = nil

register("Fullbright", function(state)
    if state then
        -- Capture originals ONCE on first enable
        if not fullbrightOriginals then
            fullbrightOriginals = {
                Ambient = Lighting.Ambient,
                Brightness = Lighting.Brightness,
                OutdoorAmbient = Lighting.OutdoorAmbient,
                ClockTime = Lighting.ClockTime,
            }
        end
        Lighting.Ambient = Color3.fromRGB(180, 180, 180)
        Lighting.Brightness = 3
        Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 180)
        Lighting.ClockTime = 14
    else
        -- Restore only if we have stored originals
        if fullbrightOriginals then
            Lighting.Ambient = fullbrightOriginals.Ambient
            Lighting.Brightness = fullbrightOriginals.Brightness
            Lighting.OutdoorAmbient = fullbrightOriginals.OutdoorAmbient
            Lighting.ClockTime = fullbrightOriginals.ClockTime
        end
    end
end)

--============================================================
-- PRISM TAB — ALL ORIGINAL PRISMWARE FEATURES
--============================================================

-- Speed (basic walkspeed)
register("Speed", function(state)
    local c = lplr.Character
    if not c then return end
    local h = c:FindFirstChildOfClass("Humanoid")
    if not h then return end
    if state then
        h.WalkSpeed = Config:getValue("speed") or 23
    else
        h.WalkSpeed = 16
    end
end)

-- TriggerBot
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

-- JitterMove
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

-- MiniGlide
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

-- Spider
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
        if Enum.RaycastFilterType.Exclude then
            params.FilterType = Enum.RaycastFilterType.Exclude
        else
            params.FilterType = Enum.RaycastFilterType.Blacklist
        end
        params.FilterDescendantsInstances = { c, Camera }
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

-- StiffSpeed
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
    return function()
        conn:Disconnect()
        local c = lplr.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then h.PlatformStand = false; h.AutoRotate = true end
        end
    end
end)

-- FarJump
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

-- NoFall
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

-- InfiniteJump
register("InfiniteJump", function(state)
    if not state then return end
    local conn = UserInputService.JumpRequest:Connect(function()
        local c = lplr.Character
        local h = c and c:FindFirstChildOfClass("Humanoid")
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)
    return function() conn:Disconnect() end
end)

-- FastClick (basic autoclick)
register("FastClick", function(state)
    if not state then return end
    task.spawn(function()
        while Config:get("FastClick") do
            pcall(function() mouse1click() end)
            task.wait(1 / (Config:getValue("cps") or 15))
        end
    end)
end)

-- Stub modules (no safe universal implementation)
register("PlayerPull", function(state) end)
register("Theme", function(state)
    if state then
        Lighting.Ambient = Color3.fromRGB(140, 60, 80)
    else
        Lighting.Ambient = fullbrightOriginals and fullbrightOriginals.Ambient or Color3.fromRGB(70, 70, 70)
    end
end)
register("CityBoiAura", function(state) end)
register("ACPrivate", function(state) end)
register("SpoofAC", function(state) end)
register("SemiDisabler", function(state) end)
register("TPNear AC", function(state) end)
register("ACV2", function(state) end)

--============================================================
-- BUILD TABS
--============================================================
local C1, C2, C3 = 6, 110, 214
local R1, R2, R3, R4, R5 = 4, 30, 56, 82, 108

-- COMBAT
makeToggle("Combat", "Killaura",     C1, R1, 100)
makeToggle("Combat", "NoClickDelay", C1, R2, 100)
makeToggle("Combat", "Reach",        C1, R3, 100)
makeInput ("Combat", "Reach (studs)", Config:getValue("reach") or 18, "reach", C2, R1, 140, 42)
makeInput ("Combat", "CPS",           Config:getValue("cps") or 15,   "cps",   C2, R1 + 46, 140, 42)

-- BLATANT
makeToggle("Blatant", "Speed",        C1, R1, 100)
makeToggle("Blatant", "AntiFall",     C1, R2, 100)
makeToggle("Blatant", "InfiniteJump", C1, R3, 100)
makeInput ("Blatant", "Speed (studs)", Config:getValue("speed") or 23, "speed", C2, R1, 140, 42)

-- UTILITY
makeToggle("Utility", "TPWalk",         C1, R1, 100)
makeToggle("Utility", "ShopTierBypass", C1, R2, 100)
makeInput ("Utility", "TPWalk (studs)", Config:getValue("tpwalk") or 60, "tpwalk", C2, R1, 140, 42)

-- RENDER
makeToggle("Render", "BedESP",     C1, R1, 100)
makeToggle("Render", "Fullbright", C1, R2, 100)

-- PRISM (all original Prismware features)
makeToggle("Prism", "TriggerBot",  C1, R1, 100)
makeToggle("Prism", "JitterMove",  C1, R2, 100)
makeToggle("Prism", "MiniGlide",   C1, R3, 100)
makeToggle("Prism", "Spider",      C1, R4, 100)
makeToggle("Prism", "StiffSpeed",  C1, R5, 100)

makeToggle("Prism", "FarJump",     C2, R1, 100)
makeToggle("Prism", "NoFall",      C2, R2, 100)
makeToggle("Prism", "FastClick",   C2, R3, 100)
makeToggle("Prism", "Theme",       C2, R4, 100)
makeToggle("Prism", "PlayerPull",  C2, R5, 100)

makeToggle("Prism", "CityBoiAura", C3, R1, 100)
makeToggle("Prism", "ACPrivate",   C3, R2, 100)
makeToggle("Prism", "SpoofAC",     C3, R3, 100)
makeToggle("Prism", "SemiDisabler",C3, R4, 100)
makeToggle("Prism", "TPNear AC",   C3, R5, 100)

-- SETTINGS
makeActionButton("Settings", "Save Config", C1, R1, 180, 22, function()
    Config:save(); print("[Prism] Saved")
end)
makeActionButton("Settings", "Load Config", C1, R2, 180, 22, function()
    Config:load(); print("[Prism] Loaded")
end)
makeActionButton("Settings", "Reset All", C1, R3, 180, 22, function()
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
switchTab("Combat")

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

print("[Prismware] Loaded on " .. (isMobile and "mobile" or "PC"))
print("[Prismware] Tabs: Combat | Blatant | Utility | Render | Prism | Settings")
