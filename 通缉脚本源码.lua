local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

local ClientPlayers
local ClientData

pcall(function()
    local Devv = ReplicatedStorage:WaitForChild("Devv")
    local DevvModule = require(Devv)
    ClientPlayers = DevvModule.load("ClientPlayers")
    ClientData = DevvModule.load("ClientData")
end)

local TeleportPositions = {
    BankVault = Vector3.new(-388.7, 617.2, -1153),
    PawnShop = Vector3.new(-2878, 36.7, 1633),
    MilitaryBase = Vector3.new(-1371.06, 178.681, 3236.76),
    PoliceStation = Vector3.new(1637.2, 123.6, -586.2),
    Ammunation = Vector3.new(-193, 42.9, -2812.6),
    SyndicateBase = Vector3.new(-7931, 21.5, 1061.3)
}

local ATMPositions = {
    Vector3.new(-1641.8, 39.8, -3319.6),
    Vector3.new(-1657.7, 39.7, -3259.5),
    Vector3.new(-1634.8, 39.7, -3255.5),
    Vector3.new(-1600, 39.7, -3337.7),
    Vector3.new(-683.4, 39.7, -2956.8),
    Vector3.new(-758.1, 42.2, -2677.8),
    Vector3.new(-655.2, 42.2, -2744.5),
    Vector3.new(-679, 42.2, -2678.4),
    Vector3.new(-228, 42.6, -2787.9),
    Vector3.new(-143.5, 42.6, -2837),
    Vector3.new(187.9, 39.8, -2899.7),
    Vector3.new(172.3, 39.7, -2834),
    Vector3.new(205.1, 39.7, -2848.4),
    Vector3.new(297.6, 39.6, -2933.4),
    Vector3.new(-448, 39.8, -1983.2),
    Vector3.new(-30.3, 39.8, -2058.6),
    Vector3.new(-22.8, 39.7, -2130),
    Vector3.new(-1166.5, 39.7, -1960.7),
    Vector3.new(-1126.2, 39.8, -1990.2),
    Vector3.new(-912.7, 42.5, -1515.6),
    Vector3.new(-911.3, 42.5, -1509.9),
    Vector3.new(-972.7, 41.3, -1214.5),
    Vector3.new(-965, 41.3, -1213),
    Vector3.new(-426.8, 43.7, -1254.2),
    Vector3.new(-431.9, 43.7, -1237.5),
    Vector3.new(-377.8, 43.7, -1264.3),
    Vector3.new(-364, 43.7, -1254.7),
    Vector3.new(49.4, 42.2, -1097.6),
    Vector3.new(33.6, 39.8, -901.6),
    Vector3.new(74.7, 35.8, -698.4),
    Vector3.new(-423.1, 42.7, -747.5),
    Vector3.new(-588.5, 35.8, -438)
}

local CabinetPositions = {
    Vector3.new(-434.4, 44.1, -1075.5),
    Vector3.new(-455.5, 44.1, -1090.1),
    Vector3.new(-459.5, 44.1, -1134.8),
    Vector3.new(-462.9, 44.1, -1134.1),
    Vector3.new(-377.5, 42.9, -763.5),
    Vector3.new(-404.2, 42.9, -749.3),
    Vector3.new(-614, 29, -659.4),
    Vector3.new(-934.9, 41.6, -1212.1),
    Vector3.new(-899.5, 42.8, -1615.9),
    Vector3.new(-634.8, 40, -1482.8),
    Vector3.new(-441.3, 55.7, -1591.4),
    Vector3.new(-457.8, 55.7, -1619.4),
    Vector3.new(-453.4, 55.7, -1620.5),
    Vector3.new(-461.7, 72.9, -1617.6),
    Vector3.new(-453.1, 72.9, -1638.2),
    Vector3.new(-454.6, 72.9, -1641.4),
    Vector3.new(229.8, 40, -2901.4),
    Vector3.new(233.9, 40, -2895.9),
    Vector3.new(-7858.5, 21.6, 1169.4),
    Vector3.new(-7902.6, 21.6, 1140.9),
    Vector3.new(-7859, 22.2, 1047.9),
    Vector3.new(-7786.8, 21.6, 1107.6),
    Vector3.new(-7780.2, 21.6, 1091.4),
    Vector3.new(-7972, 93.3, 983.7),
    Vector3.new(-7920.7, 93.3, 1012.9),
    Vector3.new(-7898.1, 93.3, 1028.2),
    Vector3.new(-8008.6, 93.3, 1024.9),
    Vector3.new(-6802.8, 42.4, 942.3),
    Vector3.new(-6807.1, 42.4, 943.1),
    Vector3.new(-6809.4, 42.4, 945.8)
}

