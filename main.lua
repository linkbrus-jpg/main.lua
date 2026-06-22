local UILibrary = {}
UILibrary.__index = UILibrary

local Tab = {}
Tab.__index = Tab

-- Servis Roblox
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

-- Kumpulan Warna Premium (Theme Palette)
local Theme = {
    Background = Color3.fromRGB(11, 11, 12),
    Sidebar = Color3.fromRGB(16, 16, 18),
    Element = Color3.fromRGB(20, 20, 23),
    Accent = Color3.fromRGB(239, 45, 66), -- Merah Neon Premium
    Border = Color3.fromRGB(32, 32, 36),
    TextMain = Color3.fromRGB(245, 245, 245),
    TextDark = Color3.fromRGB(140, 140, 145)
}

-- ==========================================
-- FUNGSI PEMBANTU: DRAGGABLE (BISA DIGESER)
-- ==========================================
local function makeDraggable(guiObject)
    local dragging, dragInput, dragStart, startPos
    
    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    guiObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            local targetPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            TweenService:Create(guiObject, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetPos}):Play()
        end
    end)
end

-- ==========================================
-- 1. UTAMA: MEMBUAT WINDOW (JENDELA UTAMA)
-- ==========================================
function UILibrary.CreateWindow(config)
    local Window = setmetatable({}, UILibrary)
    Window.Tabs = {}
    
    local titleText = config.Title or "Custom Hub"
    local logoId = config.Logo or "rbxassetid://0"
    
    -- ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PremiumUILibrary"
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false
    Window.ScreenGui = ScreenGui

    -- 🔲 LOGO OPEN (Kotak, Lebih Kecil & Geser)
    local OpenButton = Instance.new("ImageButton")
    OpenButton.Name = "OpenLogo"
    OpenButton.Size = UDim2.new(0, 40, 0, 40)
    OpenButton.Position = UDim2.new(0.05, 0, 0.05, 0)
    OpenButton.Image = logoId
    OpenButton.BackgroundColor3 = Theme.Sidebar
    OpenButton.Visible = false
    OpenButton.Parent = ScreenGui
    Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 8)
    
    local OpenStroke = Instance.new("UIStroke", OpenButton)
    OpenStroke.Color = Theme.Border
    OpenStroke.Thickness = 1
    makeDraggable(OpenButton)

    -- Efek hover logo
    OpenButton.MouseEnter:Connect(function()
        TweenService:Create(OpenStroke, TweenInfo.new(0.2), {Color = Theme.Accent}):Play()
    end)
    OpenButton.MouseLeave:Connect(function()
        TweenService:Create(OpenStroke, TweenInfo.new(0.2), {Color = Theme.Border}):Play()
    end)

    -- ⚫ MAIN FRAME (Premium Compact Size)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 480, 0, 300) -- Ukuran diperkecil super sleek
    MainFrame.Position = UDim2.new(0.5, -240, 0.5, -150)
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
    
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Theme.Border
    MainStroke.Thickness = 1.2
    makeDraggable(MainFrame)

    -- TOPBAR
    local Topbar = Instance.new("Frame")
    Topbar.Size = UDim2.new(1, 0, 0, 38)
    Topbar.BackgroundTransparency = 1
    Topbar.Parent = MainFrame

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    TitleLabel.Position = UDim2.new(0, 14, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = titleText
    TitleLabel.TextColor3 = Theme.TextMain
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 14
    TitleLabel.Parent = Topbar

    -- ❌ LOGO CLOSE (Minimalis Bulat Kecil)
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Position = UDim2.new(1, -28, 0.5, -10)
    CloseButton.BackgroundColor3 = Color3.fromRGB(24, 24, 27)
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Theme.TextDark
    CloseButton.TextSize = 16
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = Topbar
    Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(1, 0)
    local CloseStroke = Instance.new("UIStroke", CloseButton)
    CloseStroke.Color = Theme.Border

    CloseButton.MouseEnter:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Accent}):Play()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    end)
    CloseButton.MouseLeave:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(24, 24, 27)}):Play()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {TextColor3 = Theme.TextDark}):Play()
    end)

    -- SIDEBAR BACKGROUND
    local SidebarBg = Instance.new("Frame")
    SidebarBg.Size = UDim2.new(0, 125, 1, -48)
    SidebarBg.Position = UDim2.new(0, 10, 0, 38)
    SidebarBg.BackgroundColor3 = Theme.Sidebar
    SidebarBg.Parent = MainFrame
    Instance.new("UICorner", SidebarBg).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", SidebarBg).Color = Theme.Border

    -- SIDEBAR SCROLLING
    local Sidebar = Instance.new("ScrollingFrame")
    Sidebar.Size = UDim2.new(1, -10, 1, -10)
    Sidebar.Position = UDim2.new(0, 5, 0, 5)
    Sidebar.BackgroundTransparency = 1
    Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
    Sidebar.ScrollBarThickness = 0
    Sidebar.Parent = SidebarBg

    local SidebarLayout = Instance.new("UIListLayout", Sidebar)
    SidebarLayout.Padding = UDim.new(0, 4)

    -- CONTAINER HOLDER (Tempat Konten Kanan)
    local ContainerHolder = Instance.new("Frame")
    ContainerHolder.Size = UDim2.new(1, -155, 1, -48)
    ContainerHolder.Position = UDim2.new(0, 145, 0, 38)
    ContainerHolder.BackgroundTransparency = 1
    ContainerHolder.Parent = MainFrame

    -- Logika Buka Tutup
    CloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        OpenButton.Visible = true
    end)

    OpenButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        OpenButton.Visible = false
    end)

    Window.Sidebar = Sidebar
    Window.ContainerHolder = ContainerHolder
    return Window
