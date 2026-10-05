loadstring(game:HttpGet("https://files.vapevoidware.xyz/VapeVoidware/VW-Add/main/loader.lua", true))()
--============================================================
-- PRISM PACK FOR VAPEV4 / CRYSTALVAPE
-- Runs immediately, hooks into Vape's own menu
-- Adds a new "Prism" category + registers all modules
--============================================================

-- Wait for Vape to be ready
repeat task.wait() until shared and shared.vape
local Vape = shared.vape
repeat task.wait() until Vape.Categories

-- Services
local lplr            = game:GetService("Players").LocalPlayer
local rs              = game:GetService("RunService")
local uis             = game:GetService("UserInputService")
local replicated      = game:GetService("ReplicatedStorage")
local workspace       = game:GetService("Workspace")
local lighting        = game:GetService("Lighting")
local collection      = game:GetService("CollectionService")
local camera          = workspace.CurrentCamera

--============================================================
-- SAFELY CREATE THE "PRISM" CATEGORY
--============================================================
local Prism
local function tryMakeCategory()
    -- Try every known API signature
    local ok, result

    ok, result = pcall(function()
        return Vape.Categories:CreateCategory({
            Name = "Prism",
            Description = "Original Prismware features",
        })
    end)
    if ok and result then return result end

    ok, result = pcall(function()
        return Vape.Categories:NewCategory({
            Name = "Prism",
            Description = "Original Prismware features",
        })
    end)
    if ok and result then return result end

    ok, result = pcall(function()
        return Vape:CreateCategory({ Name = "Prism" })
    end)
    if ok and result then return result end

    -- If none work, fall back to Combat
    return Vape.Categories.Combat
end

Prism = tryMakeCategory()
warn("[Prism] Category = " .. (Prism and "ok" or "fallback"))

--============================================================
-- BEDWARS BRIDGE (for SwordController / CombatConstant)
--============================================================
local bedwars = _G.bedwars or {
    CombatConstant  = _G.CombatConstant or { RAYCAST_SWORD_CHARACTER_DISTANCE = 14.4 },
    SwordController = _G.SwordController or {},
    Shop            = _G.Shop or { ShopItems = {} },
}

local function findRemote(name)
    local r = replicated:FindFirstChild(name, true)
    if r then return r end
    local rem = replicated:FindFirstChild("Remotes")
    if rem then return rem:FindFirstChild(name) end
    return nil
end

--============================================================
-- MODULE REGISTRATION
--============================================================
local function mod(name, tooltip, fn)
    local ok, err = pcall(function()
        Prism:CreateModule({
            Name    = name,
            Tooltip = tooltip,
            Function = fn,
        })
    end)
    if not ok then warn("[Prism] failed " .. name .. ": " .. tostring(err)) end
end

local function slider(moduleObj, name, min, max, default, cb)
    if not moduleObj then return end
    pcall(function()
        moduleObj:CreateSlider({
            Name = name, Min = min, Max = max, Default = default,
            Function = cb,
        })
    end)
end