local Colors = {
    Dark = Color3.fromRGB(8, 12, 8),
    DarkBackground = Color3.fromRGB(15, 25, 15),
    Primary = Color3.fromRGB(0, 255, 127),
    PrimaryDark = Color3.fromRGB(0, 180, 90),
    PrimaryLight = Color3.fromRGB(50, 255, 150),
    TextWhite = Color3.fromRGB(240, 255, 245),
    TextGray = Color3.fromRGB(150, 200, 160),
    TextDarkGray = Color3.fromRGB(100, 140, 110),
    Yellow = Color3.fromRGB(255, 200, 50),
    Red = Color3.fromRGB(255, 80, 80),
    ButtonBg = Color3.fromRGB(25, 35, 28),
    ButtonHover = Color3.fromRGB(35, 50, 38),
    ToggleActive = Color3.fromRGB(0, 100, 50)
}

local TweenInfoFast = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TweenInfoMedium = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TweenInfoSmooth = TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local TweenInfoBounce = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

local ESPEnabled = false
local NoClipEnabled = false
local FlyEnabled = false
local AutoATMEnabled = false
local AutoFarmEnabled = false
local MenuVisible = true

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GreenMenuV2_1"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local PositionFrame = Instance.new("Frame")
PositionFrame.Size = UDim2.new(0, 220, 0, 70)
PositionFrame.Position = UDim2.new(1, -235, 0, 15)
PositionFrame.BackgroundColor3 = Colors.DarkBackground
PositionFrame.BackgroundTransparency = 0.15
PositionFrame.Visible = true
PositionFrame.Parent = ScreenGui

local PositionCorner = Instance.new("UICorner")
PositionCorner.CornerRadius = UDim.new(0, 14)
PositionCorner.Parent = PositionFrame

local PositionStroke = Instance.new("UIStroke")
PositionStroke.Thickness = 1.5
PositionStroke.Color = Colors.Primary
PositionStroke.Transparency = 0.5
PositionStroke.Parent = PositionFrame

local PositionGradient = Instance.new("UIGradient")
PositionGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 30, 18)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 18, 10))
})
PositionGradient.Rotation = 90
PositionGradient.Parent = PositionFrame

local PositionHeader = Instance.new("Frame")
PositionHeader.Size = UDim2.new(1, 0, 0, 22)
PositionHeader.Position = UDim2.new(0, 0, 0, 0)
PositionHeader.BackgroundColor3 = Colors.Primary
PositionHeader.BackgroundTransparency = 0.85
PositionHeader.Parent = PositionFrame

local PositionHeaderCorner = Instance.new("UICorner")
PositionHeaderCorner.CornerRadius = UDim.new(0, 14)
PositionHeaderCorner.Parent = PositionHeader

local PositionHeaderBottom = Instance.new("Frame")
PositionHeaderBottom.Size = UDim2.new(1, 0, 0, 10)
PositionHeaderBottom.Position = UDim2.new(0, 0, 1, -10)
PositionHeaderBottom.BackgroundColor3 = Colors.Primary
PositionHeaderBottom.BackgroundTransparency = 0.85
PositionHeaderBottom.BorderSizePixel = 0
PositionHeaderBottom.Parent = PositionHeader

local PositionIcon = Instance.new("TextLabel")
PositionIcon.Size = UDim2.new(0, 25, 0, 22)
PositionIcon.Position = UDim2.new(0, 8, 0, 0)
PositionIcon.BackgroundTransparency = 1
PositionIcon.Text = "📍"
PositionIcon.TextSize = 12
PositionIcon.Font = Enum.Font.GothamBold
PositionIcon.TextColor3 = Colors.Primary
PositionIcon.Parent = PositionHeader

local PositionTitle = Instance.new("TextLabel")
PositionTitle.Size = UDim2.new(1, -35, 0, 22)
PositionTitle.Position = UDim2.new(0, 30, 0, 0)
PositionTitle.BackgroundTransparency = 1
PositionTitle.Text = "位置"
PositionTitle.TextSize = 11
PositionTitle.Font = Enum.Font.GothamBold
PositionTitle.TextColor3 = Colors.Primary
PositionTitle.TextXAlignment = Enum.TextXAlignment.Left
PositionTitle.Parent = PositionHeader

local PositionContent = Instance.new("Frame")
PositionContent.Size = UDim2.new(1, -16, 0, 40)
PositionContent.Position = UDim2.new(0, 8, 0, 26)
PositionContent.BackgroundTransparency = 1
PositionContent.Parent = PositionFrame

local XFrame = Instance.new("Frame")
XFrame.Size = UDim2.new(0, 62, 0, 38)
XFrame.Position = UDim2.new(0, 0, 0, 0)
XFrame.BackgroundColor3 = Colors.Dark
XFrame.BackgroundTransparency = 0.5
XFrame.Parent = PositionContent

local XCorner = Instance.new("UICorner")
XCorner.CornerRadius = UDim.new(0, 8)
XCorner.Parent = XFrame

local XLabel = Instance.new("TextLabel")
XLabel.Size = UDim2.new(1, 0, 0, 14)
XLabel.Position = UDim2.new(0, 0, 0, 2)
XLabel.BackgroundTransparency = 1
XLabel.Text = "X"
XLabel.TextSize = 10
XLabel.Font = Enum.Font.GothamBold
XLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
XLabel.Parent = XFrame

