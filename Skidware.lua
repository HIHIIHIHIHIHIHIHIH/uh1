--[=[
SKID 4 LIFE ENGINE
]=]

-- Instances: 52 | Scripts: 9 | Modules: 0 | Tags: 0
local G2L = {};

-- StarterGui.ScreenGui
G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;


-- StarterGui.ScreenGui.Frame
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(181, 181, 181);
G2L["2"]["Size"] = UDim2.new(0, 368, 0, 186);
G2L["2"]["Position"] = UDim2.new(0.19025, 0, 0.30388, 0);
G2L["2"]["BorderColor3"] = Color3.fromRGB(241, 241, 241);


-- StarterGui.ScreenGui.Frame.UICorner
G2L["3"] = Instance.new("UICorner", G2L["2"]);



-- StarterGui.ScreenGui.Frame.UIStroke
G2L["4"] = Instance.new("UIStroke", G2L["2"]);
G2L["4"]["Thickness"] = 4.8;
G2L["4"]["Color"] = Color3.fromRGB(255, 255, 255);


-- StarterGui.ScreenGui.Frame.UIStroke.UIGradient
G2L["5"] = Instance.new("UIGradient", G2L["4"]);
G2L["5"]["Rotation"] = -90;
G2L["5"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(94, 66, 88)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(169, 203, 187))};