--============================================================
-- KILLAURA (VapeV4 Blatant/Killaura.lua)
--============================================================
mod("Killaura", "Auto-attacks nearby players", function(callback)
    if callback then
        local AttackRemote = findRemote("AttackEntity") or findRemote("SwordRemote")
        if not AttackRemote then
            warn("[Killaura] AttackEntity remote not found")
            return
        end

        local Boxes = {}
        for i = 1, 10 do
            local box = Instance.new("BoxHandleAdornment")
            box.Adornee      = nil
            box.AlwaysOnTop  = true
            box.Size         = Vector3.new(3, 5, 3)
            box.CFrame       = CFrame.new(0, -0.5, 0)
            box.ZIndex       = 0
            box.Parent       = camera
            Boxes[i] = box
        end

        Killaura.Connection = rs.Heartbeat:Connect(function()
            local char = lplr.Character
            if not char or not char.PrimaryPart then return end
            local tool = char:FindFirstChildWhichIsA("Tool")
            if not tool then
                for _, b in ipairs(Boxes) do b.Adornee = nil; b.Transparency = 1 end
                return
            end

            local selfpos = char.PrimaryPart.Position
            local facing  = char.PrimaryPart.CFrame.LookVector * Vector3.new(1, 0, 1)
            local attacked = {}

            for _, p in ipairs(game.Players:GetPlayers()) do
                if p == lplr or not p.Character or not p.Character.PrimaryPart then
                    continue
                end
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if not hum or hum.Health <= 0 then continue end

                local delta = p.Character.PrimaryPart.Position - selfpos
                local dist  = delta.Magnitude
                if dist > 28 then continue end

                local ang = math.acos(math.clamp(
                    facing:Dot((delta * Vector3.new(1, 0, 1)).Unit), -1, 1))
                if ang > math.rad(180) then continue end

                table.insert(attacked, {
                    Entity = { RootPart = p.Character.PrimaryPart, Character = p.Character },
                    Check  = dist > 14.4
                        and { Hue=0.6, Sat=0.8, Value=1, Opacity=0.5 }
                        or  { Hue=0,   Sat=0.8, Value=1, Opacity=0.6 }
                })

                if dist <= 14.4 then
                    local dir = CFrame.lookAt(selfpos, p.Character.PrimaryPart.Position).LookVector
                    local pos = selfpos + dir * math.max(dist - 14.399, 0)
                    pcall(function()
                        AttackRemote:FireServer({
                            weapon        = tool,
                            chargedAttack = { chargeRatio = 0 },
                            entityInstance = p.Character,
                            validate = {
                                raycast = {
                                    cameraPosition  = { value = pos },
                                    cursorDirection = { value = dir }
                                },
                                targetPosition = { value = p.Character.PrimaryPart.Position },
                                selfPosition   = { value = pos }
                            }
                        })
                    end)
                end
            end

            for i, box in ipairs(Boxes) do
                local d = attacked[i]
                if d then
                    box.Adornee     = d.Entity.RootPart
                    box.Color3      = Color3.fromHSV(d.Check.Hue, d.Check.Sat, d.Check.Value)
                    box.Transparency = 1 - d.Check.Opacity
                else
                    box.Adornee     = nil
                    box.Transparency = 1
                end
            end

            if attacked[1] then
                local vec = attacked[1].Entity.RootPart.Position * Vector3.new(1, 0, 1)
                char.PrimaryPart.CFrame = CFrame.lookAt(
                    char.PrimaryPart.Position,
                    Vector3.new(vec.X, char.PrimaryPart.Position.Y + 0.001, vec.Z))
            end
        end)
    else
        if Killaura.Connection then Killaura.Connection:Disconnect() end
    end
end)

--============================================================
-- NOCLICKDELAY (VapeV4 Combat)
--============================================================
local oldClickCheck
mod("NoClickDelay", "Remove sword CPS cap", function(callback)
    if callback then
        local sc = bedwars.SwordController
        if sc and sc.isClickingTooFast then
            oldClickCheck = sc.isClickingTooFast
            sc.isClickingTooFast = function(self)
                self.lastSwing = os.clock()
                return false
            end
        else
            local b = replicated:FindFirstChild("Bedwars")
            local m = b and b:FindFirstChild("Modules")
            local s2 = m and m:FindFirstChild("SwordController")
            if s2 and s2:IsA("ModuleScript") then
                local ok, mod = pcall(require, s2)
                if ok and mod and mod.isClickingTooFast then
                    oldClickCheck = mod.isClickingTooFast
                    mod.isClickingTooFast = function(self)
                        self.lastSwing = os.clock()
                        return false
                    end
                    bedwars.SwordController = mod
                end
            end
        end
    else
        if bedwars.SwordController and oldClickCheck then
            bedwars.SwordController.isClickingTooFast = oldClickCheck
            oldClickCheck = nil
        end
    end
end)

--============================================================
-- REACH (VapeV4 Combat)
--============================================================
local ReachRange = 18
local ReachModule
pcall(function()
    ReachModule = Prism:CreateModule({
        Name    = "Reach",
        Tooltip = "Extend sword attack range",
        Function = function(callback)
            if callback then
                if bedwars.CombatConstant then
                    bedwars.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = ReachRange + 2
                end
            else
                if bedwars.CombatConstant then
                    bedwars.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = 14.4
                end
            end
        end
    })
end)