local XValue = Instance.new("TextLabel")
XValue.Name = "Value"
XValue.Size = UDim2.new(1, -6, 0, 18)
XValue.Position = UDim2.new(0, 3, 0, 16)
XValue.BackgroundTransparency = 1
XValue.Text = "0"
XValue.TextSize = 13
XValue.Font = Enum.Font.GothamBold
XValue.TextColor3 = Colors.TextWhite
XValue.TextTruncate = Enum.TextTruncate.AtEnd
XValue.Parent = XFrame

local YFrame = Instance.new("Frame")
YFrame.Size = UDim2.new(0, 62, 0, 38)
YFrame.Position = UDim2.new(0, 68, 0, 0)
YFrame.BackgroundColor3 = Colors.Dark
YFrame.BackgroundTransparency = 0.5
YFrame.Parent = PositionContent

local YCorner = Instance.new("UICorner")
YCorner.CornerRadius = UDim.new(0, 8)
YCorner.Parent = YFrame

local YLabel = Instance.new("TextLabel")
YLabel.Size = UDim2.new(1, 0, 0, 14)
YLabel.Position = UDim2.new(0, 0, 0, 2)
YLabel.BackgroundTransparency = 1
YLabel.Text = "Y"
YLabel.TextSize = 10
YLabel.Font = Enum.Font.GothamBold
YLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
YLabel.Parent = YFrame

local YValue = Instance.new("TextLabel")
YValue.Name = "Value"
YValue.Size = UDim2.new(1, -6, 0, 18)
YValue.Position = UDim2.new(0, 3, 0, 16)
YValue.BackgroundTransparency = 1
YValue.Text = "0"
YValue.TextSize = 13
YValue.Font = Enum.Font.GothamBold
YValue.TextColor3 = Colors.TextWhite
YValue.TextTruncate = Enum.TextTruncate.AtEnd
YValue.Parent = YFrame

local ZFrame = Instance.new("Frame")
ZFrame.Size = UDim2.new(0, 62, 0, 38)
ZFrame.Position = UDim2.new(0, 136, 0, 0)
ZFrame.BackgroundColor3 = Colors.Dark
ZFrame.BackgroundTransparency = 0.5
ZFrame.Parent = PositionContent

local ZCorner = Instance.new("UICorner")
ZCorner.CornerRadius = UDim.new(0, 8)
ZCorner.Parent = ZFrame

local ZLabel = Instance.new("TextLabel")
ZLabel.Size = UDim2.new(1, 0, 0, 14)
ZLabel.Position = UDim2.new(0, 0, 0, 2)
ZLabel.BackgroundTransparency = 1
ZLabel.Text = "Z"
ZLabel.TextSize = 10
ZLabel.Font = Enum.Font.GothamBold
ZLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
ZLabel.Parent = ZFrame

local ZValue = Instance.new("TextLabel")
ZValue.Name = "Value"
ZValue.Size = UDim2.new(1, -6, 0, 18)
ZValue.Position = UDim2.new(0, 3, 0, 16)
ZValue.BackgroundTransparency = 1
ZValue.Text = "0"
ZValue.TextSize = 13
ZValue.Font = Enum.Font.GothamBold
ZValue.TextColor3 = Colors.TextWhite
ZValue.TextTruncate = Enum.TextTruncate.AtEnd
ZValue.Parent = ZFrame

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 440)
MainFrame.Position = UDim2.new(0, 30, 0, 100)
MainFrame.BackgroundColor3 = Colors.DarkBackground
MainFrame.BackgroundTransparency = 0.02
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Colors.Primary
MainStroke.Transparency = 0.4
MainStroke.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 30, 20)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(12, 22, 14)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 14, 10))
})
MainGradient.Rotation = 160
MainGradient.Parent = MainFrame

local HeaderFrame = Instance.new("Frame")
HeaderFrame.Size = UDim2.new(1, 0, 0, 60)
HeaderFrame.BackgroundTransparency = 1
HeaderFrame.Parent = MainFrame

local HeaderLine = Instance.new("Frame")
HeaderLine.Size = UDim2.new(1, -30, 0, 1)
HeaderLine.Position = UDim2.new(0.5, 0, 1, 0)
HeaderLine.AnchorPoint = Vector2.new(0.5, 0)
HeaderLine.BackgroundColor3 = Colors.Primary
HeaderLine.BackgroundTransparency = 0.6
HeaderLine.Parent = HeaderFrame