end

-- ==========================================
-- 2. SISTEM TAB (WAJIB ADA)
-- ==========================================
function UILibrary:CreateTab(name)
    local currentWindow = self
    local TabObj = setmetatable({}, Tab)
    
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 28)
    TabButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TabButton.BackgroundTransparency = 1
    TabButton.Text = name
    TabButton.TextColor3 = Theme.TextDark
    TabButton.Font = Enum.Font.GothamMedium
    TabButton.TextSize = 12
    TabButton.Parent = currentWindow.Sidebar
    Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 5)
    
    local TabStroke = Instance.new("UIStroke", TabButton)
    TabStroke.Color = Color3.fromRGB(0, 0, 0)
    TabStroke.Transparency = 1

    local TabPage = Instance.new("ScrollingFrame")
    TabPage.Size = UDim2.new(1, 0, 1, 0)
    TabPage.BackgroundTransparency = 1
    TabPage.Visible = false
    TabPage.ScrollBarThickness = 2
    TabPage.ScrollBarImageColor3 = Theme.Border
    TabPage.Parent = currentWindow.ContainerHolder

    local PageLayout = Instance.new("UIListLayout", TabPage)
    PageLayout.Padding = UDim.new(0, 5)
    Instance.new("UIPadding", TabPage).PaddingRight = UDim.new(0, 5) -- Agar scrollbar berjarak
    
    PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 5)
    end)

    local function activateTab()
        for _, v in pairs(currentWindow.ContainerHolder:GetChildren()) do
            if v:IsA("ScrollingFrame") then v.Visible = false end
        end
        for _, v in pairs(currentWindow.Sidebar:GetChildren()) do
            if v:IsA("TextButton") then 
                TweenService:Create(v, TweenInfo.new(0.15), {TextColor3 = Theme.TextDark}):Play()
                TweenService:Create(v, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
                v.UIStroke.Transparency = 1
            end
        end
        TabPage.Visible = true
        TweenService:Create(TabButton, TweenInfo.new(0.15), {TextColor3 = Theme.TextMain}):Play()
        TweenService:Create(TabButton, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Element}):Play()
        TweenService:Create(TabButton, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
        TabStroke.Color = Theme.Border
        TabStroke.Transparency = 0
    end

    TabButton.MouseButton1Click:Connect(activateTab)

    -- Hover effect untuk Tab
    TabButton.MouseEnter:Connect(function()
        if TabPage.Visible == false then
            TweenService:Create(TabButton, TweenInfo.new(0.15), {TextColor3 = Theme.TextMain}):Play()
        end
    end)
    TabButton.MouseLeave:Connect(function()
        if TabPage.Visible == false then
            TweenService:Create(TabButton, TweenInfo.new(0.15), {TextColor3 = Theme.TextDark}):Play()
        end
    end)

    if #currentWindow.Sidebar:GetChildren() == 2 then
        activateTab()
    end

    TabObj.Page = TabPage
    return TabObj
end

-- ==========================================
-- 3. KOMPONEN: TOGGLE (Premium Look)
-- ==========================================
function Tab:AddToggle(text, defaultState, callback)
    local state = defaultState or false

    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 36)
    ToggleFrame.BackgroundColor3 = Theme.Element
    ToggleFrame.Parent = self.Page
    Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 6)
    local ElementStroke = Instance.new("UIStroke", ToggleFrame)
    ElementStroke.Color = Theme.Border

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Theme.TextMain
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 12
    Label.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 30, 0, 16)
    ToggleBtn.Position = UDim2.new(1, -42, 0.5, -8)
    ToggleBtn.BackgroundColor3 = state and Theme.Accent or Color3.fromRGB(30, 30, 35)
    ToggleBtn.Text = ""
    ToggleBtn.Parent = ToggleFrame
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
    
    local InsideCircle = Instance.new("Frame", ToggleBtn)
    InsideCircle.Size = UDim2.new(0, 10, 0, 10)
    InsideCircle.Position = state and UDim2.new(1, -13, 0.5, -5) or UDim2.new(0, 3, 0.5, -5)
    InsideCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", InsideCircle).CornerRadius = UDim.new(1, 0)

    -- Hover effect frame toggle
    ToggleFrame.MouseEnter:Connect(function()
        TweenService:Create(ElementStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(45, 45, 50)}):Play()
    end)
    ToggleFrame.MouseLeave:Connect(function()
        TweenService:Create(ElementStroke, TweenInfo.new(0.2), {Color = Theme.Border}):Play()
    end)

    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(ToggleBtn, TweenInfo.new(0.18), {BackgroundColor3 = state and Theme.Accent or Color3.fromRGB(30, 30, 35)}):Play()
        TweenService:Create(InsideCircle, TweenInfo.new(0.15), {Position = state and UDim2.new(1, -13, 0.5, -5) or UDim2.new(0, 3, 0.5, -5)}):Play()
        if callback then callback(state) end
    end)