if ReachModule then
    slider(ReachModule, "Range", 0, 18, 18, function(val)
        ReachRange = val
        if bedwars.CombatConstant and ReachModule.Enabled then
            bedwars.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = val + 2
        end
    end)
end

--============================================================
-- SPEED (VapeV4 Blatant/Speed.lua)
--============================================================
local SpeedValue = 23
local SpeedModule
pcall(function()
    SpeedModule = Prism:CreateModule({
        Name    = "Speed",
        Tooltip = "VapeV4 Speed (friction override)",
        Function = function(callback)
            if callback then
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
                                part.CustomPhysicalProperties =
                                    PhysicalProperties.new(0.001, 0.1, 0.3, 1, 1)
                            end
                        end
                    end
                end
                updateFriction(true)

                SpeedModule.Connection = rs.PreSimulation:Connect(function(dt)
                    local c = lplr.Character
                    if not c then return end
                    local root = c:FindFirstChild("HumanoidRootPart")
                    local hum  = c:FindFirstChildOfClass("Humanoid")
                    if not root or not hum or hum.Health <= 0 then return end
                    local st = hum:GetState()
                    if st == Enum.HumanoidStateType.Climbing then return end

                    local velo = (root.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude
                    local moveDir = hum.MoveDirection
                    local dest = moveDir * math.max(SpeedValue - velo, 0) * dt

                    rayCheck.FilterDescendantsInstances = { c, camera }
                    rayCheck.CollisionGroup = root.CollisionGroup
                    local hit = workspace:Raycast(root.Position, dest, rayCheck)
                    if hit then dest = (hit.Position + hit.Normal) - root.Position end

                    root.CFrame = root.CFrame + dest
                    root.AssemblyLinearVelocity =
                        (moveDir * velo) + Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)

                    if (st == Enum.HumanoidStateType.Running
                        or st == Enum.HumanoidStateType.Landed)
                        and moveDir ~= Vector3.zero then
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end)
            else
                if SpeedModule.Connection then SpeedModule.Connection:Disconnect() end
                for p, old in pairs(SpeedModule.frictionParts or {}) do
                    if p and p.Parent then p.CustomPhysicalProperties = old end
                end
            end
        end
    })
end)

if SpeedModule then
    slider(SpeedModule, "Speed", 1, 100, 23, function(val) SpeedValue = val end)
end

--============================================================
-- TPWALK (Prismware)
--============================================================
local TPWalkValue = 60
local TPWalkModule
pcall(function()
    TPWalkModule = Prism:CreateModule({
        Name    = "TPWalk",
        Tooltip = "Teleport-walk at high speed",
        Function = function(callback)
            if callback then
                TPWalkModule.Connection = rs.Heartbeat:Connect(function(dt)
                    local c = lplr.Character
                    if not c then return end
                    local root = c:FindFirstChild("HumanoidRootPart")
                    local hum  = c:FindFirstChildOfClass("Humanoid")
                    if root and hum and hum.MoveDirection.Magnitude > 0 then
                        root.CFrame = root.CFrame + hum.MoveDirection * TPWalkValue * dt
                    end
                end)
            else
                if TPWalkModule.Connection then TPWalkModule.Connection:Disconnect() end
            end
        end
    })
end)
if TPWalkModule then
    slider(TPWalkModule, "Speed", 20, 200, 60, function(val) TPWalkValue = val end)
end