local LogoFrame = Instance.new("TextLabel")
LogoFrame.Size = UDim2.new(0, 40, 0, 40)
LogoFrame.Position = UDim2.new(0, 15, 0.5, 0)
LogoFrame.AnchorPoint = Vector2.new(0, 0.5)
LogoFrame.BackgroundColor3 = Colors.Primary
LogoFrame.BackgroundTransparency = 0.85
LogoFrame.Text = "G"
LogoFrame.TextSize = 24
LogoFrame.Font = Enum.Font.GothamBlack
LogoFrame.TextColor3 = Colors.Primary
LogoFrame.Parent = HeaderFrame

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 10)
LogoCorner.Parent = LogoFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 150, 0, 24)
TitleLabel.Position = UDim2.new(0, 62, 0, 12)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.TextSize = 20
TitleLabel.TextColor3 = Colors.TextWhite
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Text = "绿色菜单"
TitleLabel.Parent = HeaderFrame

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(0, 150, 0, 14)
VersionLabel.Position = UDim2.new(0, 62, 0, 36)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Font = Enum.Font.Gotham
VersionLabel.TextSize = 11
VersionLabel.TextColor3 = Colors.TextDarkGray
VersionLabel.TextXAlignment = Enum.TextXAlignment.Left
VersionLabel.Text = "by Jack • v2.1"
VersionLabel.Parent = HeaderFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 32, 0, 32)
CloseButton.Position = UDim2.new(1, -45, 0.5, 0)
CloseButton.AnchorPoint = Vector2.new(0, 0.5)
CloseButton.BackgroundColor3 = Colors.ButtonBg
CloseButton.AutoButtonColor = false
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.TextColor3 = Colors.Red
CloseButton.Text = "×"
CloseButton.Parent = HeaderFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 32, 0, 32)
MinimizeButton.Position = UDim2.new(1, -82, 0.5, 0)
MinimizeButton.AnchorPoint = Vector2.new(0, 0.5)
MinimizeButton.BackgroundColor3 = Colors.ButtonBg
MinimizeButton.AutoButtonColor = false
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 22
MinimizeButton.TextColor3 = Colors.Yellow
MinimizeButton.Text = "-"
MinimizeButton.Parent = HeaderFrame

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(1, 0)
MinimizeCorner.Parent = MinimizeButton

local OriginalSize = MainFrame.Size
local Minimized = false

MinimizeButton.MouseEnter:Connect(function()
    TweenService:Create(MinimizeButton, TweenInfoFast, {
        TextColor3 = Colors.Dark,
        BackgroundColor3 = Colors.Yellow
    }):Play()
end)

MinimizeButton.MouseLeave:Connect(function()
    TweenService:Create(MinimizeButton, TweenInfoFast, {
        TextColor3 = Colors.Yellow,
        BackgroundColor3 = Colors.ButtonBg
    }):Play()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    if Minimized then
        TweenService:Create(MainFrame, TweenInfoMedium, {
            Size = UDim2.new(0, 320, 0, 55)
        }):Play()
        MinimizeButton.Text = "+"
        HeaderLine.Visible = false
    else
        TweenService:Create(MainFrame, TweenInfoMedium, {
            Size = OriginalSize
        }):Play()
        MinimizeButton.Text = "-"
        HeaderLine.Visible = true
    end
end)

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfoFast, {
        TextColor3 = Colors.TextWhite,
        BackgroundColor3 = Colors.Red
    }):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfoFast, {
        TextColor3 = Colors.Red,
        BackgroundColor3 = Colors.ButtonBg
    }):Play()
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

local Dragging = false
local DragStart = nil
local StartPos = nil

HeaderFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = input.Position
        StartPos = MainFrame.Position
    end
end)

HeaderFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(
            StartPos.X.Scale,
            StartPos.X.Offset + delta.X,
            StartPos.Y.Scale,
            StartPos.Y.Offset + delta.Y
        )
    end
end)

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -30, 0, 36)
TabBar.Position = UDim2.new(0.5, 0, 0, 70)
TabBar.AnchorPoint = Vector2.new(0.5, 0)
TabBar.BackgroundColor3 = Colors.Dark
TabBar.BackgroundTransparency = 0.3
TabBar.Parent = MainFrame

local TabBarCorner = Instance.new("UICorner")
TabBarCorner.CornerRadius = UDim.new(0, 10)
TabBarCorner.Parent = TabBar

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.Padding = UDim.new(0, 4)
TabLayout.Parent = TabBar

local TeleportTab = Instance.new("TextButton")
TeleportTab.Size = UDim2.new(0, 70, 0, 28)
TeleportTab.BackgroundColor3 = Colors.ButtonBg
TeleportTab.BackgroundTransparency = 0.5
TeleportTab.AutoButtonColor = false
TeleportTab.Text = "📍 传送"
TeleportTab.Font = Enum.Font.GothamBold
TeleportTab.TextSize = 11
TeleportTab.TextColor3 = Colors.TextGray
TeleportTab.Parent = TabBar

local TeleportTabCorner = Instance.new("UICorner")
TeleportTabCorner.CornerRadius = UDim.new(0, 8)
TeleportTabCorner.Parent = TeleportTab

local VisualTab = Instance.new("TextButton")
VisualTab.Size = UDim2.new(0, 70, 0, 28)
VisualTab.BackgroundColor3 = Colors.ButtonBg
VisualTab.BackgroundTransparency = 0.5
VisualTab.AutoButtonColor = false
VisualTab.Text = "👁 视觉"
VisualTab.Font = Enum.Font.GothamBold
VisualTab.TextSize = 11
VisualTab.TextColor3 = Colors.TextGray
VisualTab.Parent = TabBar

local VisualTabCorner = Instance.new("UICorner")
VisualTabCorner.CornerRadius = UDim.new(0, 8)
VisualTabCorner.Parent = VisualTab