end

-- ==========================================
-- 4. KOMPONEN: BUTTON (Premium Look)
-- ==========================================
function Tab:AddButton(text, callback)
    local ButtonFrame = Instance.new("TextButton")
    ButtonFrame.Size = UDim2.new(1, 0, 0, 34)
    ButtonFrame.BackgroundColor3 = Theme.Element
    ButtonFrame.Text = text
    ButtonFrame.TextColor3 = Theme.TextMain
    ButtonFrame.Font = Enum.Font.GothamMedium
    ButtonFrame.TextSize = 12
    ButtonFrame.Parent = self.Page
    Instance.new("UICorner", ButtonFrame).CornerRadius = UDim.new(0, 6)
    
    local BtnStroke = Instance.new("UIStroke", ButtonFrame)
    BtnStroke.Color = Theme.Border

    -- Hover & Click effects
    ButtonFrame.MouseEnter:Connect(function()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Color = Theme.Accent}):Play()
    end)
    ButtonFrame.MouseLeave:Connect(function()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Color = Theme.Border}):Play()
    end)

    ButtonFrame.MouseButton1Click:Connect(function()
        local origColor = ButtonFrame.BackgroundColor3
        ButtonFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
        task.wait(0.08)
        ButtonFrame.BackgroundColor3 = origColor
        if callback then callback() end
    end)
end

return UILibrary