--============================================================
-- ANTIFALL (Prismware)
--============================================================
mod("AntiFall", "Invisible platform when falling", function(callback)
    if callback then
        local rayParams = RaycastParams.new()
        rayParams.FilterType = Enum.RaycastFilterType.Exclude
        local platform, lastSafeY = nil, 0

        AntiFall.Connection = rs.Heartbeat:Connect(function()
            local c = lplr.Character
            if not c then return end
            local root = c:FindFirstChild("HumanoidRootPart")
            if not root then return end

            rayParams.FilterDescendantsInstances = { c }
            local hit = workspace:Raycast(root.Position + Vector3.new(0, 3, 0),
                Vector3.new(0, -200, 0), rayParams)
            if hit and hit.Instance.CanCollide then
                lastSafeY = hit.Position.Y + 4
            end

            if root.AssemblyLinearVelocity.Y < -40 then
                if not platform then
                    platform = Instance.new("Part")
                    platform.Size = Vector3.new(14, 1.5, 14)
                    platform.Anchored = true
                    platform.CanCollide = true
                    platform.Transparency = 1
                    platform.CanQuery = false
                    platform.Parent = workspace
                end
                platform.Position = Vector3.new(root.Position.X, lastSafeY - 1, root.Position.Z)
                local h = c:FindFirstChildOfClass("Humanoid")
                if h then pcall(function() h:ChangeState(Enum.HumanoidStateType.Landed) end) end
            elseif platform then
                platform:Destroy(); platform = nil
            end
        end)
    else
        if AntiFall.Connection then AntiFall.Connection:Disconnect() end
        if AntiFall.Platform then AntiFall.Platform:Destroy() end
    end
end)

--============================================================
-- SHOPTIERBYPASS (VapeV4 Utility)
--============================================================
local shopTiered, shopNextTier
mod("ShopTierBypass", "Buy items without unlocking tiers", function(callback)
    if callback then
        local shop = bedwars.Shop
        if shop and shop.ShopItems then
            shopTiered, shopNextTier = {}, {}
            for _, v in ipairs(shop.ShopItems) do
                shopTiered[v]   = v.tiered
                shopNextTier[v] = v.nextTier
                v.nextTier = nil
                v.tiered   = nil
            end
        end
    else
        if shopTiered then
            for i, v in pairs(shopTiered)   do i.tiered   = v end
            for i, v in pairs(shopNextTier) do i.nextTier = v end
            shopTiered, shopNextTier = nil, nil
        end
    end
end)

--============================================================
-- BEDESP (VapeV4 Render)
--============================================================
mod("BedESP", "Render beds through walls", function(callback)
    local Reference = {}
    local Folder = Instance.new("Folder")
    Folder.Name = "PrismBedESP"
    Folder.Parent = camera

    local function added(bed)
        if not BedESP.Enabled then return end
        local f = Instance.new("Folder")
        f.Parent = Folder
        Reference[bed] = f
        local parts = bed:GetChildren()
        table.sort(parts, function(a, b) return a.Name > b.Name end)
        for _, part in ipairs(parts) do
            if part:IsA("BasePart") and part.Name ~= "Blanket" then
                local h = Instance.new("BoxHandleAdornment")
                h.Size = part.Size + Vector3.new(0.01, 0.01, 0.01)
                h.AlwaysOnTop = true
                h.ZIndex = 2
                h.Adornee = part
                h.Color3 = part.Color
                if part.Name == "Legs" then
                    h.Color3 = Color3.fromRGB(167, 112, 64)
                    h.Size = part.Size + Vector3.new(0.01, -1, 0.01)
                    h.CFrame = CFrame.new(0, -0.4, 0)
                    h.ZIndex = 0
                end
                h.Parent = f
            end
        end
    end

    if callback then
        BedESP.C1 = collection:GetInstanceAddedSignal("bed"):Connect(function(bed)
            task.delay(0.2, function() added(bed) end)
        end)
        BedESP.C2 = collection:GetInstanceRemovedSignal("bed"):Connect(function(bed)
            if Reference[bed] then Reference[bed]:Destroy(); Reference[bed] = nil end
        end)
        for _, bed in collection:GetTagged("bed") do added(bed) end
    else
        if BedESP.C1 then BedESP.C1:Disconnect() end
        if BedESP.C2 then BedESP.C2:Disconnect() end
        Folder:ClearAllChildren()
    end
end)