local MiscTab = Instance.new("TextButton")
MiscTab.Size = UDim2.new(0, 70, 0, 28)
MiscTab.BackgroundColor3 = Colors.ButtonBg
MiscTab.BackgroundTransparency = 0.5
MiscTab.AutoButtonColor = false
MiscTab.Text = "⚡ 杂项"
MiscTab.Font = Enum.Font.GothamBold
MiscTab.TextSize = 11
MiscTab.TextColor3 = Colors.TextGray
MiscTab.Parent = TabBar

local MiscTabCorner = Instance.new("UICorner")
MiscTabCorner.CornerRadius = UDim.new(0, 8)
MiscTabCorner.Parent = MiscTab

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -24, 1, -125)
ContentFrame.Position = UDim2.new(0.5, 0, 0, 115)
ContentFrame.AnchorPoint = Vector2.new(0.5, 0)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local TeleportScroll = Instance.new("ScrollingFrame")
TeleportScroll.Size = UDim2.new(1, 0, 1, 0)
TeleportScroll.BackgroundTransparency = 1
TeleportScroll.ScrollBarThickness = 3
TeleportScroll.ScrollBarImageColor3 = Colors.Primary
TeleportScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
TeleportScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
TeleportScroll.Visible = true
TeleportScroll.Parent = ContentFrame

local TeleportLayout = Instance.new("UIListLayout")
TeleportLayout.Padding = UDim.new(0, 6)
TeleportLayout.Parent = TeleportScroll

local TeleportPadding = Instance.new("UIPadding")
TeleportPadding.PaddingTop = UDim.new(0, 4)
TeleportPadding.PaddingBottom = UDim.new(0, 4)
TeleportPadding.Parent = TeleportScroll

local VisualScroll = Instance.new("ScrollingFrame")
VisualScroll.Size = UDim2.new(1, 0, 1, 0)
VisualScroll.BackgroundTransparency = 1
VisualScroll.ScrollBarThickness = 3
VisualScroll.ScrollBarImageColor3 = Colors.Primary
VisualScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
VisualScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
VisualScroll.Visible = false
VisualScroll.Parent = ContentFrame

local VisualLayout = Instance.new("UIListLayout")
VisualLayout.Padding = UDim.new(0, 6)
VisualLayout.Parent = VisualScroll

local VisualPadding = Instance.new("UIPadding")
VisualPadding.PaddingTop = UDim.new(0, 4)
VisualPadding.PaddingBottom = UDim.new(0, 4)
VisualPadding.Parent = VisualScroll

local MiscScroll = Instance.new("ScrollingFrame")
MiscScroll.Size = UDim2.new(1, 0, 1, 0)
MiscScroll.BackgroundTransparency = 1
MiscScroll.ScrollBarThickness = 3
MiscScroll.ScrollBarImageColor3 = Colors.Primary
MiscScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
MiscScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
MiscScroll.Visible = false
MiscScroll.Parent = ContentFrame

local MiscLayout = Instance.new("UIListLayout")
MiscLayout.Padding = UDim.new(0, 6)
MiscLayout.Parent = MiscScroll

local MiscPadding = Instance.new("UIPadding")
MiscPadding.PaddingTop = UDim.new(0, 4)
MiscPadding.PaddingBottom = UDim.new(0, 4)
MiscPadding.Parent = MiscScroll

local CurrentTab = "Teleport"
local Tabs = {TeleportTab, VisualTab, MiscTab}
local TabContents = {
    Teleport = TeleportScroll,
    Visual = VisualScroll,
    Misc = MiscScroll
}

local function SwitchTab(tabName)
    CurrentTab = tabName
    for _, content in pairs(TabContents) do
        content.Visible = false
    end
    TabContents[tabName].Visible = true
    
    for _, tab in ipairs(Tabs) do
        local isActive = tab.Text:find(tabName) ~= nil
        TweenService:Create(tab, TweenInfoFast, {
            BackgroundColor3 = isActive and Colors.Primary or Colors.ButtonBg,
            BackgroundTransparency = isActive and 0.2 or 0.5,
            TextColor3 = isActive and Colors.TextWhite or Colors.TextGray
        }):Play()
    end
end

TeleportTab.MouseButton1Click:Connect(function()
    SwitchTab("Teleport")
end)

VisualTab.MouseButton1Click:Connect(function()
    SwitchTab("Visual")
end)

MiscTab.MouseButton1Click:Connect(function()
    SwitchTab("Misc")
end)

local function CreateButton(text, parent, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 38)
    Button.BackgroundColor3 = Colors.ButtonBg
    Button.AutoButtonColor = false
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 12
    Button.TextColor3 = Colors.TextWhite
    Button.Text = text
    Button.Parent = parent
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 10)
    ButtonCorner.Parent = Button
    
    local ButtonStroke = Instance.new("UIStroke")
    ButtonStroke.Thickness = 1
    ButtonStroke.Color = Colors.Primary
    ButtonStroke.Transparency = 0.7
    ButtonStroke.Parent = Button
    
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfoFast, {
            BackgroundColor3 = Colors.ButtonHover
        }):Play()
        TweenService:Create(ButtonStroke, TweenInfoFast, {
            Transparency = 0.3
        }):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfoFast, {
            BackgroundColor3 = Colors.ButtonBg
        }):Play()
        TweenService:Create(ButtonStroke, TweenInfoFast, {
            Transparency = 0.7
        }):Play()
    end)
    
    Button.MouseButton1Click:Connect(function()
        TweenService:Create(Button, TweenInfoFast, {
            BackgroundColor3 = Colors.Primary
        }):Play()
        task.wait(0.1)
        TweenService:Create(Button, TweenInfoFast, {
            BackgroundColor3 = Colors.ButtonHover
        }):Play()
        if callback then
            callback()
        end
    end)
    
    return Button
