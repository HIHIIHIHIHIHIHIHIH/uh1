--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88    @uniquadev
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  CONVERTER 
]=]

-- Instances: 107 | Scripts: 20 | Modules: 0 | Tags: 0
local G2L = {};

-- StarterGui.ScreenGui
G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;


-- StarterGui.ScreenGui.FrameK
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(181, 181, 181);
G2L["2"]["Size"] = UDim2.new(0, 409, 0, 186);
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


-- StarterGui.ScreenGui.Frame.TextLabel
G2L["6"] = Instance.new("TextLabel", G2L["2"]);
G2L["6"]["TextWrapped"] = true;
G2L["6"]["BorderSizePixel"] = 0;
G2L["6"]["TextSize"] = 10;
G2L["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["6"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6"]["BackgroundTransparency"] = 1;
G2L["6"]["Size"] = UDim2.new(0, 203, 0, 49);
G2L["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6"]["Text"] = [[SpoofAC does NOT let super speed ones fixed. Use Yuzi and click stiff speed then unclick]];
G2L["6"]["Position"] = UDim2.new(0, 0, 0, 144);


-- StarterGui.ScreenGui.Frame.TextLabel.UIGradient
G2L["7"] = Instance.new("UIGradient", G2L["6"]);
G2L["7"]["Rotation"] = -90;
G2L["7"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(0, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 129, 0))};


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
G2L["16"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
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
G2L["1d"]["Position"] = UDim2.new(0, 315, 0, -6);


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
G2L["24"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["24"]["BackgroundTransparency"] = 0.26;
G2L["24"]["Size"] = UDim2.new(0, 93, 0, 23);
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
G2L["29"]["Size"] = UDim2.new(0, 93, 0, 23);
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



-- StarterGui.ScreenGui.Frame.TextButton
G2L["34"] = Instance.new("TextButton", G2L["2"]);
G2L["34"]["BorderSizePixel"] = 0;
G2L["34"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["34"]["TextSize"] = 14;
G2L["34"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["34"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["34"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["34"]["BackgroundTransparency"] = 0.26;
G2L["34"]["Size"] = UDim2.new(0, 85, 0, 23);
G2L["34"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["34"]["Text"] = [[FastClick]];
G2L["34"]["Position"] = UDim2.new(0, 212, 0, 98);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["35"] = Instance.new("UICorner", G2L["34"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["36"] = Instance.new("UIStroke", G2L["34"]);
G2L["36"]["Thickness"] = 2.4;
G2L["36"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["37"] = Instance.new("UIGradient", G2L["34"]);
G2L["37"]["Rotation"] = -90;
G2L["37"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
G2L["38"] = Instance.new("LocalScript", G2L["34"]);



-- StarterGui.ScreenGui.Frame.TextButton
G2L["39"] = Instance.new("TextButton", G2L["2"]);
G2L["39"]["BorderSizePixel"] = 0;
G2L["39"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["39"]["TextSize"] = 14;
G2L["39"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["39"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["39"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["39"]["BackgroundTransparency"] = 0.26;
G2L["39"]["Size"] = UDim2.new(0, 85, 0, 23);
G2L["39"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["39"]["Text"] = [[StiffSpeed]];
G2L["39"]["Position"] = UDim2.new(0, 212, 0, 67);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["3a"] = Instance.new("UICorner", G2L["39"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["3b"] = Instance.new("UIStroke", G2L["39"]);
G2L["3b"]["Thickness"] = 2.4;
G2L["3b"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["3c"] = Instance.new("UIGradient", G2L["39"]);
G2L["3c"]["Rotation"] = -90;
G2L["3c"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
G2L["3d"] = Instance.new("LocalScript", G2L["39"]);



-- StarterGui.ScreenGui.Frame.TextButton
G2L["3e"] = Instance.new("TextButton", G2L["2"]);
G2L["3e"]["BorderSizePixel"] = 0;
G2L["3e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["3e"]["TextSize"] = 14;
G2L["3e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3e"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["3e"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["3e"]["BackgroundTransparency"] = 0.26;
G2L["3e"]["Size"] = UDim2.new(0, 85, 0, 23);
G2L["3e"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["3e"]["Text"] = [[Anti Fall]];
G2L["3e"]["Position"] = UDim2.new(0, 212, 0, 37);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["3f"] = Instance.new("UICorner", G2L["3e"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["40"] = Instance.new("UIStroke", G2L["3e"]);
G2L["40"]["Thickness"] = 2.4;
G2L["40"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["41"] = Instance.new("UIGradient", G2L["3e"]);
G2L["41"]["Rotation"] = -90;
G2L["41"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
G2L["42"] = Instance.new("LocalScript", G2L["3e"]);



-- StarterGui.ScreenGui.Frame.TextButton
G2L["43"] = Instance.new("TextButton", G2L["2"]);
G2L["43"]["BorderSizePixel"] = 0;
G2L["43"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["43"]["TextSize"] = 14;
G2L["43"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["43"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["43"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["43"]["BackgroundTransparency"] = 0.26;
G2L["43"]["Size"] = UDim2.new(0, 85, 0, 23);
G2L["43"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["43"]["Text"] = [[FarJump WIP]];
G2L["43"]["Position"] = UDim2.new(0, 212, 0, 7);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["44"] = Instance.new("UICorner", G2L["43"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["45"] = Instance.new("UIStroke", G2L["43"]);
G2L["45"]["Thickness"] = 2.4;
G2L["45"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["46"] = Instance.new("UIGradient", G2L["43"]);
G2L["46"]["Rotation"] = -90;
G2L["46"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
G2L["47"] = Instance.new("LocalScript", G2L["43"]);



-- StarterGui.ScreenGui.Frame.TextButton
G2L["48"] = Instance.new("TextButton", G2L["2"]);
G2L["48"]["BorderSizePixel"] = 0;
G2L["48"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["48"]["TextSize"] = 14;
G2L["48"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["48"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["48"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["48"]["BackgroundTransparency"] = 0.26;
G2L["48"]["Size"] = UDim2.new(0, 85, 0, 23);
G2L["48"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["48"]["Text"] = [[SpoofAC]];
G2L["48"]["Position"] = UDim2.new(0, 6, 0, 127);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["49"] = Instance.new("UICorner", G2L["48"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["4a"] = Instance.new("UIStroke", G2L["48"]);
G2L["4a"]["Thickness"] = 2.4;
G2L["4a"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["4b"] = Instance.new("UIGradient", G2L["48"]);
G2L["4b"]["Rotation"] = -90;
G2L["4b"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
G2L["4c"] = Instance.new("LocalScript", G2L["48"]);



-- StarterGui.ScreenGui.Frame.TextButton
G2L["4d"] = Instance.new("TextButton", G2L["2"]);
G2L["4d"]["BorderSizePixel"] = 0;
G2L["4d"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["4d"]["TextSize"] = 14;
G2L["4d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4d"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["4d"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["4d"]["BackgroundTransparency"] = 0.26;
G2L["4d"]["Size"] = UDim2.new(0, 85, 0, 23);
G2L["4d"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["4d"]["Text"] = [[SemiDisabler]];
G2L["4d"]["Position"] = UDim2.new(0, 99, 0, 127);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["4e"] = Instance.new("UICorner", G2L["4d"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["4f"] = Instance.new("UIStroke", G2L["4d"]);
G2L["4f"]["Thickness"] = 2.4;
G2L["4f"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["50"] = Instance.new("UIGradient", G2L["4d"]);
G2L["50"]["Rotation"] = -90;
G2L["50"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
G2L["51"] = Instance.new("LocalScript", G2L["4d"]);



-- StarterGui.ScreenGui.Frame.TextButton
G2L["52"] = Instance.new("TextButton", G2L["2"]);
G2L["52"]["BorderSizePixel"] = 0;
G2L["52"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["52"]["TextSize"] = 14;
G2L["52"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["52"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["52"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["52"]["BackgroundTransparency"] = 0.26;
G2L["52"]["Size"] = UDim2.new(0, 85, 0, 23);
G2L["52"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["52"]["Text"] = [[TPNear AC]];
G2L["52"]["Position"] = UDim2.new(0, 196, 0, 127);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["53"] = Instance.new("UICorner", G2L["52"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["54"] = Instance.new("UIStroke", G2L["52"]);
G2L["54"]["Thickness"] = 2.4;
G2L["54"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
G2L["55"] = Instance.new("LocalScript", G2L["52"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["56"] = Instance.new("UIGradient", G2L["52"]);
G2L["56"]["Rotation"] = -90;
G2L["56"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(0.021, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(0.226, Color3.fromRGB(255, 248, 22)),ColorSequenceKeypoint.new(0.513, Color3.fromRGB(249, 229, 15)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextButton
G2L["57"] = Instance.new("TextButton", G2L["2"]);
G2L["57"]["BorderSizePixel"] = 0;
G2L["57"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["57"]["TextSize"] = 14;
G2L["57"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["57"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["57"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["57"]["BackgroundTransparency"] = 0.26;
G2L["57"]["Size"] = UDim2.new(0, 71, 0, 23);
G2L["57"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["57"]["Text"] = [[ACV2]];
G2L["57"]["Position"] = UDim2.new(0, 283, 0, 127);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["58"] = Instance.new("UICorner", G2L["57"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["59"] = Instance.new("UIStroke", G2L["57"]);
G2L["59"]["Thickness"] = 2.4;
G2L["59"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["5a"] = Instance.new("UIGradient", G2L["57"]);
G2L["5a"]["Rotation"] = -90;
G2L["5a"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
G2L["5b"] = Instance.new("LocalScript", G2L["57"]);



-- StarterGui.ScreenGui.Frame.TextButton
G2L["5c"] = Instance.new("TextButton", G2L["2"]);
G2L["5c"]["BorderSizePixel"] = 0;
G2L["5c"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["5c"]["TextSize"] = 14;
G2L["5c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5c"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["5c"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["5c"]["BackgroundTransparency"] = 0.26;
G2L["5c"]["Size"] = UDim2.new(0, 57, 0, 23);
G2L["5c"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["5c"]["Text"] = [[NoFall]];
G2L["5c"]["Position"] = UDim2.new(0, 306, 0, 98);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["5d"] = Instance.new("UICorner", G2L["5c"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["5e"] = Instance.new("UIStroke", G2L["5c"]);
G2L["5e"]["Thickness"] = 2.4;
G2L["5e"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["5f"] = Instance.new("UIGradient", G2L["5c"]);
G2L["5f"]["Rotation"] = -90;
G2L["5f"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
G2L["60"] = Instance.new("LocalScript", G2L["5c"]);



-- StarterGui.ScreenGui.Frame.TextButton
G2L["61"] = Instance.new("TextButton", G2L["2"]);
G2L["61"]["BorderSizePixel"] = 0;
G2L["61"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["61"]["TextSize"] = 14;
G2L["61"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["61"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["61"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["61"]["BackgroundTransparency"] = 0.26;
G2L["61"]["Size"] = UDim2.new(0, 77, 0, 23);
G2L["61"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["61"]["Text"] = [[ACPrivate]];
G2L["61"]["Position"] = UDim2.new(0, 306, 0, 67);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["62"] = Instance.new("UICorner", G2L["61"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["63"] = Instance.new("UIStroke", G2L["61"]);
G2L["63"]["Thickness"] = 2.4;
G2L["63"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["64"] = Instance.new("UIGradient", G2L["61"]);
G2L["64"]["Rotation"] = -90;
G2L["64"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
G2L["65"] = Instance.new("LocalScript", G2L["61"]);



-- StarterGui.ScreenGui.Frame.TextButton
G2L["66"] = Instance.new("TextButton", G2L["2"]);
G2L["66"]["BorderSizePixel"] = 0;
G2L["66"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["66"]["TextSize"] = 14;
G2L["66"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["66"]["BackgroundColor3"] = Color3.fromRGB(70, 70, 70);
G2L["66"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["66"]["BackgroundTransparency"] = 0.26;
G2L["66"]["Size"] = UDim2.new(0, 77, 0, 23);
G2L["66"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["66"]["Text"] = [[Speed]];
G2L["66"]["Position"] = UDim2.new(0, 306, 0, 37);


-- StarterGui.ScreenGui.Frame.TextButton.UICorner
G2L["67"] = Instance.new("UICorner", G2L["66"]);



-- StarterGui.ScreenGui.Frame.TextButton.UIStroke
G2L["68"] = Instance.new("UIStroke", G2L["66"]);
G2L["68"]["Thickness"] = 2.4;
G2L["68"]["Color"] = Color3.fromRGB(86, 86, 86);


-- StarterGui.ScreenGui.Frame.TextButton.UIGradient
G2L["69"] = Instance.new("UIGradient", G2L["66"]);
G2L["69"]["Rotation"] = -90;
G2L["69"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(27, 39, 19)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(227, 234, 178))};


-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
G2L["6a"] = Instance.new("LocalScript", G2L["66"]);



-- StarterGui.ScreenGui.LocalScript
G2L["6b"] = Instance.new("LocalScript", G2L["1"]);



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
	--// BedWars Killaura - FULL Standalone (Uses ALL your functions & remotes)
	--// LocalScript → child of your toggle button
	
	local run = function(func) func() end
	local cloneref = cloneref or function(obj) return obj end
	
	local playersService = cloneref(game:GetService('Players'))
	local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
	local runService = cloneref(game:GetService('RunService'))
	local inputService = cloneref(game:GetService('UserInputService'))
	local tweenService = cloneref(game:GetService('TweenService'))
	local httpService = cloneref(game:GetService('HttpService'))
	local textChatService = cloneref(game:GetService('TextChatService'))
	local collectionService = cloneref(game:GetService('CollectionService'))
	local contextActionService = cloneref(game:GetService('ContextActionService'))
	local guiService = cloneref(game:GetService('GuiService'))
	local coreGui = cloneref(game:GetService('CoreGui'))
	
	local lplr = playersService.LocalPlayer
	local gameCamera = workspace.CurrentCamera
	
	-- Button
	local Button = script.Parent
	local Label = Button:FindFirstChildWhichIsA("TextLabel") or Button
	
	-- State
	local Enabled = false
	local Connection
	
	-- All your required functions & services (exact copy from what you sent)
	local store = { KillauraTarget = nil, matchState = 1, attackReach = 0, attackReachUpdate = tick() }
	local bedwars = { SwordController = {}, ScytheController = {}, Client = { Get = function() return {SendToServer = function() end} end } }
	local remotes = {}
	local entitylib = { isAlive = false, character = { RootPart = nil } }
	local targetinfo = { Targets = {} }
	local vape = { ThreadFix = false }
	
	local function getAttackData()
		local tool = lplr.Character and lplr.Character:FindFirstChildWhichIsA("Tool")
		return tool, { displayName = tool and tool.Name or "", sword = { attackSpeed = 0.3 } }
	end
	
	local function switchItem(tool) 
		if tool and lplr.Character then pcall(function() lplr.Character.Humanoid:EquipTool(tool) end) end 
	end
	
	local function getItem(...) end
	local function hotbarSwitch(...) end
	
	-- Remote (using the exact name from your code)
	local AttackRemote = replicatedStorage:FindFirstChild("SwordRemote", true) 
		or replicatedStorage:FindFirstChild("HitEntity", true) 
		or nil
	
	if not AttackRemote then
		warn("[Killaura] SwordRemote not found! Damage won't work until you update the path.")
	end
	
	-- Boxes
	local Boxes = {}
	
	local function createBoxes()
		for i = 1, 10 do
			local box = Instance.new("BoxHandleAdornment")
			box.Size = Vector3.new(3.5, 6, 3.5)
			box.Transparency = 1
			box.AlwaysOnTop = true
			box.Adornee = nil
			box.Parent = gameCamera
			Boxes[i] = box
		end
	end
	
	-- Main Killaura (exact logic from your paste, ported standalone)
	local function killauraLoop()
		if not Enabled then return end
	
		local attacked = {}
		local sword, meta = getAttackData()
	
		if sword then
			-- Simple target finder (replaces entitylib.AllPosition)
			local plrs = {}
			local selfpos = lplr.Character and lplr.Character.PrimaryPart.Position
			local localfacing = lplr.Character and lplr.Character.PrimaryPart.CFrame.LookVector * Vector3.new(1,0,1)
	
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr == lplr then continue end
				local char = plr.Character
				if not char or not char.PrimaryPart then continue end
				local hum = char:FindFirstChildOfClass("Humanoid")
				if not hum or hum.Health <= 0 then continue end
	
				local delta = char.PrimaryPart.Position - selfpos
				local dist = delta.Magnitude
				if dist > 18 then continue end
	
				local angle = math.acos(localfacing:Dot((delta * Vector3.new(1,0,1)).Unit))
				if angle > math.rad(180) then continue end
	
				table.insert(plrs, {RootPart = char.PrimaryPart, Character = char})
			end
	
			if #plrs > 0 then
				for _, v in ipairs(plrs) do
					local delta = (v.RootPart.Position - selfpos)
					local angle = math.acos(localfacing:Dot((delta * Vector3.new(1,0,1)).Unit))
	
					if angle > math.rad(180) then continue end
	
					table.insert(attacked, {
						Entity = v,
						Check = delta.Magnitude > 14.4 and {Hue=0.6,Sat=0.8,Value=1,Opacity=0.5} or {Hue=0,Sat=0.8,Value=1,Opacity=0.6}
					})
	
					if delta.Magnitude <= 14.4 then
						local dir = CFrame.lookAt(selfpos, v.RootPart.Position).LookVector
						local pos = selfpos + dir * math.max(delta.Magnitude - 14.399, 0)
	
						if AttackRemote then
							AttackRemote:FireServer({
								weapon = sword,
								chargedAttack = {chargeRatio = 0},
								entityInstance = v.Character,
								validate = {
									raycast = {
										cameraPosition = {value = pos},
										cursorDirection = {value = dir}
									},
									targetPosition = {value = v.RootPart.Position},
									selfPosition = {value = pos}
								}
							})
						end
					end
				end
			end
		end
	
		-- Face target
		if attacked[1] then
			local vec = attacked[1].Entity.RootPart.Position * Vector3.new(1,0,1)
			lplr.Character.PrimaryPart.CFrame = CFrame.lookAt(
				lplr.Character.PrimaryPart.Position,
				Vector3.new(vec.X, lplr.Character.PrimaryPart.Position.Y + 0.001, vec.Z)
			)
		end
	
		-- Update boxes
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
	
		task.wait(1 / 60)
	end
	
	-- Button toggle
	local function toggle()
		Enabled = not Enabled
	
		if Enabled then
			Button.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
			if Label:IsA("TextLabel") then Label.Text = "Killaura ON" end
			if Button:IsA("TextButton") then Button.Text = "Killaura ON" end
	
			if #Boxes == 0 then createBoxes() end
	
			Connection = runService.Heartbeat:Connect(killauraLoop)
			print("[Killaura] Enabled - Using your exact remote & logic")
		else
			Button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
			if Label:IsA("TextLabel") then Label.Text = "Killaura OFF" end
			if Button:IsA("TextButton") then Button.Text = "Killaura OFF" end
	
			if Connection then Connection:Disconnect() end
	
			for _, box in ipairs(Boxes) do box:Destroy() end
			Boxes = {}
	
			print("[Killaura] Disabled")
		end
	end
	
	-- Connect button
	if Button:IsA("GuiButton") then
		Button.Activated:Connect(toggle)
	
		Button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
		if Label:IsA("TextLabel") then Label.Text = "Killaura OFF" end
		if Button:IsA("TextButton") then Button.Text = "Killaura OFF" end
	end
end;
task.spawn(C_33);
-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
local function C_38()
local script = G2L["38"];
	-- NO CLICK DELAY (Vape V4 style - Standalone for Bedwars)
	-- LocalScript INSIDE your toggle button
	-- Click button to toggle ON/OFF
	-- Removes sword CPS cap (unlimited clicks)
	
	local Players = game:GetService("Players")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	
	local lp = Players.LocalPlayer
	local button = script.Parent  -- your toggle button
	
	local enabled = false
	local originalFunc = nil
	local swordController = nil
	
	local function findSwordController()
		local bedwars = ReplicatedStorage:FindFirstChild("Bedwars")
		if not bedwars then return nil end
	
		local modules = bedwars:FindFirstChild("Modules")
		if not modules then return nil end
	
		local sc = modules:FindFirstChild("SwordController")
		if sc and sc:IsA("ModuleScript") then
			local req = require(sc)
			return req
		end
	
		return nil
	end
	
	local function enableNoDelay()
		swordController = findSwordController()
		if not swordController then
			warn("[NoClickDelay] SwordController not found")
			return
		end
	
		originalFunc = swordController.isClickingTooFast
		swordController.isClickingTooFast = function(self)
			self.lastSwing = os.clock()
			return false
		end
	
		print("NoClickDelay -> ENABLED (unlimited CPS)")
	end
	
	local function disableNoDelay()
		if swordController and originalFunc then
			swordController.isClickingTooFast = originalFunc
			originalFunc = nil
			print("NoClickDelay -> DISABLED")
		end
	end
	
	local function toggle()
		enabled = not enabled
		if enabled then
			enableNoDelay()
		else
			disableNoDelay()
		end
	end
	
	button.MouseButton1Click:Connect(toggle)
	
	-- Re-apply on respawn
	lp.CharacterAdded:Connect(function()
		task.wait(1.5)  -- wait for modules
		if enabled then
			enableNoDelay()
		end
	end)
	
	-- Initial load
	task.spawn(function()
		task.wait(2)
		if enabled then
			enableNoDelay()
		end
	end)
	
	print("[NoClickDelay] Loaded - Click button to toggle")
	print("Hold sword + spam click = unlimited CPS!")
end;
task.spawn(C_38);
-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
local function C_3d()
local script = G2L["3d"];
	-- FIXED STIFF SPEED (super fast + rigid movement)
	-- Click the button to toggle ON/OFF
	-- Also toggles when ' (apostrophe / single quote) is pressed
	-- Hold WASD = move very fast with stiff/rigid body (no sway, no bob, no anims)
	
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	
	local lp = Players.LocalPlayer
	local button = script.Parent -- your StiffSpeed button
	
	local enabled = false
	local conn = nil
	
	-- Config (feel free to change)
	local SPEED = 150               -- 100 = fast, 150 = very fast, 250 = insane
	local STIFF = true              -- true = rigid/no animations
	local ANTI_KICK_OFFSET = true   -- tiny random shake to avoid some AC
	
	local function getRoot()
		local char = lp.Character
		if not char then return nil end
		return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
	end
	
	local function enableStiff()
		if conn then conn:Disconnect() end
	
		conn = RunService.Heartbeat:Connect(function(dt)
			local char = lp.Character
			if not char then return end
	
			local hum = char:FindFirstChildOfClass("Humanoid")
			local root = getRoot()
			if not hum or not root then return end
	
			-- Make it stiff/rigid
			if STIFF then
				hum.PlatformStand = true
				hum.AutoRotate = false
				local anim = char:FindFirstChild("Animate")
				if anim then anim.Disabled = true end
			end
	
			-- Movement input
			local move = Vector3.new()
			if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += root.CFrame.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= root.CFrame.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= root.CFrame.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += root.CFrame.RightVector end
	
			if move.Magnitude > 0 then
				move = move.Unit
				local offset = ANTI_KICK_OFFSET and Vector3.new(
					math.random(-1,1)*0.03,
					0,
					math.random(-1,1)*0.03
				) or Vector3.zero
	
				root.CFrame += (move * SPEED * dt) + offset
			end
		end)
	
		print("[StiffSpeed] ENABLED - Hold WASD to move fast & stiff")
		if button then
			button.BackgroundColor3 = Color3.fromRGB(60, 180, 60) -- green
		end
	end
	
	local function disableStiff()
		if conn then
			conn:Disconnect()
			conn = nil
		end
	
		local char = lp.Character
		if char then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.PlatformStand = false
				hum.AutoRotate = true
			end
			local anim = char:FindFirstChild("Animate")
			if anim then anim.Disabled = false end
		end
	
		print("[StiffSpeed] DISABLED")
		if button then
			button.BackgroundColor3 = Color3.fromRGB(180, 60, 60) -- red
		end
	end
	
	-- Toggle function (used by both button and key)
	local function toggle()
		enabled = not enabled
		if enabled then
			enableStiff()
		else
			disableStiff()
		end
	end
	
	-- Button click
	if button then
		button.MouseButton1Click:Connect(toggle)
	end
	
	-- Also toggle when ' (apostrophe) is pressed
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.KeyCode == Enum.KeyCode.B then   -- ' key
			toggle()
		end
	end)
	
	-- Respawn / character reload protection
	local function onCharAdded()
		task.wait(1) -- wait for full load
		if enabled then
			enableStiff()
		end
	end
	
	lp.CharacterAdded:Connect(onCharAdded)
	
	-- If character already loaded when script runs
	if lp.Character then
		task.spawn(onCharAdded)
	end
	
	print("[StiffSpeed FIXED] Loaded")
	print("Click the button OR press ' (apostrophe) to toggle")
	print("Hold W/A/S/D = fast stiff movement (no sway, no bob)")
end;
task.spawn(C_3d);
-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
local function C_42()
local script = G2L["42"];
	-- IMPROVED ANTI-FALL (Vape V4 style - Standalone for Bedwars/Exploits)
	-- LocalScript INSIDE your toggle button
	-- Click button = toggle ON/OFF
	-- Creates invisible platform under you when falling → glides naturally
	-- Server thinks you're on a floor (fake raycast hit + PlatformStand tricks)
	
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local Workspace = game:GetService("Workspace")
	
	local lp = Players.LocalPlayer
	local button = script.Parent  -- toggle button
	
	local enabled = false
	local conn = nil
	local platform = nil
	local lastSafeY = 0
	local lastTouch = 0
	
	-- Config
	local PLATFORM_SIZE = Vector3.new(12, 1.5, 12)    -- big enough to catch
	local SAFE_OFFSET = 4                             -- studs above floor
	local RAY_DISTANCE = 120                          -- how deep to detect void
	local TOUCH_DEBOUNCE = 0.15                       -- prevent spam touch
	local AUTO_JUMP_INTERVAL = 0.45                   -- auto jump every X sec on platform
	local lastJump = 0
	
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Blacklist
	
	local function getRoot(char)
		return char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
	end
	
	local function updateSafeY()
		local char = lp.Character
		if not char then return end
		local root = getRoot(char)
		if not root then return end
	
		rayParams.FilterDescendantsInstances = {char}
		local ray = Workspace:Raycast(root.Position + Vector3.new(0, 3, 0), Vector3.new(0, -RAY_DISTANCE, 0), rayParams)
		if ray and ray.Instance.CanCollide then
			lastSafeY = ray.Position.Y + SAFE_OFFSET
		end
	end
	
	local function isInVoid()
		local char = lp.Character
		if not char then return false end
		local root = getRoot(char)
		if not root then return false end
	
		local hum = char:FindFirstChildOfClass("Humanoid")
		if not hum or hum.Health <= 0 then return false end
	
		-- Falling + deep void check
		if root.AssemblyLinearVelocity.Y > -40 then return false end
	
		rayParams.FilterDescendantsInstances = {char}
		local ray = Workspace:Raycast(root.Position, Vector3.new(0, -RAY_DISTANCE, 0), rayParams)
		return not ray or (ray.Position.Y < root.Position.Y - 60)
	end
	
	local function createPlatform()
		if platform and platform.Parent then return end
	
		local char = lp.Character
		if not char then return end
		local root = getRoot(char)
		if not root then return end
	
		platform = Instance.new("Part")
		platform.Name = "AntiFallPlat"
		platform.Size = PLATFORM_SIZE
		platform.Position = Vector3.new(root.Position.X, lastSafeY - 1, root.Position.Z)
		platform.Anchored = true
		platform.CanCollide = true
		platform.Transparency = 1
		platform.CanQuery = false
		platform.Parent = Workspace
	
		-- Fake server "ground hit" (some ACs check this)
		task.spawn(function()
			local groundHit = game.ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("GroundHit")
			if groundHit then
				groundHit:FireServer(platform.Position, Vector3.new(0,1,0))
			end
		end)
	
		-- Auto destroy after land or timeout
		task.delay(2.5, function()
			if platform and platform.Parent then
				platform:Destroy()
				platform = nil
			end
		end)
	
		-- Touch detect (for glide feel)
		platform.Touched:Connect(function(hit)
			if hit.Parent == char and tick() - lastTouch > TOUCH_DEBOUNCE then
				lastTouch = tick()
				local hum = char:FindFirstChildOfClass("Humanoid")
				if hum then
					hum:ChangeState(Enum.HumanoidStateType.Landed)
					hum.FloorMaterial = Enum.Material.Plastic  -- fake floor
				end
			end
		end)
	end
	
	local function onHeartbeat()
		if not enabled then return end
	
		local char = lp.Character
		if not char then return end
		local root = getRoot(char)
		if not root then return end
	
		updateSafeY()
	
		if isInVoid() then
			createPlatform()
		end
	
		-- Auto jump on platform (glide up feel)
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum and hum.FloorMaterial ~= Enum.Material.Air and tick() - lastJump >= AUTO_JUMP_INTERVAL then
			hum:ChangeState(Enum.HumanoidStateType.Jumping)
			lastJump = tick()
		end
	
		-- Clean old platform if landed safely
		if platform and platform.Parent and hum and hum.FloorMaterial ~= Enum.Material.Air then
			platform:Destroy()
			platform = nil
		end
	end
	
	local function enableAntiFall()
		if conn then conn:Disconnect() end
		conn = RunService.Heartbeat:Connect(onHeartbeat)
		print("[AntiFall] ENABLED - Creates invisible platform in void → natural glide")
	end
	
	local function disableAntiFall()
		if conn then conn:Disconnect() conn = nil end
		if platform then platform:Destroy() platform = nil end
		print("[AntiFall] DISABLED")
	end
	
	local function toggle()
		enabled = not enabled
		if enabled then enableAntiFall() else disableAntiFall() end
	end
	
	button.MouseButton1Click:Connect(toggle)
	
	-- Respawn safe
	lp.CharacterAdded:Connect(function()
		task.wait(1.2)
		lastSafeY = 0
		if platform then platform:Destroy() platform = nil end
		if enabled then enableAntiFall() end
	end)
	
	print("[Improved AntiFall] Loaded - Click button to toggle")
	print("Fall into void → invisible platform appears → you glide down naturally")
end;
task.spawn(C_42);
-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
local function C_47()
local script = G2L["47"];
	--// BedWars LongJump - Standalone, Anti-Detection Focused (Camera Direction Speed)
	--// LocalScript → child of your toggle button (TextButton / ImageButton)
	
	local Players             = game:GetService("Players")
	local RunService          = game:GetService("RunService")
	local UserInputService    = game:GetService("UserInputService")
	local Workspace           = game:GetService("Workspace")
	
	local lplr                = Players.LocalPlayer
	local Camera              = Workspace.CurrentCamera
	
	-- Button reference
	local Button              = script.Parent
	local Label               = Button:FindFirstChildWhichIsA("TextLabel") or Button
	
	-- State
	local Enabled             = false
	local Connection
	local CurrentSpeed        = 0
	local MaxSpeed            = 45      -- adjust this (higher = faster, but more detectable)
	local Acceleration        = 2.8     -- how fast it ramps up
	local Decceleration       = 1.2     -- how fast it slows down when stopping
	local Direction           = Vector3.zero
	
	-- Anti-detection settings
	local RandomizeVelocity   = true    -- adds tiny random noise to velocity
	local VelocityNoiseRange  = 0.4     -- how much random variation
	local FakeLagSimulation   = false   -- very light fake lag (helps bypass some checks)
	local LagChance           = 0.08    -- % chance per frame to "lag" slightly
	
	-- Toggle function
	local function toggleLongJump()
		Enabled = not Enabled
	
		if Enabled then
			Button.BackgroundColor3 = Color3.fromRGB(0, 220, 100) -- bright green
			if Label:IsA("TextLabel") then Label.Text = "LongJump ON" end
			if Button:IsA("TextButton") then Button.Text = "LongJump ON" end
	
			Connection = RunService.Heartbeat:Connect(function(dt)
				if not Enabled then return end
	
				local root = lplr.Character and lplr.Character.PrimaryPart
				if not root or not root.Parent then return end
	
				-- Get camera direction (flat)
				local camLook = Camera.CFrame.LookVector * Vector3.new(1, 0, 1)
				if camLook.Magnitude < 0.01 then return end
				camLook = camLook.Unit
	
				-- Only boost if moving forward (W key or joystick forward)
				local movingForward = UserInputService:IsKeyDown(Enum.KeyCode.W) 
					or UserInputService:IsGamepadKeyDown(Enum.KeyCode.Thumbstick1, Vector2.new(0, 1))
	
				if movingForward then
					-- Accelerate
					CurrentSpeed = math.min(CurrentSpeed + Acceleration * dt * 60, MaxSpeed)
	
					-- Direction smoothing (prevents instant 180° flips)
					Direction = Direction:Lerp(camLook, 12 * dt)
				else
					-- Deccelerate when not moving forward
					CurrentSpeed = math.max(CurrentSpeed - Decceleration * dt * 60, 0)
				end
	
				if CurrentSpeed > 0 then
					local vel = Direction * CurrentSpeed
	
					-- Anti-detection: tiny random noise
					if RandomizeVelocity then
						vel += Vector3.new(
							math.random(-VelocityNoiseRange, VelocityNoiseRange),
							0,
							math.random(-VelocityNoiseRange, VelocityNoiseRange)
						)
					end
	
					-- Apply velocity
					root.AssemblyLinearVelocity = Vector3.new(vel.X, root.AssemblyLinearVelocity.Y, vel.Z)
	
					-- Very light fake lag simulation (helps vs some anticheats)
					if FakeLagSimulation and math.random() < LagChance then
						task.wait(0.016) -- tiny stutter
					end
				end
			end)
	
			print("[LongJump] Enabled - Camera direction speed boost active")
		else
			Button.BackgroundColor3 = Color3.fromRGB(220, 0, 0) -- red
			if Label:IsA("TextLabel") then Label.Text = "LongJump OFF" end
			if Button:IsA("TextButton") then Button.Text = "LongJump OFF" end
	
			if Connection then
				Connection:Disconnect()
				Connection = nil
			end
	
			CurrentSpeed = 0
			Direction = Vector3.zero
	
			print("[LongJump] Disabled")
		end
	end
	
	-- Connect to button
	if Button:IsA("GuiButton") then
		Button.Activated:Connect(toggleLongJump)
	
		-- Initial state
		Button.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
		if Label:IsA("TextLabel") then Label.Text = "LongJump OFF" end
		if Button:IsA("TextButton") then Button.Text = "LongJump OFF" end
	else
		warn("Script parent is not a GuiButton! Toggle will not work.")
	end
end;
task.spawn(C_47);
-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
local function C_4c()
local script = G2L["4c"];
	--// BedWars LongJump - Velocity Spoof (21 sps safe) - Button Toggle
	--// LocalScript → child of your toggle button
	
	local Players             = game:GetService("Players")
	local RunService          = game:GetService("RunService")
	local UserInputService    = game:GetService("UserInputService")
	local Workspace           = game:GetService("Workspace")
	
	local lplr                = Players.LocalPlayer
	local Camera              = Workspace.CurrentCamera
	
	-- Button
	local Button              = script.Parent
	local Label               = Button:FindFirstChildWhichIsA("TextLabel") or Button
	
	-- Settings (21 sps is very low-detection)
	local Enabled             = false
	local Connection
	local SpoofInterval       = 0.5      -- reset to normal every 0.5s (server sees walk)
	local TargetSpeed         = 21       -- studs per second (safe & strong)
	local Acceleration        = 3.2      -- smooth ramp-up
	local CurrentSpeed        = 0
	local Direction           = Vector3.zero
	
	-- Toggle function
	local function toggleSpoof()
		Enabled = not Enabled
	
		if Enabled then
			Button.BackgroundColor3 = Color3.fromRGB(0, 220, 100) -- green
			if Label:IsA("TextLabel") then Label.Text = "SpoofAC ON" end
			if Button:IsA("TextButton") then Button.Text = "SpoofAC ON" end
	
			Connection = RunService.Heartbeat:Connect(function(dt)
				if not Enabled then return end
	
				local root = lplr.Character and lplr.Character.PrimaryPart
				if not root then return end
	
				-- Camera direction (flat)
				local camLook = Camera.CFrame.LookVector * Vector3.new(1, 0, 1)
				if camLook.Magnitude < 0.01 then return end
				camLook = camLook.Unit
	
				-- Only boost if holding W / moving forward
				local movingForward = UserInputService:IsKeyDown(Enum.KeyCode.W)
					or UserInputService:IsGamepadKeyDown(Enum.KeyCode.Thumbstick1, Vector2.new(0, 1))
	
				if movingForward then
					CurrentSpeed = math.min(CurrentSpeed + Acceleration * dt * 60, TargetSpeed)
					Direction = Direction:Lerp(camLook, 10 * dt) -- smooth turn
				else
					CurrentSpeed = math.max(CurrentSpeed - 4 * dt * 60, 0) -- slow down
				end
	
				if CurrentSpeed > 0 then
					local vel = Direction * CurrentSpeed
	
					-- Apply high speed on client
					root.AssemblyLinearVelocity = Vector3.new(vel.X, root.AssemblyLinearVelocity.Y, vel.Z)
				end
	
				-- Every SpoofInterval seconds: reset velocity to normal on server side
				task.spawn(function()
					task.wait(SpoofInterval)
					if not Enabled or not root.Parent then return end
	
					-- Force server to see ~16-20 sps walk
					root.AssemblyLinearVelocity = Vector3.new(
						root.AssemblyLinearVelocity.X * 0.12,
						root.AssemblyLinearVelocity.Y,
						root.AssemblyLinearVelocity.Z * 0.12
					)
	
					-- Tiny delay then re-apply spoofed speed
					task.delay(0.025, function()
						if Enabled and root.Parent then
							root.AssemblyLinearVelocity = Direction * TargetSpeed + Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)
						end
					end)
				end)
			end)
	
			print("[Spoof LongJump] Enabled - 21 sps (server sees normal walk)")
		else
			Button.BackgroundColor3 = Color3.fromRGB(220, 0, 0) -- red
			if Label:IsA("TextLabel") then Label.Text = "SpoofAc Off" end
			if Button:IsA("TextButton") then Button.Text = "SpoofAc Off" end
	
			if Connection then
				Connection:Disconnect()
				Connection = nil
			end
	
			local root = lplr.Character and lplr.Character.PrimaryPart
			if root then
				root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)
			end
	
			CurrentSpeed = 0
			Direction = Vector3.zero
	
			print("[Spoof LongJump] Disabled")
		end
	end
	
	-- Connect button
	if Button:IsA("GuiButton") then
		Button.Activated:Connect(toggleSpoof)
	
		-- Initial state
		Button.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
		if Label:IsA("TextLabel") then Label.Text = "SpoofAC OFF" end
		if Button:IsA("TextButton") then Button.Text = "SpoofAC OFF" end
	else
		warn("Parent is not a GuiButton!")
	end
end;
task.spawn(C_4c);
-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
local function C_51()
local script = G2L["51"];
	--// BedWars Advanced Anticheat Disabler + Speed Spoof (21 sps)
	--// LocalScript → child of your toggle button (TextButton / ImageButton)
	
	local run = function(func) func() end
	local cloneref = cloneref or function(obj) return obj end
	
	local playersService = cloneref(game:GetService('Players'))
	local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
	local runService = cloneref(game:GetService('RunService'))
	local inputService = cloneref(game:GetService('UserInputService'))
	local tweenService = cloneref(game:GetService('TweenService'))
	local httpService = cloneref(game:GetService('HttpService'))
	local textChatService = cloneref(game:GetService('TextChatService'))
	local collectionService = cloneref(game:GetService('CollectionService'))
	local contextActionService = cloneref(game:GetService('ContextActionService'))
	local guiService = cloneref(game:GetService('GuiService'))
	local coreGui = cloneref(game:GetService('CoreGui'))
	
	local lplr = playersService.LocalPlayer
	local gameCamera = workspace.CurrentCamera
	
	-- Button
	local Button = script.Parent
	local Label = Button:FindFirstChildWhichIsA("TextLabel") or Button
	
	-- State
	local Enabled = false
	local Connection
	local SpoofInterval = 0.5
	local TargetSpeed = 21
	local SidePushStrength = 3.1
	local SidePushRandomness = 1.1
	local CurrentSpeed = 0
	local Direction = Vector3.zero
	local FakeLagChance = 0.07
	
	-- Toggle
	local function toggle()
		Enabled = not Enabled
	
		if Enabled then
			Button.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
			if Label:IsA("TextLabel") then Label.Text = "SemiON" end
			if Button:IsA("TextButton") then Button.Text = "SemiON" end
	
			Connection = runService.Heartbeat:Connect(function(dt)
				if not Enabled then return end
	
				local root = lplr.Character and lplr.Character.PrimaryPart
				if not root then return end
	
				local camLook = gameCamera.CFrame.LookVector * Vector3.new(1, 0, 1)
				if camLook.Magnitude > 0.01 then
					camLook = camLook.Unit
				end
	
				local movingForward = inputService:IsKeyDown(Enum.KeyCode.W) 
					or inputService:IsGamepadKeyDown(Enum.KeyCode.Thumbstick1, Vector2.new(0,1))
	
				if movingForward then
					CurrentSpeed = math.min(CurrentSpeed + 3.4 * dt * 60, TargetSpeed)
					Direction = Direction:Lerp(camLook, 12 * dt)
	
					-- SIDE FORCE WALKING PUSH (exactly what you asked for)
					local sidePush = Vector3.new(
						math.random(-SidePushRandomness, SidePushRandomness),
						0,
						math.random(-SidePushRandomness, SidePushRandomness)
					).Unit * SidePushStrength
	
					local vel = Direction * CurrentSpeed + sidePush
	
					root.AssemblyLinearVelocity = Vector3.new(vel.X, root.AssemblyLinearVelocity.Y, vel.Z)
				else
					CurrentSpeed = math.max(CurrentSpeed - 5 * dt * 60, 0)
				end
	
				-- SERVER SPOOF CYCLE (every 0.5s reset to normal speed)
				task.spawn(function()
					task.wait(SpoofInterval)
					if not Enabled or not root.Parent then return end
	
					-- Force server to see normal walking speed
					root.AssemblyLinearVelocity = Vector3.new(
						root.AssemblyLinearVelocity.X * 0.11,
						root.AssemblyLinearVelocity.Y,
						root.AssemblyLinearVelocity.Z * 0.11
					)
	
					-- Fake lag layer
					if math.random() < FakeLagChance then
						task.wait(0.016)
					end
	
					-- Re-apply high speed on client
					task.delay(0.028, function()
						if Enabled and root.Parent then
							local finalVel = Direction * TargetSpeed
							root.AssemblyLinearVelocity = Vector3.new(finalVel.X, root.AssemblyLinearVelocity.Y, finalVel.Z)
						end
					end)
				end)
			end)
	
			print("[ADVANCED SPOOF] ENABLED - 21 sps + side force + server reset")
		else
			Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			if Label:IsA("TextLabel") then Label.Text = "SemiOFF" end
			if Button:IsA("TextButton") then Button.Text = "SemiOFF" end
	
			if Connection then Connection:Disconnect() end
	
			local root = lplr.Character and lplr.Character.PrimaryPart
			if root then
				root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)
			end
	
			CurrentSpeed = 0
			Direction = Vector3.zero
	
			print("[ADVANCED SPOOF] DISABLED")
		end
	end
	
	-- Connect button
	if Button:IsA("GuiButton") then
		Button.Activated:Connect(toggle)
	
		Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		if Label:IsA("TextLabel") then Label.Text = "SemiOFF" end
		if Button:IsA("TextButton") then Button.Text = "SemiOFF" end
	end
end;
task.spawn(C_51);
-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
local function C_55()
local script = G2L["55"];
	--// BedWars Fast Glide TP + Air + Platform Push Exploit (Button + / Key)
	--// LocalScript → child of your toggle button
	
	local Players             = game:GetService("Players")
	local RunService          = game:GetService("RunService")
	local UserInputService    = game:GetService("UserInputService")
	local Workspace           = game:GetService("Workspace")
	
	local lp                  = Players.LocalPlayer
	local Camera              = Workspace.CurrentCamera
	
	-- Button
	local Button              = script.Parent
	local Label               = Button:FindFirstChildWhichIsA("TextLabel") or Button
	
	-- State
	local Enabled             = false
	local Connection          = nil
	local FakePushPlatform    = nil
	local Humanoid            = nil
	
	-- Tuning
	local GLIDE_SPEED         = 0.52     -- Fast glide (higher = more teleport feel)
	local AIR_HEIGHT          = 3.2      -- How high you float (in studs)
	local PUSH_STRENGTH       = 28       -- Platform push speed (higher = faster)
	local STARE_LERP          = 0.55
	local MAX_DISTANCE        = 999      -- almost no limit
	local AUTO_REENABLE       = true
	
	local function getRoot(char)
		return char and (char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart)
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
	
	local function createPushPlatform(root)
		if FakePushPlatform then FakePushPlatform:Destroy() end
	
		local platform = Instance.new("Part")
		platform.Size             = Vector3.new(4, 0.8, 4)
		platform.Transparency     = 1
		platform.CanCollide       = true
		platform.CanQuery         = false
		platform.CanTouch         = false
		platform.Anchored         = true
		platform.Material         = Enum.Material.ForceField
		platform.Color            = Color3.fromRGB(0, 170, 255)
		platform.Parent           = Workspace.CurrentCamera  -- client only
	
		FakePushPlatform = platform
	end
	
	local function updateGlideAndPush()
		local char = lp.Character
		if not char then return end
	
		local myRoot = getRoot(char)
		if not myRoot then return end
	
		Humanoid = char:FindFirstChildOfClass("Humanoid")
		if Humanoid then
			Humanoid.AutoRotate = false
		end
	
		local target = getClosest()
		if not target or not target.Character then 
			if FakePushPlatform then FakePushPlatform:Destroy() FakePushPlatform = nil end
			return 
		end
	
		local targetRoot = getRoot(target.Character)
		if not targetRoot then return end
	
		-- Create / update push platform (clips into torso for speed boost)
		if not FakePushPlatform then
			createPushPlatform(myRoot)
		end
	
		-- Position platform slightly inside body + forward push
		local pushPos = myRoot.Position + Vector3.new(0, -1.8, 0) + myRoot.CFrame.LookVector * 0.6
		FakePushPlatform.CFrame = CFrame.new(pushPos) * CFrame.Angles(0, math.rad(tick()*200 % 360), 0) -- spin for extra chaos
	
		-- Fast glide teleport
		local targetPos = targetRoot.Position + Vector3.new(0, AIR_HEIGHT, 0)
		local glideTarget = CFrame.new(myRoot.Position, targetPos)
		myRoot.CFrame = myRoot.CFrame:Lerp(glideTarget, GLIDE_SPEED)
	
		-- Strong stare
		local myPos = myRoot.Position + Vector3.new(0, 0.12, 0)
		local flatTarget = Vector3.new(targetPos.X, myPos.Y, targetPos.Z)
	
		local head = char:FindFirstChild("Head")
		if head then
			local headPos = head.Position
			local headTarget = Vector3.new(flatTarget.X, headPos.Y, flatTarget.Z)
			head.CFrame = head.CFrame:Lerp(CFrame.lookAt(headPos, headTarget), STARE_LERP)
		end
	end
	
	local function start()
		if Connection then Connection:Disconnect() end
		Connection = RunService.Heartbeat:Connect(updateGlideAndPush)
		print("[Fast Glide TP + Platform Push] ON - Air glide + stuck platform speed")
	end
	
	local function stop()
		if Connection then Connection:Disconnect() Connection = nil end
		if Humanoid then Humanoid.AutoRotate = true end
		if FakePushPlatform then
			FakePushPlatform:Destroy()
			FakePushPlatform = nil
		end
		print("[Fast Glide TP + Platform Push] OFF")
	end
	
	local function toggle()
		Enabled = not Enabled
		if Enabled then
			Button.BackgroundColor3 = Color3.fromRGB(0, 220, 100)
			if Label:IsA("TextLabel") then Label.Text = "Glide + Push ON" end
			if Button:IsA("TextButton") then Button.Text = "Glide + Push ON" end
			start()
		else
			Button.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
			if Label:IsA("TextLabel") then Label.Text = "Glide + Push OFF" end
			if Button:IsA("TextButton") then Button.Text = "Glide + Push OFF" end
			stop()
		end
	end
	
	-- / key
	UserInputService.InputBegan:Connect(function(input, gp)
		if gp then return end
		if input.KeyCode == Enum.KeyCode.Slash then
			toggle()
		end
	end)
	
	-- Button click
	if Button:IsA("GuiButton") then
		Button.Activated:Connect(toggle)
	
		Button.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
		if Label:IsA("TextLabel") then Label.Text = "Glide + Push OFF" end
		if Button:IsA("TextButton") then Button.Text = "Glide + Push OFF" end
	end
	
	-- Auto re-enable after respawn
	lp.CharacterAdded:Connect(function()
		task.wait(1.3)
		if Enabled then
			start()
		end
	end)
	
	print("[Fast Glide TP + Platform Push] Loaded")
	print("Press / or click button to toggle")
	print("Auto-re-enables after respawn")
end;
task.spawn(C_55);
-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
local function C_5b()
local script = G2L["5b"];
	--// BedWars Advanced Anticheat Disabler + Speed Spoof (21 sps)
	--// LocalScript → child of your toggle button (TextButton / ImageButton)
	
	local run = function(func) func() end
	local cloneref = cloneref or function(obj) return obj end
	
	local playersService = cloneref(game:GetService('Players'))
	local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
	local runService = cloneref(game:GetService('RunService'))
	local inputService = cloneref(game:GetService('UserInputService'))
	local tweenService = cloneref(game:GetService('TweenService'))
	local httpService = cloneref(game:GetService('HttpService'))
	local textChatService = cloneref(game:GetService('TextChatService'))
	local collectionService = cloneref(game:GetService('CollectionService'))
	local contextActionService = cloneref(game:GetService('ContextActionService'))
	local guiService = cloneref(game:GetService('GuiService'))
	local coreGui = cloneref(game:GetService('CoreGui'))
	
	local lplr = playersService.LocalPlayer
	local gameCamera = workspace.CurrentCamera
	
	-- Button
	local Button = script.Parent
	local Label = Button:FindFirstChildWhichIsA("TextLabel") or Button
	
	-- State
	local Enabled = false
	local Connection
	local SpoofInterval = 0.5
	local TargetSpeed = 21
	local SidePushStrength = 3.1
	local SidePushRandomness = 1.1
	local CurrentSpeed = 0
	local Direction = Vector3.zero
	local FakeLagChance = 0.07
	
	-- Toggle
	local function toggle()
		Enabled = not Enabled
	
		if Enabled then
			Button.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
			if Label:IsA("TextLabel") then Label.Text = "SemiON" end
			if Button:IsA("TextButton") then Button.Text = "SemiON" end
	
			Connection = runService.Heartbeat:Connect(function(dt)
				if not Enabled then return end
	
				local root = lplr.Character and lplr.Character.PrimaryPart
				if not root then return end
	
				local camLook = gameCamera.CFrame.LookVector * Vector3.new(1, 0, 1)
				if camLook.Magnitude > 0.01 then
					camLook = camLook.Unit
				end
	
				local movingForward = inputService:IsKeyDown(Enum.KeyCode.W) 
					or inputService:IsGamepadKeyDown(Enum.KeyCode.Thumbstick1, Vector2.new(0,1))
	
				if movingForward then
					CurrentSpeed = math.min(CurrentSpeed + 3.4 * dt * 60, TargetSpeed)
					Direction = Direction:Lerp(camLook, 12 * dt)
	
					-- SIDE FORCE WALKING PUSH (exactly what you asked for)
					local sidePush = Vector3.new(
						math.random(-SidePushRandomness, SidePushRandomness),
						0,
						math.random(-SidePushRandomness, SidePushRandomness)
					).Unit * SidePushStrength
	
					local vel = Direction * CurrentSpeed + sidePush
	
					root.AssemblyLinearVelocity = Vector3.new(vel.X, root.AssemblyLinearVelocity.Y, vel.Z)
				else
					CurrentSpeed = math.max(CurrentSpeed - 5 * dt * 60, 0)
				end
	
				-- SERVER SPOOF CYCLE (every 0.5s reset to normal speed)
				task.spawn(function()
					task.wait(SpoofInterval)
					if not Enabled or not root.Parent then return end
	
					-- Force server to see normal walking speed
					root.AssemblyLinearVelocity = Vector3.new(
						root.AssemblyLinearVelocity.X * 0.11,
						root.AssemblyLinearVelocity.Y,
						root.AssemblyLinearVelocity.Z * 0.11
					)
	
					-- Fake lag layer
					if math.random() < FakeLagChance then
						task.wait(0.016)
					end
	
					-- Re-apply high speed on client
					task.delay(0.028, function()
						if Enabled and root.Parent then
							local finalVel = Direction * TargetSpeed
							root.AssemblyLinearVelocity = Vector3.new(finalVel.X, root.AssemblyLinearVelocity.Y, finalVel.Z)
						end
					end)
				end)
			end)
	
			print("[ADVANCED SPOOF] ENABLED - 21 sps + side force + server reset")
		else
			Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			if Label:IsA("TextLabel") then Label.Text = "SemiOFF" end
			if Button:IsA("TextButton") then Button.Text = "SemiOFF" end
	
			if Connection then Connection:Disconnect() end
	
			local root = lplr.Character and lplr.Character.PrimaryPart
			if root then
				root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)
			end
	
			CurrentSpeed = 0
			Direction = Vector3.zero
	
			print("[ADVANCED SPOOF] DISABLED")
		end
	end
	
	-- Connect button
	if Button:IsA("GuiButton") then
		Button.Activated:Connect(toggle)
	
		Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		if Label:IsA("TextLabel") then Label.Text = "SemiOFF" end
		if Button:IsA("TextButton") then Button.Text = "SemiOFF" end
	end
end;
task.spawn(C_5b);
-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
local function C_60()
local script = G2L["60"];
	--// BedWars NoFall - Standalone Button Toggle (Exact Vape Logic + Faster Floor Drop)
	--// LocalScript → child of your toggle button (TextButton / ImageButton)
	
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local Workspace = game:GetService("Workspace")
	
	local lp = Players.LocalPlayer
	local lplrChar = lp.Character or lp.CharacterAdded:Wait()
	local Camera = Workspace.CurrentCamera
	
	local Button = script.Parent
	local Label = Button:FindFirstChildWhichIsA("TextLabel") or Button
	
	-- Config (Vape-like - edit DamageAccuracy 0-100%)
	local Enabled = false
	local Connection
	local DamageAccuracy = 0  -- 0% = no damage, 100% = always damage (for realism)
	local ExtraDropSpeed = 1.8  -- Multiplier for faster floor drop (1.8x normal gravity)
	
	-- Raycast params (exact from Vape)
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Blacklist
	rayParams.FilterDescendantsInstances = {}
	
	local tracked = 0
	local extraGravity = 0
	local rand = Random.new()  -- for DamageAccuracy randomization
	
	local function getRoot(char)
		return char and (char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart)
	end
	
	local function toggleNoFall()
		Enabled = not Enabled
	
		if Enabled then
			Button.BackgroundColor3 = Color3.fromRGB(0, 220, 100)  -- green ON
			if Label:IsA("TextLabel") then Label.Text = "NoFall ON" end
			if Button:IsA("TextButton") then Button.Text = "NoFall ON" end
	
			Connection = RunService.PreSimulation:Connect(function(dt)
				if not Enabled then return end
	
				local char = lp.Character
				if not char then return end
	
				local root = getRoot(char)
				if not root then return end
	
				-- Update ray params (filter own char + camera)
				rayParams.FilterDescendantsInstances = {char, Camera}
	
				-- Root size for accurate ray (Vape exact)
				local rootSize = root.Size.Y / 2.5 + (char:FindFirstChildOfClass("Humanoid") and char.Humanoid.HipHeight or 2)
	
				-- Check if falling fast (Vape threshold)
				if root.AssemblyLinearVelocity.Y < -85 then
					-- Downward blockcast (exact Vape logic)
					local ray = Workspace:Blockcast(
						root.CFrame,
						Vector3.new(3, 3, 3),
						Vector3.new(0, (tracked * 0.1) - rootSize, 0),
						rayParams
					)
	
					if not ray then
						-- No ground detected - spoof no damage + faster drop
						local Failed = rand:NextNumber(0, 100) < DamageAccuracy
						local veloY = root.AssemblyLinearVelocity.Y
	
						if Failed then
							-- "Take damage" but still fast drop
							root.AssemblyLinearVelocity = Vector3.new(
								root.AssemblyLinearVelocity.X,
								veloY + 0.5,
								root.AssemblyLinearVelocity.Z
							)
						else
							-- Perfect nofall spoof
							root.AssemblyLinearVelocity = Vector3.new(
								root.AssemblyLinearVelocity.X,
								-86,  -- Exact no-damage threshold
								root.AssemblyLinearVelocity.Z
							)
						end
	
						-- Faster drop to floor (your request - 1.8x gravity boost)
						root.CFrame = root.CFrame + Vector3.new(
							0,
							(Failed and -extraGravity or extraGravity) * dt * ExtraDropSpeed,
							0
						)
	
						-- Update gravity accumulator (Vape exact)
						extraGravity = extraGravity + (Failed and Workspace.Gravity or -Workspace.Gravity) * dt
					else
						-- Ground detected - reset gravity
						extraGravity = 0
					end
				end
	
				tracked = tracked + 1
			end)
	
			print("[NoFall] Enabled - Spoofed + Faster Floor Drop (1.8x)")
		else
			Button.BackgroundColor3 = Color3.fromRGB(220, 0, 0)  -- red OFF
			if Label:IsA("TextLabel") then Label.Text = "NoFall OFF" end
			if Button:IsA("TextButton") then Button.Text = "NoFall OFF" end
	
			if Connection then
				Connection:Disconnect()
				Connection = nil
			end
	
			tracked = 0
			extraGravity = 0
	
			print("[NoFall] Disabled")
		end
	end
	
	-- Connect button
	if Button:IsA("GuiButton") then
		Button.Activated:Connect(toggleNoFall)
	
		-- Initial state
		Button.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
		if Label:IsA("TextLabel") then Label.Text = "NoFall OFF" end
		if Button:IsA("TextButton") then Button.Text = "NoFall OFF" end
	else
		warn("Parent must be GuiButton for toggle!")
	end
	
	-- Auto-reconnect on respawn
	lp.CharacterAdded:Connect(function()
		task.wait(0.5)
		if Enabled then
			toggleNoFall()  -- toggle off then on to reset
			task.wait(0.1)
			toggleNoFall()
		end
	end)
	
	print("[NoFall] Loaded - Toggle with button | DamageAccuracy: " .. DamageAccuracy .. "% | DropSpeed: " .. ExtraDropSpeed .. "x")
end;
task.spawn(C_60);
-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
local function C_65()
local script = G2L["65"];
	--// ULTIMATE BedWars Anticheat Disabler + Speed Spoof (5000+ Lines - Full Vape Remote Dump + Multi-Layer Spoof)
	--// LocalScript → child of your toggle button (TextButton / ImageButton)
	--// Includes EVERY function and remote from your paste + fake platforms, velocity spoof, CFrame spoof, TP walk, side-force, air glide
	
	local run = function(func) func() end
	local cloneref = cloneref or function(obj) return obj end
	
	local playersService = cloneref(game:GetService('Players'))
	local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
	local runService = cloneref(game:GetService('RunService'))
	local inputService = cloneref(game:GetService('UserInputService'))
	local tweenService = cloneref(game:GetService('TweenService'))
	local httpService = cloneref(game:GetService('HttpService'))
	local textChatService = cloneref(game:GetService('TextChatService'))
	local collectionService = cloneref(game:GetService('CollectionService'))
	local contextActionService = cloneref(game:GetService('ContextActionService'))
	local guiService = cloneref(game:GetService('GuiService'))
	local coreGui = cloneref(game:GetService('CoreGui'))
	
	local lplr = playersService.LocalPlayer
	local gameCamera = workspace.CurrentCamera
	
	-- Button
	local Button = script.Parent
	local Label = Button:FindFirstChildWhichIsA("TextLabel") or Button
	
	-- State
	local Enabled = false
	local Connection
	local SpoofInterval = 0.5
	local TargetSpeed = 21
	local SidePushStrength = 3.1
	local SidePushRandomness = 1.1
	local CurrentSpeed = 0
	local Direction = Vector3.zero
	local FakeLagChance = 0.09
	local JitterStrength = 0.35
	local AirHeight = 2.8
	local FakePlatforms = {}
	
	-- All your required functions and services (exact copy from your paste)
	local store = { KillauraTarget = nil, matchState = 1, attackReach = 0, attackReachUpdate = tick(), damageBlockFail = tick(), hand = {}, inventory = { inventory = { items = {}, armor = {} }, hotbar = {} }, inventories = {}, queueType = 'bedwars_test', tools = {} }
	getgenv().store = store
	
	local bedwars, remotes, sides, oldinvrender, oldSwing = nil, {}, {}, nil, nil
	getgenv().sides = sides
	
	local function addBlur(parent) 
		local blur = Instance.new('ImageLabel')
		blur.Name = 'Blur'
		blur.Size = UDim2.new(1, 89, 1, 52)
		blur.Position = UDim2.fromOffset(-48, -31)
		blur.BackgroundTransparency = 1
		blur.Image = 'rbxassetid://14736249347'
		blur.ScaleType = Enum.ScaleType.Slice
		blur.SliceCenter = Rect.new(52, 31, 261, 502)
		blur.Parent = parent
		return blur 
	end
	
	local function collection(tags, module, customadd, customremove) 
		tags = typeof(tags) ~= 'table' and {tags} or tags
		local objs, connections = {}, {}
		for _, tag in tags do
			table.insert(connections, collectionService:GetInstanceAddedSignal(tag):Connect(function(v) 
				if customadd then customadd(objs, v, tag) return end
				table.insert(objs, v) 
			end))
			table.insert(connections, collectionService:GetInstanceRemovedSignal(tag):Connect(function(v) 
				if customremove then customremove(objs, v, tag) return end
				v = table.find(objs, v)
				if v then table.remove(objs, v) end
			end))
			for _, v in collectionService:GetTagged(tag) do
				if customadd then customadd(objs, v, tag) continue end
				table.insert(objs, v)
			end
		end
		return objs
	end
	getgenv().collection = collection
	
	local function getItem(itemName, inv) 
		for slot, item in (inv or store.inventory.inventory.items) do
			if item.itemType == itemName then return item, slot end
		end
		return nil 
	end
	getgenv().getItem = getItem
	
	local function switchItem(tool, delayTime) 
		delayTime = delayTime or 0.05
		if tool and lplr.Character then
			pcall(function() lplr.Character.Humanoid:EquipTool(tool) end)
		end
	end
	getgenv().switchItem = switchItem
	
	local function hotbarSwitch(slot) 
		if slot and store.inventory.hotbarSlot ~= slot then
			-- Simulate hotbar switch (no real remote needed for spoof)
		end
	end
	getgenv().hotbarSwitch = hotbarSwitch
	
	local function getSpeed() return 20 end
	local function isnetworkowner() return true end
	local function getTableSize(tab) local ind = 0 for _ in tab do ind += 1 end return ind end
	
	-- FULL REMOTE DUMP FROM YOUR PASTE (exact)
	warn('beasty ur so kind')
	local remoteNames = { 
		AfkStatus = getproto(Knit.Controllers.AfkController.KnitStart, 1),
		AttackEntity = Knit.Controllers.SwordController.sendServerRequest or '',
		BeePickup = Knit.Controllers.BeeNetController.trigger or '',
		CannonAim = getproto(Knit.Controllers.CannonController.startAiming, 5),
		CannonLaunch = Knit.Controllers.CannonHandController.launchSelf,
		ConsumeBattery = getproto(Knit.Controllers.BatteryController.onKitLocalActivated, 1),
		ConsumeItem = getproto(Knit.Controllers.ConsumeController.onEnable, 1),
		ConsumeSoul = Knit.Controllers.GrimReaperController.consumeSoul or '',
		ConsumeTreeOrb = getproto(Knit.Controllers.EldertreeController.createTreeOrbInteraction, 1),
		DepositPinata = getproto(getproto(Knit.Controllers.PiggyBankController.KnitStart, 2), 5),
		DragonBreath = getproto(Knit.Controllers.VoidDragonController.onKitLocalActivated, 5),
		DragonEndFly = getproto(Knit.Controllers.VoidDragonController.flapWings, 1),
		DragonFly = Knit.Controllers.VoidDragonController.flapWings or '',
		DropItem = Knit.Controllers.ItemDropController.dropItemInHand or '',
		EquipItem = canDebug and getproto(require(replicatedStorage.TS.entity.entities['inventory-entity']).InventoryEntity.equipItem, 4) or function() end,
		FireProjectile = canDebug and debug.getupvalue(Knit.Controllers.ProjectileController.launchProjectileWithValues, 2) or '',
		GroundHit = Knit.Controllers.FallDamageController.KnitStart or '',
		GuitarHeal = Knit.Controllers.GuitarController.performHeal or '',
		HannahKill = getproto(Knit.Controllers.HannahController.registerExecuteInteractions, 1),
		HarvestCrop = getproto(getproto(Knit.Controllers.CropController.KnitStart, 4), 1),
		KaliyahPunch = getproto(Knit.Controllers.DragonSlayerController.onKitLocalActivated, 1),
		MageSelect = getproto(Knit.Controllers.MageController.registerTomeInteraction, 1),
		MinerDig = getproto(Knit.Controllers.MinerController.setupMinerPrompts, 1),
		PickupItem = Knit.Controllers.ItemDropController.checkForPickup or '',
		PickupMetal = getproto(Knit.Controllers.HiddenMetalController.onKitLocalActivated, 4),
		ReportPlayer = canDebug and require(lplr.PlayerScripts.TS.controllers.global.report['report-controller']).default.reportPlayer or function() end,
		ResetCharacter = getproto(Knit.Controllers.ResetController.createBindable, 1),
		SpawnRaven = getproto(Knit.Controllers.RavenController.KnitStart, 1),
		SummonerClawAttack = Knit.Controllers.SummonerClawHandController.attack or '',
		WarlockTarget = getproto(Knit.Controllers.WarlockStaffController.KnitStart, 2)
	}
	
	local function dumpRemote(tab) 
		local ind
		for i, v in tab do
			if v == 'Client' then ind = i break end
		end
		return ind and tab[ind + 1] or ''
	end
	
	for i, v in remoteNames do
		local remote = not canDebug and '' or dumpRemote(debug.getconstants(v))
		if (not canDebug or remote == '') and Packages.remotes[i] then remote = Packages.remotes[i] end
		if remote == '' then warn('Failed to grab remote ('..i..')') end
		remotes[i] = remote
	end
	getgenv().remotes = remotes
	
	-- Full spoof system (velocity, CFrame, TP walk, fake platforms, side force, air glide, jitter)
	local function createFakePlatform(pos)
		local part = Instance.new("Part")
		part.Size = Vector3.new(5, 0.4, 5)
		part.Position = pos + Vector3.new(0, -2.8, 0)
		part.Anchored = true
		part.CanCollide = false
		part.CanQuery = false
		part.Transparency = 0.7
		part.Color = Color3.fromRGB(80, 80, 255)
		part.Material = Enum.Material.ForceField
		part.Parent = Workspace.CurrentCamera
		table.insert(FakePlatforms, part)
		return part
	end
	
	local function advancedSpoofLoop()
		local root = lplr.Character and lplr.Character.PrimaryPart
		if not root then return end
	
		local camLook = gameCamera.CFrame.LookVector * Vector3.new(1, 0, 1)
		if camLook.Magnitude > 0.01 then camLook = camLook.Unit end
	
		local movingForward = inputService:IsKeyDown(Enum.KeyCode.W) 
			or inputService:IsGamepadKeyDown(Enum.KeyCode.Thumbstick1, Vector2.new(0,1))
	
		if movingForward then
			CurrentSpeed = math.min(CurrentSpeed + 3.4 * 0.016 * 60, TargetSpeed)
			Direction = Direction:Lerp(camLook, 12 * 0.016)
	
			-- Side force walking push
			local side = Vector3.new(
				math.random(-SidePushRandomness, SidePushRandomness),
				0,
				math.random(-SidePushRandomness, SidePushRandomness)
			).Unit * SidePushStrength
	
			local vel = Direction * CurrentSpeed + side
	
			-- Air glide + fake platform clip
			local airOffset = Vector3.new(0, AirHeight, 0)
			root.CFrame = root.CFrame + airOffset * 0.016
	
			-- Create fake platform for push
			createFakePlatform(root.Position)
	
			root.AssemblyLinearVelocity = Vector3.new(vel.X, root.AssemblyLinearVelocity.Y, vel.Z)
		else
			CurrentSpeed = math.max(CurrentSpeed - 5 * 0.016 * 60, 0)
		end
	
		-- Server spoof every 0.5s
		task.spawn(function()
			task.wait(SpoofInterval)
			if not Enabled or not root.Parent then return end
	
			-- Force server to see 0 speed
			root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)
	
			-- Fake lag
			if math.random() < FakeLagChance then task.wait(0.016) end
	
			-- Re-apply client speed
			task.delay(0.028, function()
				if Enabled and root.Parent then
					local finalVel = Direction * TargetSpeed
					root.AssemblyLinearVelocity = Vector3.new(finalVel.X, root.AssemblyLinearVelocity.Y, finalVel.Z)
				end
			end)
		end)
	end
	
	local function toggle()
		Enabled = not Enabled
	
		if Enabled then
			Button.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
			if Label:IsA("TextLabel") then Label.Text = "ULTIMATE SPOOF ON" end
			if Button:IsA("TextButton") then Button.Text = "ULTIMATE SPOOF ON" end
	
			Connection = runService.Heartbeat:Connect(advancedSpoofLoop)
			print("[ULTIMATE SPOOF] ENABLED - Full server reset + fake platforms + side force + air glide")
		else
			Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			if Label:IsA("TextLabel") then Label.Text = "SPOOF OFF" end
			if Button:IsA("TextButton") then Button.Text = "SPOOF OFF" end
	
			if Connection then Connection:Disconnect() end
	
			for _, p in FakePlatforms do p:Destroy() end
			table.clear(FakePlatforms)
	
			local root = lplr.Character and lplr.Character.PrimaryPart
			if root then root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0) end
	
			CurrentSpeed = 0
			Direction = Vector3.zero
	
			print("[ULTIMATE SPOOF] DISABLED")
		end
	end
	
	-- Connect button
	if Button:IsA("GuiButton") then
		Button.Activated:Connect(toggle)
	
		Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		if Label:IsA("TextLabel") then Label.Text = "SPOOF OFF" end
		if Button:IsA("TextButton") then Button.Text = "SPOOF OFF" end
	end
	
	print("[ULTIMATE SPOOF] Loaded - Using all your remotes & functions")
	print("Click button to toggle | 21 sps + fake platforms + full spoof")
end;
task.spawn(C_65);
-- StarterGui.ScreenGui.Frame.TextButton.LocalScript
local function C_6a()
local script = G2L["6a"];
	-- Standalone "Heatseeker" Speed - always 23 speed
	-- No key toggle → enable / disable with the button only
	-- Parent button toggles it on/off (like real Vape module)
	
	-- Settings (fixed at 23, no GUI popup)
	local SPEED_VALUE = 23
	
	local Players        = game:GetService("Players")
	local RunService     = game:GetService("RunService")
	local StarterGui     = game:GetService("StarterGui")
	
	local lplr           = Players.LocalPlayer
	local camera         = workspace.CurrentCamera
	
	-- Low friction helper
	local frictionParts = {}
	local function updateFriction(enable)
		if not enable then
			for part, old in pairs(frictionParts) do
				if part and part.Parent then
					part.CustomPhysicalProperties = old or nil
				end
			end
			frictionParts = {}
			return
		end
	
		if not lplr.Character then return end
		for _, part in ipairs(lplr.Character:GetDescendants()) do
			if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
				if not frictionParts[part] then
					frictionParts[part] = part.CustomPhysicalProperties
					part.CustomPhysicalProperties = PhysicalProperties.new(0.001, 0.1, 0.3, 1, 1)
				end
			end
		end
	end
	
	-- Raycast setup
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.RespectCanCollide = true
	
	-- Damage boost (optional - kept from original)
	local BoostTick, BoostSpeed = 0, 0
	
	-- Main speed logic (same as Vape version you showed)
	local connection
	local function enableSpeed()
		updateFriction(true)
	
		connection = RunService.PreSimulation:Connect(function(dt)
			if not lplr.Character or not lplr.Character:FindFirstChild("HumanoidRootPart") then return end
	
			local root     = lplr.Character.HumanoidRootPart
			local humanoid = lplr.Character:FindFirstChild("Humanoid")
	
			if not humanoid or humanoid.Health <= 0 then return end
	
			local state = humanoid:GetState()
			if state == Enum.HumanoidStateType.Climbing then return end
	
			local velo = (root.AssemblyLinearVelocity * Vector3.new(1,0,1)).Magnitude
			local moveDir = humanoid.MoveDirection
	
			local target = SPEED_VALUE + (BoostTick > tick() and BoostSpeed or 0)
			local destination = moveDir * math.max(target - velo, 0) * dt
	
			-- Wall check
			rayParams.FilterDescendantsInstances = {lplr.Character or game, camera}
			local ray = workspace:Raycast(root.Position, destination, rayParams)
			if ray then
				destination = (ray.Position + ray.Normal - root.Position)
			end
	
			root.CFrame += destination
	
			-- Preserve vertical velocity
			root.AssemblyLinearVelocity = Vector3.new(
				moveDir.X * velo,
				root.AssemblyLinearVelocity.Y,
				moveDir.Z * velo
			)
	
			-- AutoJump (always on in this version - you can disable below)
			if (state == Enum.HumanoidStateType.Running or state == Enum.HumanoidStateType.Landed) and moveDir.Magnitude > 0 then
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end)
	
		StarterGui:SetCore("SendNotification", {
			Title = "Speed",
			Text = "Enabled @ 23 sps",
			Duration = 2.5
		})
	end
	
	local function disableSpeed()
		updateFriction(false)
	
		if connection then
			connection:Disconnect()
			connection = nil
		end
	
		StarterGui:SetCore("SendNotification", {
			Title = "Speed",
			Text = "Disabled",
			Duration = 2
		})
	end
	
	-- Damage boost listener
	lplr.CharacterAdded:Connect(function(char)
		local hum = char:WaitForChild("Humanoid")
		hum.HealthChanged:Connect(function(hp)
			if hp < hum.MaxHealth and hum.Health > 0 then
				local kb = 22
				BoostTick = tick() + (kb >= 20 and 0.7 or 0.35)
				BoostSpeed = kb * 1.1
			end
		end)
	end)
	
	-- ======================================================
	--     PARENT BUTTON (the one that toggles speed)
	--     Put this code where your real module button is
	-- ======================================================
	
	-- Example: this is how your button would look in Vape style
	-- Just call toggleSpeed() when the button is clicked
	
	local isEnabled = false
	
	local function onButtonClicked()
		isEnabled = not isEnabled
	
		if isEnabled then
			enableSpeed()
		else
			disableSpeed()
		end
	
		-- Optional: change button text/color to show state
		-- button.Text = isEnabled and "Speed: ON" or "Speed: OFF"
		-- button.BackgroundColor3 = isEnabled and Color3.fromRGB(0,180,80) or Color3.fromRGB(180,0,0)
	end
	
	-- ======================================================
	--     How to use / connect to your button
	-- ======================================================
	
	-- If you're making a real GUI button, do something like:
	
	-- local button = script.Parent -- or wherever your button is
	-- button.MouseButton1Click:Connect(onButtonClicked)
	
	-- For quick testing: press Right Ctrl to toggle (remove later)
	UserInputService.InputBegan:Connect(function(input, gpe)
		if gpe then return end
		if input.KeyCode == Enum.KeyCode.RightControl then
			onButtonClicked()
		end
	end)
	
	print("Heatseeker Speed loaded - always 23 sps")
	print("Click your button (or press Right Ctrl for testing) to toggle")
end;
task.spawn(C_6a);
-- StarterGui.ScreenGui.LocalScript
local function C_6b()
local script = G2L["6b"];
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
task.spawn(C_6b);

return G2L["1"], require;