--============================================================
-- FULLBRIGHT (with proper restore)
--============================================================
local FBOriginals
mod("Fullbright", "Brightens the world", function(callback)
    if callback then
        if not FBOriginals then
            FBOriginals = {
                Ambient        = lighting.Ambient,
                Brightness     = lighting.Brightness,
                OutdoorAmbient = lighting.OutdoorAmbient,
                ClockTime      = lighting.ClockTime,
            }
        end
        lighting.Ambient        = Color3.fromRGB(180, 180, 180)
        lighting.Brightness     = 3
        lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 180)
        lighting.ClockTime      = 14
    else
        if FBOriginals then
            lighting.Ambient        = FBOriginals.Ambient
            lighting.Brightness     = FBOriginals.Brightness
            lighting.OutdoorAmbient = FBOriginals.OutdoorAmbient
            lighting.ClockTime      = FBOriginals.ClockTime
        end
    end
end)

--============================================================
-- TRIGGERBOT (Prismware)
--============================================================
mod("TriggerBot", "Auto-click hovered players", function(callback)
    if callback then
        local mouse = lplr:GetMouse()
        local last = 0
        TriggerBot.Connection = rs.Heartbeat:Connect(function()
            if tick() - last < 0.08 then return end
            if not mouse.Target then return end
            local m = mouse.Target:FindFirstAncestorWhichIsA("Model")
            if not m then return end
            local h = m:FindFirstChildOfClass("Humanoid")
            if not h or h.Health <= 0 then return end
            local p = game.Players:GetPlayerFromCharacter(m)
            if not p or p == lplr then return end
            local mr = lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart")
            local tr = m:FindFirstChild("HumanoidRootPart")
            if mr and tr and (mr.Position - tr.Position).Magnitude <= 20 then
                mouse1click()
                last = tick()
            end
        end)
    else
        if TriggerBot.Connection then TriggerBot.Connection:Disconnect() end
    end
end)

--============================================================
-- JITTERMOVE (Prismware)
--============================================================
mod("JitterMove", "Small random CFrame shifts", function(callback)
    if callback then
        JitterMove.Connection = rs.Heartbeat:Connect(function()
            local c = lplr.Character
            if not c then return end
            local root = c:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = root.CFrame + Vector3.new(
                    math.random(-10, 10)/100, 0, math.random(-10, 10)/100)
            end
        end)
    else
        if JitterMove.Connection then JitterMove.Connection:Disconnect() end
    end
end)

--============================================================
-- MINIGLIDE (Prismware)
--============================================================
mod("MiniGlide", "Slow fall in air", function(callback)
    if callback then
        MiniGlide.Connection = rs.Heartbeat:Connect(function()
            local c = lplr.Character
            if not c then return end
            local hum = c:FindFirstChildOfClass("Humanoid")
            local root = c:FindFirstChild("HumanoidRootPart")
            if hum and root and hum.FloorMaterial == Enum.Material.Air then
                local v = root.AssemblyLinearVelocity
                root.AssemblyLinearVelocity = Vector3.new(v.X, math.max(v.Y, -2), v.Z)
            end
        end)
    else
        if MiniGlide.Connection then MiniGlide.Connection:Disconnect() end
    end
end)

--============================================================
-- SPIDER (Prismware)
--============================================================
mod("Spider", "Climb walls", function(callback)
    if callback then
        Spider.Connection = rs.PreSimulation:Connect(function(dt)
            local c = lplr.Character
            if not c then return end
            local root = c:FindFirstChild("HumanoidRootPart")
            local hum  = c:FindFirstChildOfClass("Humanoid")
            if not root or not hum then return end
            if uis:IsKeyDown(Enum.KeyCode.LeftShift) then return end
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Exclude
            params.FilterDescendantsInstances = { c, camera }
            local origin = root.Position - Vector3.new(0, hum.HipHeight - 0.5, 0)
            local hit = workspace:Raycast(origin, hum.MoveDirection * 2.5, params)
            if hit and hit.Normal.Y == 0 then
                hum:ChangeState(Enum.HumanoidStateType.Climbing)
                root.AssemblyLinearVelocity = root.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
                    + Vector3.new(0, 30, 0)
            end
        end)
    else
        if Spider.Connection then Spider.Connection:Disconnect() end
    end
end)