end

local function CreateToggle(text, parent, defaultState, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 38)
    ToggleFrame.BackgroundColor3 = Colors.ButtonBg
    ToggleFrame.Parent = parent
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 10)
    ToggleCorner.Parent = ToggleFrame
    
    local ToggleStroke = Instance.new("UIStroke")
    ToggleStroke.Thickness = 1
    ToggleStroke.Color = Colors.Primary
    ToggleStroke.Transparency = 0.7
    ToggleStroke.Parent = ToggleFrame
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 12, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Font = Enum.Font.GothamBold
    ToggleLabel.TextSize = 12
    ToggleLabel.TextColor3 = Colors.TextWhite
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Text = text
    ToggleLabel.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("Frame")
    ToggleButton.Size = UDim2.new(0, 44, 0, 22)
    ToggleButton.Position = UDim2.new(1, -54, 0.5, 0)
    ToggleButton.AnchorPoint = Vector2.new(0, 0.5)
    ToggleButton.BackgroundColor3 = defaultState and Colors.Primary or Colors.Dark
    ToggleButton.Parent = ToggleFrame
    
    local ToggleButtonCorner = Instance.new("UICorner")
    ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
    ToggleButtonCorner.Parent = ToggleButton
    
    local ToggleCircle = Instance.new("Frame")
    ToggleCircle.Size = UDim2.new(0, 18, 0, 18)
    ToggleCircle.Position = defaultState and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
    ToggleCircle.AnchorPoint = Vector2.new(0, 0.5)
    ToggleCircle.BackgroundColor3 = Colors.TextWhite
    ToggleCircle.Parent = ToggleButton
    
    local ToggleCircleCorner = Instance.new("UICorner")
    ToggleCircleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCircleCorner.Parent = ToggleCircle
    
    local State = defaultState
    
    local function UpdateToggle()
        State = not State
        TweenService:Create(ToggleButton, TweenInfoMedium, {
            BackgroundColor3 = State and Colors.Primary or Colors.Dark
        }):Play()
        TweenService:Create(ToggleCircle, TweenInfoMedium, {
            Position = State and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
        }):Play()
        if callback then
            callback(State)
        end
    end
    
    local ClickButton = Instance.new("TextButton")
    ClickButton.Size = UDim2.new(1, 0, 1, 0)
    ClickButton.BackgroundTransparency = 1
    ClickButton.Text = ""
    ClickButton.Parent = ToggleFrame
    ClickButton.MouseButton1Click:Connect(UpdateToggle)
    
    return ToggleFrame, function() return State end, function(newState)
        if newState ~= State then
            UpdateToggle()
        end
    end
end

local function CreateSection(text, parent)
    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(1, 0, 0, 24)
    Section.BackgroundTransparency = 1
    Section.Parent = parent
    
    local SectionLine1 = Instance.new("Frame")
    SectionLine1.Size = UDim2.new(0.25, 0, 0, 1)
    SectionLine1.Position = UDim2.new(0, 0, 0.5, 0)
    SectionLine1.BackgroundColor3 = Colors.Primary
    SectionLine1.BackgroundTransparency = 0.5
    SectionLine1.Parent = Section
    
    local SectionLabel = Instance.new("TextLabel")
    SectionLabel.Size = UDim2.new(0.5, 0, 1, 0)
    SectionLabel.Position = UDim2.new(0.25, 0, 0, 0)
    SectionLabel.BackgroundTransparency = 1
    SectionLabel.Font = Enum.Font.GothamBold
    SectionLabel.TextSize = 10
    SectionLabel.TextColor3 = Colors.Primary
    SectionLabel.Text = text
    SectionLabel.Parent = Section
    
    local SectionLine2 = Instance.new("Frame")
    SectionLine2.Size = UDim2.new(0.25, 0, 0, 1)
    SectionLine2.Position = UDim2.new(0.75, 0, 0.5, 0)
    SectionLine2.BackgroundColor3 = Colors.Primary
    SectionLine2.BackgroundTransparency = 0.5
    SectionLine2.Parent = Section
    
    return Section
end

local function TeleportTo(position)
    local character = LocalPlayer.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(position)
        end
    end
end

local function GetNearestATM()
    local character = LocalPlayer.Character
    if not character then return nil end
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return nil end
    
    local nearestPos = nil
    local nearestDist = math.huge
    
    for _, pos in ipairs(ATMPositions) do
        local dist = (humanoidRootPart.Position - pos).Magnitude
        if dist < nearestDist then
            nearestDist = dist
            nearestPos = pos
        end
    end
    
    return nearestPos
