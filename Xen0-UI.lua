-- Xen0UI Library Framework (Rebranded & Optimized)
local Xen0UI = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Mouse = game.Players.LocalPlayer:GetMouse()

local function tween(object, info, properties)
    local t = TweenService:Create(object, TweenInfo.new(unpack(info)), properties)
    t:Play()
    return t
end

function Xen0UI:Init()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Xen0UI_Engine"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ResetOnSpawn = false

    -- ==========================================
    -- 1. XEN0 UI SPLASH SCREEN ANIMATION
    -- ==========================================
    local SplashFrame = Instance.new("Frame")
    SplashFrame.Name = "SplashFrame"
    SplashFrame.Size = UDim2.new(0, 300, 0, 150)
    SplashFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    SplashFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SplashFrame.BorderSizePixel = 0
    SplashFrame.ClipsDescendants = true
    SplashFrame.BackgroundTransparency = 1
    SplashFrame.Parent = ScreenGui

    local SplashCorner = Instance.new("UICorner")
    SplashCorner.CornerRadius = UDim.new(0, 12)
    SplashCorner.Parent = SplashFrame

    local SplashText = Instance.new("TextLabel")
    SplashText.Size = UDim2.new(1, 0, 1, 0)
    SplashText.BackgroundTransparency = 1
    SplashText.Text = "Xen0 UI"
    SplashText.TextColor3 = Color3.fromRGB(0, 0, 0)
    SplashText.Font = Enum.Font.FredokaOne
    SplashText.TextSize = 40
    SplashText.TextTransparency = 1
    SplashText.Parent = SplashFrame

    local SplashStroke = Instance.new("UIStroke")
    SplashStroke.Color = Color3.fromRGB(230, 230, 230)
    SplashStroke.Thickness = 2
    SplashStroke.Parent = SplashFrame

    tween(SplashFrame, {0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out}, {BackgroundTransparency = 0})
    local textTween = tween(SplashText, {0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out}, {TextTransparency = 0, TextSize = 45})
    textTween.Completed:Wait()
    task.wait(1.2)
    
    tween(SplashText, {0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In}, {TextTransparency = 1})
    local closeSplash = tween(SplashFrame, {0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In}, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)})
    closeSplash.Completed:Wait()
    SplashFrame:Destroy()

    -- ==========================================
    -- 2. MAIN HUB INTERFACE (White & Black)
    -- ==========================================
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 520, 0, 360)
    MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
    MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0) 
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 9)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(225, 225, 225)
    MainStroke.Thickness = 1
    MainStroke.Parent = MainFrame

    tween(MainFrame, {0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out}, {
        Size = UDim2.new(0, 520, 0, 360),
        Position = UDim2.new(0.5, -260, 0.5, -180)
    })

    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 45)
    Header.BackgroundTransparency = 1
    Header.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Xen0 UI Engine"
    Title.TextColor3 = Color3.fromRGB(0, 0, 0)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header

    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(1, 0, 0, 1)
    Line.Position = UDim2.new(0, 0, 0, 45)
    Line.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    Line.BorderSizePixel = 0
    Line.Parent = MainFrame

    local Sidebar = Instance.new("ScrollingFrame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 140, 1, -46)
    Sidebar.Position = UDim2.new(0, 0, 0, 46)
    Sidebar.BackgroundTransparency = 1
    Sidebar.BorderSizePixel = 0
    Sidebar.ScrollBarThickness = 0
    Sidebar.Parent = MainFrame

    local SidebarLayout = Instance.new("UIListLayout")
    SidebarLayout.Padding = UDim.new(0, 4)
    SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SidebarLayout.Parent = Sidebar

    local SidebarPadding = Instance.new("UIPadding")
    SidebarPadding.PaddingTop = UDim.new(0, 10)
    SidebarPadding.Parent = Sidebar

    local ContentDisplay = Instance.new("Frame")
    ContentDisplay.Name = "ContentDisplay"
    ContentDisplay.Size = UDim2.new(1, -155, 1, -56)
    ContentDisplay.Position = UDim2.new(0, 150, 0, 51)
    ContentDisplay.BackgroundTransparency = 1
    ContentDisplay.Parent = MainFrame

    local SideDivider = Instance.new("Frame")
    SideDivider.Size = UDim2.new(0, 1, 1, -46)
    SideDivider.Position = UDim2.new(0, 140, 0, 46)
    SideDivider.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    SideDivider.BorderSizePixel = 0
    SideDivider.Parent = MainFrame

    local WindowAPI = {}
    local firstTab = true

    function WindowAPI:CreateTab(tabName)
        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Name = tabName .. "_Page"
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.BorderSizePixel = 0
        TabPage.ScrollBarThickness = 3
        TabPage.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200)
        TabPage.Visible = firstTab
        TabPage.Parent = ContentDisplay

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Padding = UDim.new(0, 6)
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Parent = TabPage

        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName .. "_Btn"
        TabButton.Size = UDim2.new(0, 120, 0, 32)
        TabButton.BackgroundColor3 = firstTab and Color3.fromRGB(245, 245, 245) or Color3.fromRGB(255, 255, 255)
        TabButton.Text = tabName
        TabButton.TextColor3 = firstTab and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(120, 120, 120)
        TabButton.Font = Enum.Font.SourceSansSemibold
        TabButton.TextSize = 14
        TabButton.BorderSizePixel = 0
        TabButton.Parent = Sidebar

        local TabBtnCorner = Instance.new("UICorner")
        TabBtnCorner.CornerRadius = UDim.new(0, 6)
        TabBtnCorner.Parent = TabButton

        if firstTab then firstTab = false end

        TabButton.MouseButton1Click:Connect(function()
            for _, page in pairs(ContentDisplay:GetChildren()) do
                page.Visible = false
            end
            for _, btn in pairs(Sidebar:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    btn.TextColor3 = Color3.fromRGB(120, 120, 120)
                end
            end
            TabPage.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
            TabButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        end)

        local TabAPI = {}

        local function updateSize()
            TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 15)
        end

        -- ==========================================
        -- ELEMENT: BUTTON
        -- ==========================================
        function TabAPI:CreateButton(btnText, callback)
            local ButtonFrame = Instance.new("TextButton")
            ButtonFrame.Size = UDim2.new(1, -10, 0, 38)
            ButtonFrame.BackgroundColor3 = Color3.fromRGB(248, 248, 248)
            ButtonFrame.Text = ""
            ButtonFrame.BorderSizePixel = 0
            ButtonFrame.Parent = TabPage

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 6)
            BtnCorner.Parent = ButtonFrame

            local BtnStroke = Instance.new("UIStroke")
            BtnStroke.Color = Color3.fromRGB(240, 240, 240)
            BtnStroke.Parent = ButtonFrame

            local BtnTextLabel = Instance.new("TextLabel")
            BtnTextLabel.Size = UDim2.new(1, -20, 1, 0)
            BtnTextLabel.Position = UDim2.new(0, 12, 0, 0)
            BtnTextLabel.BackgroundTransparency = 1
            BtnTextLabel.Text = btnText
            BtnTextLabel.TextColor3 = Color3.fromRGB(40, 40, 40)
            BtnTextLabel.Font = Enum.Font.SourceSansMedium
            BtnTextLabel.TextSize = 14
            BtnTextLabel.TextXAlignment = Enum.TextXAlignment.Left
            BtnTextLabel.Parent = ButtonFrame

            ButtonFrame.MouseButton1Click:Connect(function()
                tween(ButtonFrame, {0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {BackgroundColor3 = Color3.fromRGB(235, 235, 235)})
                task.wait(0.08)
                tween(ButtonFrame, {0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {BackgroundColor3 = Color3.fromRGB(248, 248, 248)})
                pcall(callback)
            end)

            updateSize()
        end

        -- ==========================================
        -- ELEMENT: TOGGLE
        -- ==========================================
        function TabAPI:CreateToggle(toggleText, defaultState, callback)
            local toggleActive = defaultState or false

            local ToggleFrame = Instance.new("Frame")
