-- Xen0UI: Dual Theme Elastic Edition (Light/Dark Engine)
local Xen0UI = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Mouse = game.Players.LocalPlayer:GetMouse()

local function fluidTween(object, duration, style, dir, properties)
    local t = TweenService:Create(object, TweenInfo.new(duration, style, dir), properties)
    t:Play()
    return t
end

function Xen0UI:CreateWindow(Config)
    local WindowName = Config.Name or "Xen0 UI Engine"
    local LoadingTitle = Config.LoadingTitle or "Xen0 UI"
    local LoadingSubtitle = Config.LoadingSubtitle or "by Developer"
    
    -- Theme Detection Engine
    local selectedTheme = Config.Theme or "Light"
    local isDark = (selectedTheme == "Dark")

    -- Theme Color Mapping Tables
    local Theme = {
        MainBg       = isDark and Color3.fromRGB(20, 20, 20)    or Color3.fromRGB(255, 255, 255),
        ElementBg    = isDark and Color3.fromRGB(28, 28, 28)    or Color3.fromRGB(248, 248, 248),
        TextPrimary  = isDark and Color3.fromRGB(240, 240, 240) or Color3.fromRGB(0, 0, 0),
        TextSecondary= isDark and Color3.fromRGB(150, 150, 150) or Color3.fromRGB(120, 120, 120),
        TextLabel    = isDark and Color3.fromRGB(200, 200, 200) or Color3.fromRGB(40, 40, 40),
        Border       = isDark and Color3.fromRGB(38, 38, 38)    or Color3.fromRGB(225, 225, 225),
        Line         = isDark and Color3.fromRGB(32, 32, 32)    or Color3.fromRGB(240, 240, 240),
        TabActive    = isDark and Color3.fromRGB(32, 32, 32)    or Color3.fromRGB(242, 242, 242),
        TabInactive  = isDark and Color3.fromRGB(20, 20, 20)    or Color3.fromRGB(255, 255, 255),
        ToggleTrack  = isDark and Color3.fromRGB(45, 45, 45)    or Color3.fromRGB(220, 220, 220),
        ToggleActive = isDark and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
        ToggleBall   = isDark and Color3.fromRGB(20, 20, 20)    or Color3.fromRGB(255, 255, 255),
        InputBox     = isDark and Color3.fromRGB(25, 25, 25)    or Color3.fromRGB(255, 255, 255),
    }

    -- Minimize controllers
    local uiVisible = true
    local minimizeKey = Enum.KeyCode.K
    local bindingMinimize = false

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Xen0UI_Engine"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ResetOnSpawn = false

    -- ==========================================
    -- 1. RAYFIELD STYLE SPLASH INTRO ANIMATION
    -- ==========================================
    local SplashFrame = Instance.new("Frame")
    SplashFrame.Size = UDim2.new(0, 320, 0, 160)
    SplashFrame.Position = UDim2.new(0.5, -160, 0.5, -80)
    SplashFrame.BackgroundColor3 = Theme.MainBg
    SplashFrame.BackgroundTransparency = 1
    SplashFrame.ClipsDescendants = true
    SplashFrame.Parent = ScreenGui

    Instance.new("UICorner", SplashFrame).CornerRadius = UDim.new(0, 16)
    local SplashStroke = Instance.new("UIStroke", SplashFrame)
    SplashStroke.Color = Theme.Border
    SplashStroke.Thickness = 2

    local SplashText = Instance.new("TextLabel", SplashFrame)
    SplashText.Size = UDim2.new(1, 0, 0, 40)
    SplashText.Position = UDim2.new(0, 0, 0.3, -20)
    SplashText.BackgroundTransparency = 1
    SplashText.Text = LoadingTitle
    SplashText.TextColor3 = Theme.TextPrimary
    SplashText.Font = Enum.Font.FredokaOne
    SplashText.TextSize = 35
    SplashText.TextTransparency = 1

    local SubText = Instance.new("TextLabel", SplashFrame)
    SubText.Size = UDim2.new(1, 0, 0, 20)
    SubText.Position = UDim2.new(0, 0, 0.6, 0)
    SubText.BackgroundTransparency = 1
    SubText.Text = LoadingSubtitle
    SubText.TextColor3 = Theme.TextSecondary
    SubText.Font = Enum.Font.SourceSansItalic
    SubText.TextSize = 16
    SubText.TextTransparency = 1

    fluidTween(SplashFrame, 0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {BackgroundTransparency = 0})
    fluidTween(SplashText, 0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out, {TextTransparency = 0, TextSize = 42})
    local subIn = fluidTween(SubText, 0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {TextTransparency = 0})
    subIn.Completed:Wait()
    task.wait(1.2)
    
    fluidTween(SplashText, 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In, {TextTransparency = 1})
    fluidTween(SubText, 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In, {TextTransparency = 1})
    local closeSplash = fluidTween(SplashFrame, 0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.In, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)})
    closeSplash.Completed:Wait()
    SplashFrame:Destroy()

    -- ==========================================
    -- 2. MAIN HUB INTERFACE
    -- ==========================================
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 520, 0, 360)
    MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
    MainFrame.BackgroundColor3 = Theme.MainBg
    MainFrame.ClipsDescendants = true
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Theme.Border

    MainFrame.Size = UDim2.new(0, 10, 0, 10)
    MainFrame.Position = UDim2.new(0.5, -5, 0.5, -5)
    MainFrame.BackgroundTransparency = 1
    fluidTween(MainFrame, 0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out, {Size = UDim2.new(0, 520, 0, 360), Position = UDim2.new(0.5, -260, 0.5, -180), BackgroundTransparency = 0})

    local OpenBtn = Instance.new("TextButton")
    OpenBtn.Name = "OpenButton"
    OpenBtn.Size = UDim2.new(0, 130, 0, 32)
    OpenBtn.Position = UDim2.new(0.5, -65, 0, -40)
    OpenBtn.BackgroundColor3 = Theme.MainBg
    OpenBtn.Text = "Xen0 UI - Open"
    OpenBtn.TextColor3 = Theme.TextPrimary
    OpenBtn.Font = Enum.Font.SourceSansBold
    OpenBtn.TextSize = 14
    OpenBtn.Parent = ScreenGui

    Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 6)
    local oStroke = Instance.new("UIStroke", OpenBtn)
    oStroke.Color = Theme.Border

    local function toggleUI()
        uiVisible = not uiVisible
        if uiVisible then
            MainFrame.Visible = true
            fluidTween(OpenBtn, 0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {Position = UDim2.new(0.5, -65, 0, -40)})
            fluidTween(MainFrame, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, {Size = UDim2.new(0, 520, 0, 360), Position = UDim2.new(0.5, -260, 0.5, -180), BackgroundTransparency = 0})
        else
            fluidTween(MainFrame, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0, 15), BackgroundTransparency = 1})
            task.wait(0.3)
            MainFrame.Visible = false
            fluidTween(OpenBtn, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out, {Position = UDim2.new(0.5, -65, 0, 15)})
        end
    end

    OpenBtn.MouseButton1Click:Connect(toggleUI)

    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if not bindingMinimize and input.KeyCode == minimizeKey then
            toggleUI()
        end
    end)

    local Header = Instance.new("Frame", MainFrame)
    Header.Size = UDim2.new(1, 0, 0, 45)
    Header.BackgroundTransparency = 1

    local Title = Instance.new("TextLabel", Header)
    Title.Size = UDim2.new(1, -20, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = WindowName
    Title.TextColor3 = Theme.TextPrimary
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local BorderLine = Instance.new("Frame", MainFrame)
    BorderLine.Size = UDim2.new(1, 0, 0, 1)
    BorderLine.Position = UDim2.new(0, 0, 0, 45)
    BorderLine.BackgroundColor3 = Theme.Line
    BorderLine.BorderSizePixel = 0

    local Sidebar = Instance.new("ScrollingFrame", MainFrame)
    Sidebar.Size = UDim2.new(0, 140, 1, -46)
    Sidebar.Position = UDim2.new(0, 0, 0, 46)
    Sidebar.BackgroundTransparency = 1
    Sidebar.BorderSizePixel = 0
    Sidebar.ScrollBarThickness = 0

    local SidebarLayout = Instance.new("UIListLayout", Sidebar)
    SidebarLayout.Padding = UDim.new(0, 6)
    SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    Instance.new("UIPadding", Sidebar).PaddingTop = UDim.new(0, 12)

    local ContentDisplay = Instance.new("Frame", MainFrame)
    ContentDisplay.Size = UDim2.new(1, -155, 1, -56)
    ContentDisplay.Position = UDim2.new(0, 150, 0, 51)
    ContentDisplay.BackgroundTransparency = 1

    local SideDivider = Instance.new("Frame", MainFrame)
    SideDivider.Size = UDim2.new(0, 1, 1, -46)
    SideDivider.Position = UDim2.new(0, 140, 0, 46)
    SideDivider.BackgroundColor3 = Theme.Line
    SideDivider.BorderSizePixel = 0

    local WindowAPI = {}
    local firstTab = true

    function WindowAPI:CreateTab(tabName)
        local TabPage = Instance.new("ScrollingFrame", ContentDisplay)
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.BorderSizePixel = 0
        TabPage.ScrollBarThickness = 2
        TabPage.ScrollBarImageColor3 = Theme.Border
        TabPage.Visible = firstTab

        local PageLayout = Instance.new("UIListLayout", TabPage)
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder

        local TabButton = Instance.new("TextButton", Sidebar)
        TabButton.Size = UDim2.new(0, 120, 0, 34)
        TabButton.BackgroundColor3 = firstTab and Theme.TabActive or Theme.TabInactive
        TabButton.Text = tabName
        TabButton.TextColor3 = firstTab and Theme.TextPrimary or Theme.TextSecondary
        TabButton.Font = Enum.Font.SourceSansSemibold