end

local function GetNearestCabinet()
    local character = LocalPlayer.Character
    if not character then return nil end
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return nil end
    
    local nearestPos = nil
    local nearestDist = math.huge
    
    for _, pos in ipairs(CabinetPositions) do
        local dist = (humanoidRootPart.Position - pos).Magnitude
        if dist < nearestDist then
            nearestDist = dist
            nearestPos = pos
        end
    end
    
    return nearestPos
end

-- Teleport Section
CreateSection("LOCATIONS", TeleportScroll)

for name, position in pairs(TeleportPositions) do
    CreateButton("📍 " .. name, TeleportScroll, function()
        TeleportTo(position)
    end)
end

CreateSection("快速传送", TeleportScroll)

CreateButton("🏧 最近的ATM机", TeleportScroll, function()
    local pos = GetNearestATM()
    if pos then
        TeleportTo(pos)
    end
end)

CreateButton("🗄️ 最近的机柜", TeleportScroll, function()
    local pos = GetNearestCabinet()
    if pos then
        TeleportTo(pos)
    end
end)

-- Visual Section
CreateSection("PLAYER ESP", VisualScroll)

local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "ESPFolder"
ESPFolder.Parent = ScreenGui

local function CreateESP(player)
    if player == LocalPlayer then return end
    
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local existingESP = ESPFolder:FindFirstChild(player.Name)
    if existingESP then existingESP:Destroy() end
    
    local ESPGui = Instance.new("BillboardGui")
    ESPGui.Name = player.Name
    ESPGui.Adornee = humanoidRootPart
    ESPGui.Size = UDim2.new(0, 100, 0, 40)
    ESPGui.StudsOffset = Vector3.new(0, 3, 0)
    ESPGui.AlwaysOnTop = true
    ESPGui.Parent = ESPFolder
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextSize = 14
    NameLabel.TextColor3 = Colors.Primary
    NameLabel.TextStrokeTransparency = 0.5
    NameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    NameLabel.Text = player.Name
    NameLabel.Parent = ESPGui
    
    local DistanceLabel = Instance.new("TextLabel")
    DistanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
    DistanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
    DistanceLabel.BackgroundTransparency = 1
    DistanceLabel.Font = Enum.Font.Gotham
    DistanceLabel.TextSize = 12
    DistanceLabel.TextColor3 = Colors.TextWhite
    DistanceLabel.TextStrokeTransparency = 0.5
    DistanceLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    DistanceLabel.Parent = ESPGui
    
    local Highlight = Instance.new("Highlight")
    Highlight.Name = player.Name .. "_Highlight"
    Highlight.Adornee = character
    Highlight.FillColor = Colors.Primary
    Highlight.FillTransparency = 0.7
    Highlight.OutlineColor = Colors.Primary
    Highlight.OutlineTransparency = 0
    Highlight.Parent = ESPFolder
    
    return ESPGui, DistanceLabel, Highlight
end

local function UpdateESP()
    if not ESPEnabled then
        for _, esp in ipairs(ESPFolder:GetChildren()) do
            esp:Destroy()
        end
        return
    end
    
    local myCharacter = LocalPlayer.Character
    local myHRP = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart")
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            if character then
                local hrp = character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local espGui = ESPFolder:FindFirstChild(player.Name)
                    if not espGui then
                        CreateESP(player)
                        espGui = ESPFolder:FindFirstChild(player.Name)
                    end
                    
                    if espGui and myHRP then
                        local distance = (myHRP.Position - hrp.Position).Magnitude
                        local distLabel = espGui:FindFirstChildOfClass("TextLabel")
                        if distLabel then
                            for _, child in ipairs(espGui:GetChildren()) do
                                if child:IsA("TextLabel") and child.Position.Y.Scale > 0 then
                                    child.Text = string.format("%.0f studs", distance)
                                end
                            end
                        end
                    end
                end
            else
                local esp = ESPFolder:FindFirstChild(player.Name)
                if esp then esp:Destroy() end
                local highlight = ESPFolder:FindFirstChild(player.Name .. "_Highlight")
                if highlight then highlight:Destroy() end
            end
        end
    end
end

CreateToggle("👁 玩家 ESP", VisualScroll, false, function(state)
    ESPEnabled = state
    if not state then
        for _, esp in ipairs(ESPFolder:GetChildren()) do
            esp:Destroy()
        end
    end
end)

CreateSection("CASH ESP", VisualScroll)

local CashESPEnabled = false
local CashESPFolder = Instance.new("Folder")
CashESPFolder.Name = "CashESPFolder"
CashESPFolder.Parent = ScreenGui

local function UpdateCashESP()
    for _, esp in ipairs(CashESPFolder:GetChildren()) do
        esp:Destroy()
    end
    
    if not CashESPEnabled then return end
    
    local cashFolder = workspace:FindFirstChild("Cash")
    if not cashFolder then return end
    
    for _, cash in ipairs(cashFolder:GetChildren()) do
        local part = cash:IsA("BasePart") and cash or cash:FindFirstChildOfClass("BasePart")
        if part then
            local highlight = Instance.new("Highlight")
            highlight.Adornee = cash
            highlight.FillColor = Colors.Yellow
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = Colors.Yellow
            highlight.OutlineTransparency = 0
            highlight.Parent = CashESPFolder
        end
    end