--============================================================
-- STIFFSPEED (Prismware)
--============================================================
mod("StiffSpeed", "Rigid, fast CFrame movement", function(callback)
    if callback then
        StiffSpeed.Connection = rs.Heartbeat:Connect(function(dt)
            local c = lplr.Character
            if not c then return end
            local root = c:FindFirstChild("HumanoidRootPart")
            local hum  = c:FindFirstChildOfClass("Humanoid")
            if not root or not hum then return end
            hum.PlatformStand = true
            hum.AutoRotate = false
            local move = Vector3.new()
            if uis:IsKeyDown(Enum.KeyCode.W) then move += root.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.S) then move -= root.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.A) then move -= root.CFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.D) then move += root.CFrame.RightVector end
            if move.Magnitude > 0 then
                root.CFrame = root.CFrame + move.Unit * 150 * dt
            end
        end)
    else
        if StiffSpeed.Connection then StiffSpeed.Connection:Disconnect() end
        local c = lplr.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then h.PlatformStand = false; h.AutoRotate = true end
        end
    end
end)

--============================================================
-- FARJUMP (Prismware)
--============================================================
mod("FarJump", "Launch forward on jump", function(callback)
    if callback then
        FarJump.Connection = uis.JumpRequest:Connect(function()
            local c = lplr.Character
            if not c then return end
            local root = c:FindFirstChild("HumanoidRootPart")
            if root then
                root.AssemblyLinearVelocity = root.AssemblyLinearVelocity
                    + root.CFrame.LookVector * 80 + Vector3.new(0, 60, 0)
            end
        end)
    else
        if FarJump.Connection then FarJump.Connection:Disconnect() end
    end
end)

--============================================================
-- NOFALL (Prismware)
--============================================================
mod("NoFall", "No damage from falling", function(callback)
    if callback then
        NoFall.Connection = rs.Heartbeat:Connect(function()
            local c = lplr.Character
            if not c then return end
            local hum = c:FindFirstChildOfClass("Humanoid")
            if hum and hum:GetState() == Enum.HumanoidStateType.Freefall then
                hum:ChangeState(Enum.HumanoidStateType.Landed)
            end
        end)
    else
        if NoFall.Connection then NoFall.Connection:Disconnect() end
    end
end)

--============================================================
-- FASTCLICK (Prismware)
--============================================================
local FastClickCPS = 15
local FastClickModule
pcall(function()
    FastClickModule = Prism:CreateModule({
        Name    = "FastClick",
        Tooltip = "Rapid autoclicker",
        Function = function(callback)
            if callback then
                FastClickModule.Running = true
                task.spawn(function()
                    while FastClickModule.Running do
                        pcall(function() mouse1click() end)
                        task.wait(1 / FastClickCPS)
                    end
                end)
            else
                FastClickModule.Running = false
            end
        end
    })
end)
if FastClickModule then
    slider(FastClickModule, "CPS", 1, 30, 15, function(val) FastClickCPS = val end)
end

--============================================================
-- THEME (Prismware)
--============================================================
mod("Theme", "Red ambient tint", function(callback)
    if callback then
        Theme.Original = Theme.Original or lighting.Ambient
        lighting.Ambient = Color3.fromRGB(140, 60, 80)
    else
        if Theme.Original then lighting.Ambient = Theme.Original end
    end
end)

--============================================================
-- PLAYERPULL (Prismware)
--============================================================
mod("PlayerPull", "Pull nearest player toward you (chat /pull)", function(callback)
    if callback then
        PlayerPull.Chat = lplr.Chatted:Connect(function(msg)
            if msg == "/pull" then
                for _, p in ipairs(game.Players:GetPlayers()) do
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
            end
        end)
    else
        if PlayerPull.Chat then PlayerPull.Chat:Disconnect() end
    end
end)

--============================================================
-- STUB MODULES (no universal implementation)
--============================================================
mod("CityBoiAura", "Placeholder", function(callback) end)
mod("ACPrivate",   "Placeholder", function(callback) end)
mod("SpoofAC",     "Placeholder", function(callback) end)
mod("SemiDisabler","Placeholder", function(callback) end)
mod("TPNear AC",   "Placeholder", function(callback) end)
mod("ACV2",        "Placeholder", function(callback) end)

warn("[Prism] Registered " .. tostring(#Prism.Modules or 0) .. " modules in Prism category")