-- StarterGui.ScreenGui.Frame.TextBox
G2L["6"] = Instance.new("TextBox", G2L["2"]);
G2L["6"]["BorderSizePixel"] = 0;
G2L["6"]["TextSize"] = 14;
G2L["6"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6"]["FontFace"] = Font.new([[rbxassetid://16658246179]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["6"]["PlaceholderText"] = [[Search]];
G2L["6"]["Size"] = UDim2.new(0, 183, 0, 18);
G2L["6"]["Position"] = UDim2.new(0.03804, 0, 0.86022, 0);
G2L["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6"]["Text"] = [[]];
G2L["6"]["BackgroundTransparency"] = 0.85;


-- StarterGui.ScreenGui.Frame.TextBox.UICorner
G2L["7"] = Instance.new("UICorner", G2L["6"]);



-- StarterGui.ScreenGui.Frame.TextButton
G2L["8"] = Instance.new("TextButton", G2L["2"]);
G2L["8"]["BorderSizePixel"] = 0;
G2L["8"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["8"]["TextSize"] = 14;
G2L["8"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["8"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["8"]["BackgroundTransparency"] = 0.26;
G2L["8"]["Size"] = UDim2.new(0, 93, 0, 23);
G2L["8"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["8"]["Text"] = [[TriggerBot]];
G2L["8"]["Position"] = UDim2.new(0, 6, 0, 7);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["9"] = Instance.new("UICorner", G2L["8"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["a"] = Instance.new("UIStroke", G2L["8"]);
G2L["a"]["Thickness"] = 2.4;
G2L["a"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["b"] = Instance.new("UIGradient", G2L["8"]);
G2L["b"]["Rotation"] = -90;
G2L["b"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
G2L["c"] = Instance.new("LocalScript", G2L["8"]);



-- StarterGui.ScreenGui.Frame.TextButton
G2L["d"] = Instance.new("TextButton", G2L["2"]);
G2L["d"]["BorderSizePixel"] = 0;
G2L["d"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["d"]["TextSize"] = 14;
G2L["d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["d"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["d"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["d"]["BackgroundTransparency"] = 0.26;
G2L["d"]["Size"] = UDim2.new(0, 93, 0, 23);
G2L["d"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["d"]["Text"] = [[TPWalk]];
G2L["d"]["Position"] = UDim2.new(0, 6, 0, 37);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["e"] = Instance.new("UICorner", G2L["d"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["f"] = Instance.new("UIStroke", G2L["d"]);
G2L["f"]["Thickness"] = 2.4;
G2L["f"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["10"] = Instance.new("UIGradient", G2L["d"]);
G2L["10"]["Rotation"] = -90;
G2L["10"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextButton
G2L["11"] = Instance.new("TextButton", G2L["2"]);
G2L["11"]["BorderSizePixel"] = 0;
G2L["11"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["11"]["TextSize"] = 14;
G2L["11"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["11"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["11"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["11"]["BackgroundTransparency"] = 0.26;
G2L["11"]["Size"] = UDim2.new(0, 93, 0, 23);
G2L["11"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["11"]["Text"] = [[JitterMove]];
G2L["11"]["Position"] = UDim2.new(0, 6, 0, 67);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["12"] = Instance.new("UICorner", G2L["11"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["13"] = Instance.new("UIStroke", G2L["11"]);
G2L["13"]["Thickness"] = 2.4;
G2L["13"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["14"] = Instance.new("UIGradient", G2L["11"]);
G2L["14"]["Rotation"] = -90;
G2L["14"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
G2L["15"] = Instance.new("LocalScript", G2L["11"]);



-- StarterGui.ScreenGui.Frame.TextButton
G2L["16"] = Instance.new("TextButton", G2L["2"]);
G2L["16"]["BorderSizePixel"] = 0;
G2L["16"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["16"]["TextSize"] = 14;
G2L["16"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["16"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["16"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["16"]["BackgroundTransparency"] = 0.26;
G2L["16"]["Size"] = UDim2.new(0, 104, 0, 23);
G2L["16"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["16"]["Text"] = [[PlayerPull Use /]];
G2L["16"]["Position"] = UDim2.new(0, 6, 0, 98);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["17"] = Instance.new("UICorner", G2L["16"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["18"] = Instance.new("UIStroke", G2L["16"]);
G2L["18"]["Thickness"] = 2.4;
G2L["18"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
G2L["19"] = Instance.new("LocalScript", G2L["16"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["1a"] = Instance.new("UIGradient", G2L["16"]);
G2L["1a"]["Rotation"] = -90;
G2L["1a"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(0.021, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(0.226, Color3.fromRGB(255, 248, 22)),ColorSequenceKeypoint.new(0.513, Color3.fromRGB(249, 229, 15)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextLabel
G2L["1b"] = Instance.new("TextLabel", G2L["2"]);
G2L["1b"]["TextWrapped"] = true;
G2L["1b"]["BorderSizePixel"] = 0;
G2L["1b"]["TextSize"] = 10;
G2L["1b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1b"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["1b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1b"]["BackgroundTransparency"] = 1;
G2L["1b"]["Size"] = UDim2.new(0, 131, 0, 49);
G2L["1b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1b"]["Text"] = [[get bypassed by iy😂]];
G2L["1b"]["Position"] = UDim2.new(0, 203, 0, 144);


-- StarterGui.ScreenGui.Frame.TextLabel.UIGradient
G2L["1c"] = Instance.new("UIGradient", G2L["1b"]);
G2L["1c"]["Rotation"] = -90;
G2L["1c"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(0, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 129, 0))};


-- StarterGui.ScreenGui.Frame.TextLabel
G2L["1d"] = Instance.new("TextLabel", G2L["2"]);
G2L["1d"]["TextWrapped"] = true;
G2L["1d"]["BorderSizePixel"] = 0;
G2L["1d"]["TextSize"] = 10;
G2L["1d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1d"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["1d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1d"]["BackgroundTransparency"] = 1;
G2L["1d"]["Size"] = UDim2.new(0, 131, 0, 49);
G2L["1d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1d"]["Text"] = [[PrismClient]];
G2L["1d"]["Position"] = UDim2.new(0, 263, 0, -6);


-- StarterGui.ScreenGui.Frame.UIGradient
G2L["1e"] = Instance.new("UIGradient", G2L["2"]);
G2L["1e"]["Rotation"] = -90;
G2L["1e"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(94, 66, 88)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(169, 203, 187))};


-- StarterGui.ScreenGui.Frame.TextButton
G2L["1f"] = Instance.new("TextButton", G2L["2"]);
G2L["1f"]["BorderSizePixel"] = 0;
G2L["1f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1f"]["TextSize"] = 14;
G2L["1f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1f"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["1f"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["1f"]["BackgroundTransparency"] = 0.26;
G2L["1f"]["Size"] = UDim2.new(0, 93, 0, 23);
G2L["1f"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["1f"]["Text"] = [[Theme]];
G2L["1f"]["Position"] = UDim2.new(0, 110, 0, 7);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["20"] = Instance.new("UICorner", G2L["1f"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["21"] = Instance.new("UIStroke", G2L["1f"]);
G2L["21"]["Thickness"] = 2.4;
G2L["21"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["22"] = Instance.new("UIGradient", G2L["1f"]);
G2L["22"]["Rotation"] = -90;
G2L["22"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
G2L["23"] = Instance.new("LocalScript", G2L["1f"]);



-- StarterGui.ScreenGui.Frame.TextButton
G2L["24"] = Instance.new("TextButton", G2L["2"]);
G2L["24"]["BorderSizePixel"] = 0;
G2L["24"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["24"]["TextSize"] = 14;
G2L["24"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["24"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["24"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["24"]["BackgroundTransparency"] = 0.26;
G2L["24"]["Size"] = UDim2.new(0, 120, 0, 23);
G2L["24"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["24"]["Text"] = [[MiniGlide]];
G2L["24"]["Position"] = UDim2.new(0, 110, 0, 37);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["25"] = Instance.new("UICorner", G2L["24"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["26"] = Instance.new("UIStroke", G2L["24"]);
G2L["26"]["Thickness"] = 2.4;
G2L["26"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
G2L["27"] = Instance.new("LocalScript", G2L["24"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["28"] = Instance.new("UIGradient", G2L["24"]);
G2L["28"]["Rotation"] = -90;
G2L["28"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(0.021, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(0.226, Color3.fromRGB(255, 248, 22)),ColorSequenceKeypoint.new(0.513, Color3.fromRGB(249, 229, 15)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextButton
G2L["29"] = Instance.new("TextButton", G2L["2"]);
G2L["29"]["BorderSizePixel"] = 0;
G2L["29"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["29"]["TextSize"] = 14;
G2L["29"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["29"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["29"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["29"]["BackgroundTransparency"] = 0.26;
G2L["29"]["Size"] = UDim2.new(0, 120, 0, 23);
G2L["29"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["29"]["Text"] = [[Spider]];
G2L["29"]["Position"] = UDim2.new(0, 110, 0, 67);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["2a"] = Instance.new("UICorner", G2L["29"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["2b"] = Instance.new("UIStroke", G2L["29"]);
G2L["2b"]["Thickness"] = 2.4;
G2L["2b"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["2c"] = Instance.new("UIGradient", G2L["29"]);
G2L["2c"]["Rotation"] = -90;
G2L["2c"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
G2L["2d"] = Instance.new("LocalScript", G2L["29"]);



-- StarterGui.ScreenGui.Frame.UIDrag
G2L["2e"] = Instance.new("LocalScript", G2L["2"]);
G2L["2e"]["Name"] = [[UIDrag]];


-- StarterGui.ScreenGui.Frame.TextButton
G2L["2f"] = Instance.new("TextButton", G2L["2"]);
G2L["2f"]["BorderSizePixel"] = 0;
G2L["2f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["2f"]["TextSize"] = 14;
G2L["2f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2f"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["2f"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["2f"]["BackgroundTransparency"] = 0.26;
G2L["2f"]["Size"] = UDim2.new(0, 85, 0, 23);
G2L["2f"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["2f"]["Text"] = [[CityBoiAura]];
G2L["2f"]["Position"] = UDim2.new(0, 118, 0, 98);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["30"] = Instance.new("UICorner", G2L["2f"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["31"] = Instance.new("UIStroke", G2L["2f"]);
G2L["31"]["Thickness"] = 2.4;
G2L["31"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["32"] = Instance.new("UIGradient", G2L["2f"]);
G2L["32"]["Rotation"] = -90;
G2L["32"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
G2L["33"] = Instance.new("LocalScript", G2L["2f"]);



-- StarterGui.ScreenGui.LocalScript
G2L["34"] = Instance.new("LocalScript", G2L["1"]);



-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
local function C_c()
local script = G2L["c"];
	-- EXPLOIT AUTO-CLICK: Mouse hover + 20 stud radius
	-- Place this LocalScript INSIDE your existing button
	-- Clicking the parent button toggles the feature ON/OFF
	-- Pressing . (period key) also toggles it
	
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	
	local lp = Players.LocalPlayer
	local mouse = lp:GetMouse()
	
	local button = script.Parent  -- ← your button (TextButton / ImageButton / etc.)
	
	local autoClickEnabled = false
	local lastClickTime = 0
	local CLICK_COOLDOWN = 0.08   -- seconds between clicks (prevents spam/kick risk)
	local MAX_DISTANCE = 20       -- studs
	
	local connection = nil
	
	local function getRoot(char)
		return char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char.PrimaryPart)
	end
	
	local function isValidTarget()
		if not mouse.Target then return false end
	
		local model = mouse.Target:FindFirstAncestorWhichIsA("Model")
		if not model then return false end
	
		local hum = model:FindFirstChildOfClass("Humanoid")
		if not hum or hum.Health <= 0 then return false end
	
		local targetPlayer = Players:GetPlayerFromCharacter(model)
		if not targetPlayer or targetPlayer == lp then return false end
	
		local myRoot = getRoot(lp.Character)
		local targetRoot = getRoot(model)
		if not myRoot or not targetRoot then return false end
	
		local dist = (myRoot.Position - targetRoot.Position).Magnitude
		return dist <= MAX_DISTANCE
	end
	
	local function tryAutoClick()
		if tick() - lastClickTime < CLICK_COOLDOWN then return end
	
		if isValidTarget() then
			mouse1click()
			lastClickTime = tick()
		end
	end
	
	local function startAutoClick()
		if connection then connection:Disconnect() end
		connection = RunService.Heartbeat:Connect(tryAutoClick)
		print("[Auto-Hover Click] ENABLED")
	end
	
	local function stopAutoClick()
		if connection then
			connection:Disconnect()
			connection = nil
		end
		print("[Auto-Hover Click] DISABLED")
	end
	
	local function toggle()
		autoClickEnabled = not autoClickEnabled
	
		if autoClickEnabled then
			startAutoClick()
			-- Optional visual feedback (uncomment if you want)
			-- button.BackgroundColor3 = Color3.fromRGB(60, 180, 60)   -- green
		else
			stopAutoClick()
			-- button.BackgroundColor3 = Color3.fromRGB(180, 60, 60)   -- red
		end
	end
	
	-- Toggle via clicking the parent button
	button.MouseButton1Click:Connect(toggle)
	
	-- Toggle also via pressing . (period key)
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.KeyCode == Enum.KeyCode.Period then
			toggle()
		end
	end)
	
	-- Respawn handler - keep the state
	lp.CharacterAdded:Connect(function()
		task.wait(0.8)
		if autoClickEnabled then
			startAutoClick()
		end
	end)
	
	print("[Auto-Click on Hover] Loaded")
	print("Click the button or press . (period) to toggle")
	print("When active: hovering over another player ≤ 20 studs → auto left-click")
end;
task.spawn(C_c);
-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
local function C_15()
local script = G2L["15"];
	-- Exploit: Horizontal jitter near players
	-- Place this LocalScript INSIDE your existing button
	-- Clicking the button toggles the effect on/off
	
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local button = script.Parent  -- ← your button (TextButton / ImageButton / etc.)
	
	local jitterEnabled = false   -- starts OFF
	
	local INTENSITY = 0.16        -- shake strength (0.08 = subtle, 0.25 = obvious)
	local FREQUENCY = 11          -- shake speed
	local DISTANCE  = 32          -- only jitter if someone closer than this (studs)
	
	local random = Random.new()
	local timeAcc = 0
	
	-- Quick check if anyone is close enough
	local function anyoneNearby()
		local char = Players.LocalPlayer.Character
		if not char then return false end
	
		local root = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
		if not root then return false end
	
		local myPos = root.Position
		local closest = 999
	
		for _, plr in Players:GetPlayers() do
			if plr == Players.LocalPlayer or not plr.Character then continue end
			local r = plr.Character:FindFirstChild("HumanoidRootPart") or plr.Character.PrimaryPart
			if not r then continue end
			local d = (myPos - r.Position).Magnitude
			if d < closest then closest = d end
		end
	
		return closest <= DISTANCE
	end
	
	-- The actual jitter loop
	RunService.Heartbeat:Connect(function(dt)
		if not jitterEnabled then return end
		if not anyoneNearby() then return end
	
		local char = Players.LocalPlayer.Character
		if not char then return end
	
		local root = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
		if not root then return end
	
		timeAcc = timeAcc + dt * FREQUENCY
	
		local ox = math.sin(timeAcc * 6.8 + random:NextNumber(-2,2)) * INTENSITY
		local oz = math.cos(timeAcc * 8.1 + random:NextNumber(-3,3)) * INTENSITY
	
		root.CFrame = root.CFrame + Vector3.new(ox, 0, oz)   -- only X/Z → no up/down
	end)
	
	-- Toggle when the parent button is clicked
	button.MouseButton1Click:Connect(function()
		jitterEnabled = not jitterEnabled
	
		-- Optional: give visual feedback on your button (uncomment if you want)
		-- if jitterEnabled then
		--     button.BackgroundColor3 = Color3.fromRGB(60, 180, 60)   -- green-ish
		-- else
		--     button.BackgroundColor3 = Color3.fromRGB(180, 60, 60)   -- red-ish
		-- end
	
		print("[Jitter] " .. (jitterEnabled and "ENABLED" or "DISABLED"))
	end)
	
	print("[Jitter near players] Loaded – click the parent button to toggle")
end;
task.spawn(C_15);
-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
local function C_19()
local script = G2L["19"];
	-- EXPLOIT STARE: Toggle with / key press + GUI Button + auto-re-enable after respawn
	
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	
	local lp = Players.LocalPlayer
	
	local staring = false
	local connection = nil
	local humanoid = nil
	
	local function getRoot(char)
		return char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char.PrimaryPart)
	end
	
	local function getClosest()
		local char = lp.Character
		if not char then return nil end
		local myRoot = getRoot(char)
		if not myRoot then return nil end
	
		local myPos = myRoot.Position
		local closest, minDist = nil, math.huge
	
		for _, p in Players:GetPlayers() do
			if p == lp or not p.Character then continue end
			local root = getRoot(p.Character)
			if not root then continue end
			local dist = (myPos - root.Position).Magnitude
			if dist < minDist then
				minDist = dist
				closest = p
			end
		end
		return closest
	end
	
	local function updateStare()
		local char = lp.Character
		if not char then return end
		local myRoot = getRoot(char)
		if not myRoot then return end
	
		humanoid = char:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.AutoRotate = false
		end
	
		local target = getClosest()
		if not target or not target.Character then return end
	
		local targetRoot = getRoot(target.Character)
		if not targetRoot then return end
	
		local myPos = myRoot.Position + Vector3.new(0, 0.12, 0)
		local targetPos = targetRoot.Position
		local flatTarget = Vector3.new(targetPos.X, myPos.Y, targetPos.Z)
	
		local head = char:FindFirstChild("Head")
		if head then
			local headPos = head.Position
			local headTarget = Vector3.new(flatTarget.X, headPos.Y, flatTarget.Z)
			head.CFrame = head.CFrame:Lerp(CFrame.lookAt(headPos, headTarget), 0.45)
			return
		end
	
		local targetCF = CFrame.lookAt(myPos, flatTarget)
		local currentCF = myRoot.CFrame
		myRoot.CFrame = currentCF:Lerp(targetCF, 0.35)
	end
	
	local function startStare()
		if connection then connection:Disconnect() end
		connection = RunService.Heartbeat:Connect(updateStare)
		print("[Stare] ON")
	end
	
	local function stopStare()
		if connection then connection:Disconnect() connection = nil end
		if humanoid then humanoid.AutoRotate = true end
		print("[Stare] OFF")
	end
	
	local function toggleStare()
		staring = not staring
		if staring then
			startStare()
		else
			stopStare()
		end
	end
	
	-- ✅ Toggle on "/" key press
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.KeyCode == Enum.KeyCode.Slash then
			toggleStare()
		end
	end)
	
	-- ✅ Toggle when parent GUI button is clicked
	local parent = script.Parent
	if parent and parent:IsA("GuiButton") then
		parent.MouseButton1Click:Connect(function()
			toggleStare()
		end)
	end
	
	-- Auto-re-enable after respawn if it was active
	local function onCharacterAdded(newChar)
		task.wait(1.2)
	
		local newHum = newChar:WaitForChild("Humanoid", 5)
		if newHum then
			newHum.AutoRotate = not staring
		end
	
		if staring then
			startStare()
		end
	end
	
	lp.CharacterAdded:Connect(onCharacterAdded)
	
	if lp.Character then
		onCharacterAdded(lp.Character)
	end
	
	print("[Stare Exploit] Loaded")
	print("Press / OR click the button to toggle ON/OFF")
	print("If ON when you die, it auto-re-enables after respawn")
end;
task.spawn(C_19);
-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
local function C_23()
local script = G2L["23"];
	-- LocalScript (place INSIDE your existing button / TextButton / ImageButton)
	
	local TweenService = game:GetService("TweenService")
	local Players = game:GetService("Players")
	
	local player = Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")
	
	local button = script.Parent  -- ← this is your button (the toggle)
	
	-- ────────────────────────────────────────────────
	-- Create the overlay only once (if not already exists)
	-- ────────────────────────────────────────────────
	
	local screenGuiName = "RedThemeOverlay"
	local overlayName   = "RedOverlay"
	
	local screenGui = playerGui:FindFirstChild(screenGuiName)
	if not screenGui then
		screenGui = Instance.new("ScreenGui")
		screenGui.Name = screenGuiName
		screenGui.ResetOnSpawn = false
		screenGui.IgnoreGuiInset = true
		screenGui.Parent = playerGui
	end
	
	local overlay = screenGui:FindFirstChild(overlayName)
	if not overlay then
		overlay = Instance.new("Frame")
		overlay.Name = overlayName
		overlay.Size = UDim2.new(1, 0, 1, 0)
		overlay.Position = UDim2.new(0, 0, 0, 0)
		overlay.BackgroundColor3 = Color3.fromRGB(180, 20, 20)   -- vivid red
		overlay.BackgroundTransparency = 1                       -- starts off
		overlay.BorderSizePixel = 0
		overlay.ZIndex = -10                                     -- behind most UI
		overlay.Parent = screenGui
	end
	
	-- ────────────────────────────────────────────────
	-- Toggle logic
	-- ────────────────────────────────────────────────
	
	local isEnabled = false
	
	local tweenInfo = TweenInfo.new(
		0.7,                            -- fade duration
		Enum.EasingStyle.Sine,
		Enum.EasingDirection.InOut
	)
	
	local function toggleOverlay()
		isEnabled = not isEnabled
	
		if isEnabled then
			-- Fade in red overlay
			TweenService:Create(overlay, tweenInfo, {
				BackgroundTransparency = 0.68   -- adjust: 0.5 = strong, 0.8 = subtle
			}):Play()
	
			-- Optional: change button appearance when active
			-- button.BackgroundColor3 = Color3.fromRGB(70, 20, 20)
			-- button.TextColor3 = Color3.fromRGB(255, 180, 180)
			print("Red theme overlay → ON")
		else
			-- Fade out
			TweenService:Create(overlay, tweenInfo, {
				BackgroundTransparency = 1
			}):Play()
	
			-- button.BackgroundColor3 = Color3.fromRGB(30, 30, 35)  -- default
			-- button.TextColor3 = Color3.new(1,1,1)
			print("Red theme overlay → OFF")
		end
	end
	
	-- Clicking the parent button toggles it
	button.MouseButton1Click:Connect(toggleOverlay)
	
	-- Optional: also toggle with a key (uncomment if you want)
	--[[
	local UserInputService = game:GetService("UserInputService")
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
	    if gameProcessed then return end
	    if input.KeyCode == Enum.KeyCode.RightControl then
	        toggleOverlay()
	    end
	end)
	--]]
	
	-- Optional: start with overlay ON
	-- toggleOverlay()
	
	print("Red overlay toggle loaded – click the parent button to turn it on/off")
end;
task.spawn(C_23);
-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
local function C_27()
local script = G2L["27"];
	-- VAPE V4 STYLE SPIDER CLIMB + FAKE FLOOR DETECTION (makes client think it's always on floor)
	-- LocalScript inside your button → click to toggle ON/OFF
	-- Hold LEFT SHIFT = Phase (noclip through walls)
	-- Forces Humanoid.FloorMaterial / GetState to think you're grounded → no fall damage / auto-jump feels natural
	
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	local Workspace = game:GetService("Workspace")
	
	local lp = Players.LocalPlayer
	local button = script.Parent
	
	local enabled = false
	local conn = nil
	local truss = nil
	
	-- Config (Vape defaults + fake floor)
	local MODE = "Velocity"          -- "Velocity", "CFrame", "Impulse", "Part"
	local SPEED = 28
	local PHASE = true               -- shift = phase
	local FAKE_FLOOR = true          -- makes client think always on ground
	
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Blacklist
	
	local function getRoot(char)
		return char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
	end
	
	local function isShiftDown()
		return UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
	end
	
	local function updateRayFilter()
		local filter = {Workspace.CurrentCamera}
		if lp.Character then table.insert(filter, lp.Character) end
		if truss then table.insert(filter, truss) end
		for _, p in Players:GetPlayers() do
			if p ~= lp and p.Character then table.insert(filter, p.Character) end
		end
		rayParams.FilterDescendantsInstances = filter
		local root = getRoot(lp.Character)
		if root then rayParams.CollisionGroup = root.CollisionGroup end
	end
	
	local function onPreSim(dt)
		if not enabled then return end
	
		local char = lp.Character
		if not char then return end
	
		local hum = char:FindFirstChildOfClass("Humanoid")
		if not hum then return end
	
		local root = getRoot(char)
		if not root then return end
	
		updateRayFilter()
	
		local shift = isShiftDown()
	
		-- Fake floor: force grounded state
		if FAKE_FLOOR then
			if hum:GetState() == Enum.HumanoidStateType.Freefall or hum:GetState() == Enum.HumanoidStateType.FallingDown then
				hum:ChangeState(Enum.HumanoidStateType.Landed)
				hum.FloorMaterial = Enum.Material.Plastic  -- fake floor material
			end
		end
	
		local moveDir = hum.MoveDirection
		if moveDir.Magnitude < 0.01 then moveDir = root.CFrame.LookVector end
	
		local rayOrigin = root.Position - Vector3.new(0, hum.HipHeight - 0.5, 0)
		local rayDir = moveDir * 2.5
	
		local ray = Workspace:Raycast(rayOrigin, rayDir, rayParams)
		local active = ray ~= nil
	
		if active and ray.Normal.Y == 0 then
			-- Wall hit → climb
			if PHASE and shift then
				root.Velocity = Vector3.new(root.Velocity.X, 0, root.Velocity.Z)
			else
				if CLIMB_STATE then
					hum:ChangeState(Enum.HumanoidStateType.Climbing)
				end
	
				root.Velocity = Vector3.new(root.Velocity.X, 0, root.Velocity.Z)
	
				if MODE == "CFrame" then
					root.CFrame += Vector3.new(0, SPEED * dt, 0)
				elseif MODE == "Impulse" then
					root:ApplyImpulse(Vector3.new(0, SPEED * root.AssemblyMass, 0))
				elseif MODE == "Part" then
					if not truss then
						truss = Instance.new("TrussPart")
						truss.Size = Vector3.new(2, 2, 2)
						truss.Transparency = 1
						truss.Anchored = true
						truss.CanCollide = true
						truss.Parent = Workspace.CurrentCamera
					end
					truss.Position = ray.Position - ray.Normal * 0.9
				else  -- Velocity
					root.Velocity += Vector3.new(0, SPEED, 0)
				end
			end
		else
			-- No wall → prevent fall velocity drop
			root.Velocity = Vector3.new(root.Velocity.X, math.max(root.Velocity.Y, 0), root.Velocity.Z)
		end
	end
	
	local function enableSpider()
		if conn then conn:Disconnect() end
	
		if MODE == "Part" and not truss then
			truss = Instance.new("TrussPart")
			truss.Size = Vector3.new(2, 2, 2)
			truss.Transparency = 1
			truss.Anchored = true
			truss.CanCollide = true
			truss.Parent = Workspace.CurrentCamera
		end
	
		conn = RunService.PreSimulation:Connect(onPreSim)
		print("Spider + Fake Floor → ENABLED (Shift = Phase)")
	end
	
	local function disableSpider()
		if conn then conn:Disconnect() conn = nil end
		if truss then truss:Destroy() truss = nil end
		print("Spider + Fake Floor → DISABLED")
	end
	
	local function toggle()
		enabled = not enabled
		if enabled then enableSpider() else disableSpider() end
	end
	
	button.MouseButton1Click:Connect(toggle)
	
	lp.CharacterAdded:Connect(function()
		task.wait(1)
		if truss then truss:Destroy() truss = nil end
		if enabled then enableSpider() end
	end)
	
	print("VapeV4 Spider + Fake Floor Loaded")
	print("Click button to toggle | Hold LeftShift = Phase | Client thinks always on ground")
end;
task.spawn(C_27);
-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
local function C_2d()
local script = G2L["2d"];
	-- VAPE V4 SPIDER CLIMB EXACT REPLICA (Standalone Toggle)
	-- LocalScript INSIDE your button - Click to toggle ON/OFF
	-- Hold LEFT SHIFT for Phase (noclip over spider climb)
	-- Hardcoded: Mode=Velocity, Speed=30, ClimbState=true, Phase=true
	
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	local Workspace = game:GetService("Workspace")
	
	local lplr = Players.LocalPlayer
	local button = script.Parent  -- toggle button
	
	-- Config (exact Vape defaults)
	local MODE = "Velocity"        -- "Velocity", "Impulse", "CFrame", "Part"
	local SPEED = 30               -- studs/sec
	local CLIMB_STATE = true       -- ChangeState Climbing
	local PHASE = true             -- true = shift enables phase (no climb)
	
	local enabled = false
	local conn = nil
	local Truss = nil
	local SpiderShift = false
	local Active = false
	
	local rayCheck = RaycastParams.new()
	rayCheck.FilterType = Enum.RaycastFilterType.Blacklist
	
	local function isAlive()
		local char = lplr.Character
		if not char then return false end
		local root = char:FindFirstChild("RootPart") or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
		if not root then return false end
		local hum = char:FindFirstChildOfClass("Humanoid")
		return hum and hum.Health > 0
	end
	
	local function getRoot()
		local char = lplr.Character
		return char and (char:FindFirstChild("RootPart") or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
	end
	
	local function buildFilter()
		local chars = {Workspace.CurrentCamera}
		local char = lplr.Character
		if char then table.insert(chars, char) end
		if Truss then table.insert(chars, Truss) end
		for _, v in Players:GetPlayers() do
			if v ~= lplr and v.Character then
				table.insert(chars, v.Character)
			end
		end
		rayCheck.FilterDescendantsInstances = chars
		local root = getRoot()
		if root then
			rayCheck.CollisionGroup = root.CollisionGroupId
		end
	end
	
	local function onPreSim(dt)
		if not isAlive() then return end
	
		local root = getRoot()
		local char = lplr.Character
		local hum = char:FindFirstChildOfClass("Humanoid")
	
		SpiderShift = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
		buildFilter()
	
		if MODE ~= "Part" then
			local vec = hum.MoveDirection * 2.5
			local rayOrigin = root.Position - Vector3.new(0, hum.HipHeight - 0.5, 0)
			local ray = Workspace:Raycast(rayOrigin, vec, rayCheck)
	
			if Active and not ray then
				root.Velocity = Vector3.new(root.Velocity.X, 0, root.Velocity.Z)
			end
	
			Active = ray ~= nil
	
			if Active and ray.Normal.Y == 0 then
				if not PHASE or not SpiderShift then
					if CLIMB_STATE then
						hum:ChangeState(Enum.HumanoidStateType.Climbing)
					end
					root.Velocity = root.Velocity * Vector3.new(1, 0, 1)
					if MODE == "CFrame" then
						root.CFrame = root.CFrame + Vector3.new(0, SPEED * dt, 0)
					elseif MODE == "Impulse" then
						root:ApplyImpulse(Vector3.new(0, SPEED, 0) * root.AssemblyMass)
					else  -- Velocity
						root.Velocity = root.Velocity + Vector3.new(0, SPEED, 0)
					end
				end
			end
		else  -- Part mode
			local rayOrigin = root.Position - Vector3.new(0, hum.HipHeight - 0.5, 0)
			local ray = Workspace:Raycast(rayOrigin, root.CFrame.LookVector * 2, rayCheck)
			if ray and (not PHASE or not SpiderShift) then
				Truss.Position = ray.Position - ray.Normal * 0.9
			else
				Truss.Position = Vector3.new(0, 0, 0)
			end
		end
	end
	
	local function enableSpider()
		if conn then conn:Disconnect() end
		if MODE == "Part" and not Truss then
			Truss = Instance.new("TrussPart")
			Truss.Size = Vector3.new(2, 2, 2)
			Truss.Transparency = 1
			Truss.Anchored = true
			Truss.Parent = Workspace.CurrentCamera
		end
		conn = RunService.PreSimulation:Connect(onPreSim)
		print("Spider -> ENABLED (Hold Shift for Phase)")
	end
	
	local function disableSpider()
		if conn then
			conn:Disconnect()
			conn = nil
		end
		if Truss then
			Truss.Parent = nil
			Truss = nil
		end
		SpiderShift = false
		Active = false
		print("Spider -> DISABLED")
	end
	
	local function toggle()
		enabled = not enabled
		if enabled then
			enableSpider()
		else
			disableSpider()
		end
	end
	
	button.MouseButton1Click:Connect(toggle)
	
	-- Respawn cleanup
	lplr.CharacterAdded:Connect(function()
		task.wait(1)
		Active = false
		if enabled then
			enableSpider()
		end
	end)
	
	print("VapeV4 Spider Loaded - Click button to toggle")
	print("Walk into walls to climb | Hold LeftShift for Phase")
end;
task.spawn(C_2d);
-- StarterGui.ScreenGui.Frame.UIDrag
local function C_2e()
local script = G2L["2e"];
	-- Made by Real_IceyDev (@lceyDex) --
	-- Simple UI dragger (PC Only/Any device that has a mouse) --
	
	local UIS = game:GetService('UserInputService')
	local frame = script.Parent
	local dragToggle = nil
	local dragSpeed = 0.25
	local dragStart = nil
	local startPos = nil
	
	local function updateInput(input)
		local delta = input.Position - dragStart
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
	end
	
	frame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
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
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragToggle then
				updateInput(input)
			end
		end
	end)
end;
task.spawn(C_2e);
-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
local function C_33()
local script = G2L["33"];
	--// BedWars Killaura - Standalone Exploit Script (UNC Style)
	--// Parent: Any exploit button / toggle
	
	local Killaura = {}
	
	-- ────────────────────────────────────────────────
	--  Configuration (tweak these values)
	-- ────────────────────────────────────────────────
	
	Killaura.Enabled          = false
	Killaura.RangeSwing       = 18
	Killaura.RangeAttack      = 18
	Killaura.MaxAngle         = 360
	Killaura.MaxTargets       = 5
	Killaura.UpdateRate       = 60          -- Hz
	Killaura.ChargeTime       = 0.42
	Killaura.SortMethod       = "Distance"   -- "Distance", "Damage", etc.
	Killaura.FaceTarget       = false
	Killaura.NoSwing          = false
	Killaura.ShowBoxes        = false
	Killaura.ShowParticles    = false
	Killaura.LimitToSword     = true
	Killaura.RequireMouseDown = false
	
	-- Colors (0-1 scale for HSV)
	local BOX_COLOR_SWING    = {0.6, 0.8, 1.0, 0.5}   -- hue, sat, val, alpha
	local BOX_COLOR_ATTACK   = {0.0, 0.8, 1.0, 0.6}
	
	-- ────────────────────────────────────────────────
	--  Services & Cached Objects
	-- ────────────────────────────────────────────────
	
	local Players             = game:GetService("Players")
	local RunService          = game:GetService("RunService")
	local TweenService        = game:GetService("TweenService")
	local UserInputService    = game:GetService("UserInputService")
	local ReplicatedStorage   = game:GetService("ReplicatedStorage")
	
	local LocalPlayer         = Players.LocalPlayer
	local Camera              = workspace.CurrentCamera
	
	-- BedWars remotes & controllers (common paths - may need updating per update)
	local BedwarsRemotes      = ReplicatedStorage:WaitForChild("BedwarsRemotes", 5)
	local AttackRemote        = BedwarsRemotes and BedwarsRemotes:FindFirstChild("SwordRemote") -- adjust name if different
	
	local Knit                -- will be set later
	local SwordController
	local ScytheController
	
	-- ────────────────────────────────────────────────
	--  Runtime variables
	-- ────────────────────────────────────────────────
	
	local Boxes               = {}
	local Particles           = {}
	local Connection
	local AnimTween
	local armC0
	local swingCooldown       = 0
	local AnimDelay           = 0
	local Attacking           = false
	
	-- ────────────────────────────────────────────────
	--  Utility Functions
	-- ────────────────────────────────────────────────
	
	local function getCharacter()
		return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	end
	
	local function isAlive(plr)
		local char = plr.Character
		if not char then return false end
		local hum = char:FindFirstChildOfClass("Humanoid")
		return hum and hum.Health > 0.1
	end
	
	local function getAttackData()
		-- You might need to hook or find real sword data
		-- For many exploits people just hardcode or raycast
		return {
			sword = {tool = getCharacter():FindFirstChildWhichIsA("Tool")},
			meta  = {sword = {attackSpeed = 0.3, respectAttackSpeedForEffects = true, displayName = ""}}
		}
	end
	
	local function getValidTargets()
		local char = getCharacter()
		if not char or not char.PrimaryPart then return {} end
	
		local selfPos    = char.PrimaryPart.Position
		local lookVector = char.PrimaryPart.CFrame.LookVector * Vector3.new(1,0,1)
	
		local targets = {}
	
		for _, plr in Players:GetPlayers() do
			if plr == LocalPlayer then continue end
			if not isAlive(plr) then continue end
	
			local targetChar = plr.Character
			local root       = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
			if not root then continue end
	
			local delta      = root.Position - selfPos
			local dist       = delta.Magnitude
			local flatDelta  = delta * Vector3.new(1,0,1)
			local angle      = math.acos(lookVector:Dot(flatDelta.Unit))
	
			if dist > Killaura.RangeSwing then continue end
			if math.deg(angle) > Killaura.MaxAngle / 2 then continue end
	
			table.insert(targets, {
				Player   = plr,
				RootPart = root,
				Distance = dist,
				Delta    = delta
			})
		end
	
		-- Simple sort (expand later)
		if Killaura.SortMethod == "Distance" then
			table.sort(targets, function(a,b) return a.Distance < b.Distance end)
		end
	
		-- Limit
		if #targets > Killaura.MaxTargets then
			for i = Killaura.MaxTargets + 1, #targets do
				targets[i] = nil
			end
		end
	
		return targets
	end
	
	local function switchToSword()
		local char = getCharacter()
		for _, tool in char:GetChildren() do
			if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
				LocalPlayer.Character.Humanoid:EquipTool(tool)
				task.wait(0.06)
				return tool
			end
		end
		return nil
	end
	
	-- ────────────────────────────────────────────────
	--  Visuals
	-- ────────────────────────────────────────────────
	
	local function createBoxes()
		for i = 1, 10 do
			local box = Instance.new("BoxHandleAdornment")
			box.Size          = Vector3.new(3.2, 5.4, 3.2)
			box.CFrame        = CFrame.new(0, -0.5, 0)
			box.AlwaysOnTop   = true
			box.ZIndex        = 0
			box.Transparency  = 1
			box.Adornee       = nil
			box.Parent        = game.CoreGui    -- or exploit drawing lib
			Boxes[i] = box
		end
	end
	
	local function updateBoxes(attacked)
		for i = 1, #Boxes do
			local target = attacked[i]
			local box    = Boxes[i]
	
			if target then
				box.Adornee     = target.RootPart
				local col = (target.Check == "attack") and BOX_COLOR_ATTACK or BOX_COLOR_SWING
				box.Color3      = Color3.fromHSV(col[1], col[2], col[3])
				box.Transparency = 1 - col[4]
			else
				box.Adornee     = nil
				box.Transparency = 1
			end
		end
	end
	
	-- ────────────────────────────────────────────────
	--  Main Loop
	-- ────────────────────────────────────────────────
	
	local function killauraLoop()
		if not Killaura.Enabled then return end
	
		local char = getCharacter()
		if not char or not char.PrimaryPart then
			task.wait(0.4)
			return
		end
	
		local swordTool = char:FindFirstChildWhichIsA("Tool")
		if Killaura.LimitToSword and not swordTool then
			task.wait(1 / Killaura.UpdateRate)
			return
		end
	
		if Killaura.RequireMouseDown and not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
			task.wait(1 / Killaura.UpdateRate)
			return
		end
	
		local attacked = {}
		local targets  = getValidTargets()
	
		if #targets > 0 then
			switchToSword()
	
			local selfPos    = char.PrimaryPart.Position
			local lookVector = char.PrimaryPart.CFrame.LookVector * Vector3.new(1,0,1)
	
			for _, target in targets do
				local root   = target.RootPart
				local delta  = target.Delta
				local dist   = target.Distance
	
				local shouldAttack = dist <= Killaura.RangeAttack
	
				table.insert(attacked, {
					RootPart = root,
					Check    = shouldAttack and "attack" or "swing"
				})
	
				if not Attacking then
					Attacking = true
					-- Play swing animation / effect here if you want
				end
	
				if not shouldAttack then continue end
				if (tick() - swingCooldown) < math.max(Killaura.ChargeTime, 0.03) then continue end
	
				swingCooldown = tick()
	
				if not AttackRemote then continue end
	
				local dir = CFrame.lookAt(selfPos, root.Position).LookVector
				local pos = selfPos + dir * math.max(dist - 14.4, 0)
	
				AttackRemote:FireServer({
					weapon                   = swordTool,
					chargedAttack            = {chargeRatio = 0},
					lastSwingServerTimeDelta = 0.5,
					entityInstance           = target.Player.Character,
					validate = {
						raycast = {
							cameraPosition  = {value = pos},
							cursorDirection = {value = dir}
						},
						targetPosition = {value = root.Position},
						selfPosition   = {value = pos}
					}
				})
			end
	
			if Killaura.FaceTarget and attacked[1] then
				local vec = attacked[1].RootPart.Position * Vector3.new(1,0,1)
				char.PrimaryPart.CFrame = CFrame.lookAt(
					char.PrimaryPart.Position,
					Vector3.new(vec.X, char.PrimaryPart.Position.Y + 0.001, vec.Z)
				)
			end
		else
			Attacking = false
		end
	
		if Killaura.ShowBoxes then
			updateBoxes(attacked)
		end
	
		task.wait(1 / Killaura.UpdateRate)
	end
	
	-- ────────────────────────────────────────────────
	--  Toggle Logic (call this from your exploit button)
	-- ────────────────────────────────────────────────
	
	function Killaura:Toggle()
		Killaura.Enabled = not Killaura.Enabled
	
		if Killaura.Enabled then
			if Killaura.ShowBoxes and #Boxes == 0 then
				createBoxes()
			end
	
			if Connection then Connection:Disconnect() end
			Connection = RunService.Heartbeat:Connect(killauraLoop)
			print("[Killaura] Activated")
		else
			if Connection then
				Connection:Disconnect()
				Connection = nil
			end
	
			Attacking = false
			swingCooldown = 0
	
			for _, box in Boxes do
				box:Destroy()
			end
			table.clear(Boxes)
	
			print("[Killaura] Deactivated")
		end
	end
	
	-- For exploit UI / button:
	-- myExploitButton.MouseButton1Click:Connect(function()
	--     Killaura:Toggle()
	-- end)
	
	return Killaura
end;
task.spawn(C_33);
-- StarterGui.ScreenGui.LocalScript
local function C_34()
local script = G2L["34"];
	local screenGui = script.Parent
	
	-- Make sure the GUI does NOT reset on respawn
	screenGui.ResetOnSpawn = false
	
	-- Extra protection: if something tries to disable it, turn it back on
	screenGui:GetPropertyChangedSignal("Enabled"):Connect(function()
		if not screenGui.Enabled then
			screenGui.Enabled = true
		end
	end)
end;
task.spawn(C_34);

return G2L["1"], require;