end

CreateToggle("💵 现金 ESP", VisualScroll, false, function(state)
    CashESPEnabled = state
    UpdateCashESP()
end)

-- Misc Section
CreateSection("MOVEMENT", MiscScroll)

local FlySpeed = 50
local Flying = false
local FlyBodyVelocity = nil
local FlyBodyGyro = nil

local function StartFly()
    local character = LocalPlayer.Character
    if not character then return end
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    Flying = true
    
    FlyBodyVelocity = Instance.new("BodyVelocity")
    FlyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
    FlyBodyVelocity.Parent = humanoidRootPart
    
    FlyBodyGyro = Instance.new("BodyGyro")
    FlyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    FlyBodyGyro.P = 10000
    FlyBodyGyro.D = 100
    FlyBodyGyro.Parent = humanoidRootPart
    
    humanoid.PlatformStand = true
end

local function StopFly()
    Flying = false
    
    if FlyBodyVelocity then
        FlyBodyVelocity:Destroy()
        FlyBodyVelocity = nil
    end
    
    if FlyBodyGyro then
        FlyBodyGyro:Destroy()
        FlyBodyGyro = nil
    end
    
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
end

CreateToggle("✈️ 飞", MiscScroll, false, function(state)
    FlyEnabled = state
    if state then
        StartFly()
    else
        StopFly()
    end
end)

local NoClipConnection = nil

CreateToggle("👻 穿墙", MiscScroll, false, function(state)
    NoClipEnabled = state
    if state then
        NoClipConnection = RunService.Stepped:Connect(function()
            local character = LocalPlayer.Character
            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if NoClipConnection then
            NoClipConnection:Disconnect()
            NoClipConnection = nil
        end
    end
end)

CreateSection("SPEED", MiscScroll)

local SpeedEnabled = false
local SpeedValue = 50

CreateToggle("⚡ 提速", MiscScroll, false, function(state)
    SpeedEnabled = state
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = state and SpeedValue or 16
        end
    end
end)

CreateSection("AUTO FEATURES", MiscScroll)

local AutoATMConnection = nil
local CurrentATMIndex = 1

CreateToggle("🏧 自动 ATM", MiscScroll, false, function(state)
    AutoATMEnabled = state
    if state then
        AutoATMConnection = task.spawn(function()
            while AutoATMEnabled do
                local pos = ATMPositions[CurrentATMIndex]
                if pos then
                    TeleportTo(pos)
                    CurrentATMIndex = CurrentATMIndex + 1
                    if CurrentATMIndex > #ATMPositions then
                        CurrentATMIndex = 1
                    end
                end
                task.wait(3)
            end
        end)
    end
end)

CreateSection("OTHER", MiscScroll)

CreateButton("💀 重置玩家", MiscScroll, function()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Health = 0
        end
    end
end)

CreateButton("🔄 重进 Server", MiscScroll, function()
    local TeleportService = game:GetService("TeleportService")
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

-- Initialize first tab
SwitchTab("Teleport")

-- Position Update Loop
RunService.Heartbeat:Connect(function()
    local character = LocalPlayer.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local pos = humanoidRootPart.Position
            XValue.Text = string.format("%.1f", pos.X)
            YValue.Text = string.format("%.1f", pos.Y)
            ZValue.Text = string.format("%.1f", pos.Z)
        end
    end
    
    -- Update ESP
    UpdateESP()
    
    -- Update Fly
    if Flying and FlyBodyVelocity and FlyBodyGyro then
        local camera = workspace.CurrentCamera
        local moveDirection = Vector3.new(0, 0, 0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            moveDirection = moveDirection - Vector3.new(0, 1, 0)
        end
        
        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit
        end
        
        FlyBodyVelocity.Velocity = moveDirection * FlySpeed
        FlyBodyGyro.CFrame = camera.CFrame
    end
end)

-- Toggle Menu Visibility
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.RightShift then
        MenuVisible = not MenuVisible
        MainFrame.Visible = MenuVisible
        PositionFrame.Visible = MenuVisible
    end
end)

-- Player Added/Removing for ESP
Players.PlayerAdded:Connect(function(player)
    if ESPEnabled then
        player.CharacterAdded:Connect(function()
            task.wait(1)
            CreateESP(player)
        end)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    local esp = ESPFolder:FindFirstChild(player.Name)
    if esp then esp:Destroy() end
    local highlight = ESPFolder:FindFirstChild(player.Name .. "_Highlight")
    if highlight then highlight:Destroy() end
end)

-- Character Added for speed reset
LocalPlayer.CharacterAdded:Connect(function(character)
    task.wait(1)
    if SpeedEnabled then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = SpeedValue
        end
    end
    
    if FlyEnabled then
        StopFly()
        task.wait(0.5)
        StartFly()
    end
end)

print("GreenMenu v2.1 Loaded Successfully!")
print("Press RightShift to toggle menu")
