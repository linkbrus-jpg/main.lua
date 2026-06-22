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
-- SISTEM NOTIFIKASI POP-UP
-- ==========================================
function UILibrary:Notification(title, text, duration)
    duration = duration or 4
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    local NotifGui = PlayerGui:FindFirstChild("PremiumUILibrary_Notif")
    
    if not NotifGui then
        NotifGui = Instance.new("ScreenGui")
        NotifGui.Name = "PremiumUILibrary_Notif"
        NotifGui.ResetOnSpawn = false
        NotifGui.Parent = PlayerGui
        
        local Holder = Instance.new("Frame")
        Holder.Name = "Holder"
        Holder.Size = UDim2.new(0, 280, 1, -40)
        Holder.Position = UDim2.new(1, -290, 0, 20)
        Holder.BackgroundTransparency = 1
        Holder.Parent = NotifGui
        
        local Layout = Instance.new("UIListLayout", Holder)
        Layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
        Layout.SortOrder = Enum.SortOrder.LayoutOrder
        Layout.Padding = UDim.new(0, 8)
    end
    
    local Holder = NotifGui.Holder
    
    -- Base Frame transparan untuk menjaga layout posisi tetap aman saat animasi
    local BaseFrame = Instance.new("Frame")
    BaseFrame.Size = UDim2.new(1, 0, 0, 65)
    BaseFrame.BackgroundTransparency = 1
    BaseFrame.Parent = Holder
    
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Size = UDim2.new(1, 0, 1, 0)
    NotifFrame.Position = UDim2.new(1.3, 0, 0, 0) -- Mulai dari luar layar sebelah kanan
    NotifFrame.BackgroundColor3 = Theme.Sidebar
    NotifFrame.Parent = BaseFrame
    
    Instance.new("UICorner", NotifFrame).CornerRadius = UDim.new(0, 6)
    local Stroke = Instance.new("UIStroke", NotifFrame)
    Stroke.Color = Theme.Border
    
    -- Garis Aksen Kiri (Neon)
    local AccentBar = Instance.new("Frame")
    AccentBar.Size = UDim2.new(0, 4, 1, 0)
    AccentBar.BackgroundColor3 = Theme.Accent
    AccentBar.Parent = NotifFrame
    Instance.new("UICorner", AccentBar).CornerRadius = UDim.new(0, 6)
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -24, 0, 20)
    TitleLabel.Position = UDim2.new(0, 14, 0, 6)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title or "Notification"
    TitleLabel.TextColor3 = Theme.TextMain
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 12
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = NotifFrame
    
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -24, 1, -30)
    TextLabel.Position = UDim2.new(0, 14, 0, 26)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = text or ""
    TextLabel.TextColor3 = Theme.TextDark
    TextLabel.Font = Enum.Font.Gotham
    TextLabel.TextSize = 11
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextYAlignment = Enum.TextYAlignment.Top
    TextLabel.TextWrapped = true
    TextLabel.Parent = NotifFrame
    
    -- Animasi Masuk (Slide In)
    TweenService:Create(NotifFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
    
    -- Animasi Keluar dan Hancurkan
    task.delay(duration, function()
        local tweenOut = TweenService:Create(NotifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1.3, 0, 0, 0)})
        TweenService:Create(Stroke, TweenInfo.new(0.2), {Transparency = 1}):Play()
        TweenService:Create(AccentBar, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        TweenService:Create(TitleLabel, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        TweenService:Create(TextLabel, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        
        tweenOut:Play()
        tweenOut.Completed:Connect(function()
            BaseFrame:Destroy()
        end)
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
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PremiumUILibrary"
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false
    Window.ScreenGui = ScreenGui

    -- LOGO OPEN
    local OpenButton = Instance.new("ImageButton")
    OpenButton.Size = UDim2.new(0, 40, 0, 40)
    OpenButton.Position = UDim2.new(0.05, 0, 0.05, 0)
    OpenButton.Image = logoId
    OpenButton.BackgroundColor3 = Theme.Sidebar
    OpenButton.Visible = false
    OpenButton.Parent = ScreenGui
    Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 8)
    local OpenStroke = Instance.new("UIStroke", OpenButton)
    OpenStroke.Color = Theme.Border
    makeDraggable(OpenButton)

    OpenButton.MouseEnter:Connect(function() TweenService:Create(OpenStroke, TweenInfo.new(0.2), {Color = Theme.Accent}):Play() end)
    OpenButton.MouseLeave:Connect(function() TweenService:Create(OpenStroke, TweenInfo.new(0.2), {Color = Theme.Border}):Play() end)

    -- MAIN FRAME
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 500, 0, 320)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -160)
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", MainFrame).Color = Theme.Border
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

    -- CLOSE BUTTON
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
    Instance.new("UIStroke", CloseButton).Color = Theme.Border

    CloseButton.MouseEnter:Connect(function() TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Accent, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play() end)
    CloseButton.MouseLeave:Connect(function() TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(24, 24, 27), TextColor3 = Theme.TextDark}):Play() end)

    -- SIDEBAR
    local SidebarBg = Instance.new("Frame")
    SidebarBg.Size = UDim2.new(0, 130, 1, -48)
    SidebarBg.Position = UDim2.new(0, 10, 0, 38)
    SidebarBg.BackgroundColor3 = Theme.Sidebar
    SidebarBg.Parent = MainFrame
    Instance.new("UICorner", SidebarBg).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", SidebarBg).Color = Theme.Border

    local Sidebar = Instance.new("ScrollingFrame")
    Sidebar.Size = UDim2.new(1, -10, 1, -10)
    Sidebar.Position = UDim2.new(0, 5, 0, 5)
    Sidebar.BackgroundTransparency = 1
    Sidebar.ScrollBarThickness = 0
    Sidebar.Parent = SidebarBg
    local SidebarLayout = Instance.new("UIListLayout", Sidebar)
    SidebarLayout.Padding = UDim.new(0, 4)

    -- CONTAINER HOLDER
    local ContainerHolder = Instance.new("Frame")
    ContainerHolder.Size = UDim2.new(1, -160, 1, -48)
    ContainerHolder.Position = UDim2.new(0, 150, 0, 38)
    ContainerHolder.BackgroundTransparency = 1
    ContainerHolder.Parent = MainFrame

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
-- 2. SISTEM TAB 
-- ==========================================
function UILibrary:CreateTab(name, iconId)
    local currentWindow = self
    local TabObj = setmetatable({}, Tab)
    
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 28)
    TabButton.BackgroundColor3 = Theme.Element
    TabButton.BackgroundTransparency = 1
    TabButton.Text = name
    TabButton.TextColor3 = Theme.TextDark
    TabButton.Font = Enum.Font.GothamMedium
    TabButton.TextSize = 12
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    TabButton.Parent = currentWindow.Sidebar
    Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 5)
    local TabStroke = Instance.new("UIStroke", TabButton)
    TabStroke.Color = Theme.Border
    TabStroke.Transparency = 1

    local Padding = Instance.new("UIPadding", TabButton)
    Padding.PaddingLeft = UDim.new(0, iconId and 28 or 10)

    local TabIcon
    if iconId then
        TabIcon = Instance.new("ImageLabel")
        TabIcon.Size = UDim2.new(0, 14, 0, 14)
        TabIcon.Position = UDim2.new(0, -20, 0.5, -7)
        TabIcon.BackgroundTransparency = 1
        TabIcon.Image = iconId
        TabIcon.ImageColor3 = Theme.TextDark
        TabIcon.Parent = TabButton
    end

    local TabPage = Instance.new("ScrollingFrame")
    TabPage.Size = UDim2.new(1, 0, 1, 0)
    TabPage.BackgroundTransparency = 1
    TabPage.Visible = false
    TabPage.ScrollBarThickness = 2
    TabPage.ScrollBarImageColor3 = Theme.Border
    TabPage.Parent = currentWindow.ContainerHolder

    local PageLayout = Instance.new("UIListLayout", TabPage)
    PageLayout.Padding = UDim.new(0, 5)
    Instance.new("UIPadding", TabPage).PaddingRight = UDim.new(0, 5)
    
    PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 5)
    end)

    local function activateTab()
        for _, v in pairs(currentWindow.ContainerHolder:GetChildren()) do
            if v:IsA("ScrollingFrame") then v.Visible = false end
        end
        for _, v in pairs(currentWindow.Sidebar:GetChildren()) do
            if v:IsA("TextButton") then 
                TweenService:Create(v, TweenInfo.new(0.15), {TextColor3 = Theme.TextDark, BackgroundTransparency = 1}):Play()
                v.UIStroke.Transparency = 1
                if v:FindFirstChild("ImageLabel") then TweenService:Create(v.ImageLabel, TweenInfo.new(0.15), {ImageColor3 = Theme.TextDark}):Play() end
            end
        end
        TabPage.Visible = true
        TweenService:Create(TabButton, TweenInfo.new(0.15), {TextColor3 = Theme.TextMain, BackgroundTransparency = 0}):Play()
        TabStroke.Transparency = 0
        if TabIcon then TweenService:Create(TabIcon, TweenInfo.new(0.15), {ImageColor3 = Theme.Accent}):Play() end
    end

    TabButton.MouseButton1Click:Connect(activateTab)
    if #currentWindow.Sidebar:GetChildren() == 2 then activateTab() end

    TabObj.Page = TabPage
    return TabObj
end

-- ==========================================
-- 3. KOMPONEN: STATION (CONTAINER WRAPPER) & SECTION
-- ==========================================
function Tab:AddStation(title)
    local StationFrame = Instance.new("Frame")
    StationFrame.Size = UDim2.new(1, 0, 0, 0)
    StationFrame.AutomaticSize = Enum.AutomaticSize.Y
    StationFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 17) -- Kontras warna sedikit lebih terang dari bg utama
    StationFrame.Parent = self.Page
    Instance.new("UICorner", StationFrame).CornerRadius = UDim.new(0, 6)
    local StationStroke = Instance.new("UIStroke", StationFrame)
    StationStroke.Color = Theme.Border

    local StationLayout = Instance.new("UIListLayout", StationFrame)
    StationLayout.Padding = UDim.new(0, 5)
    StationLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local StationPadding = Instance.new("UIPadding", StationFrame)
    StationPadding.PaddingTop = UDim.new(0, 8)
    StationPadding.PaddingBottom = UDim.new(0, 8)
    StationPadding.PaddingLeft = UDim.new(0, 8)
    StationPadding.PaddingRight = UDim.new(0, 8)

    if title then
        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.Size = UDim2.new(1, 0, 0, 18)
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Text = title:upper()
        TitleLabel.TextColor3 = Theme.Accent
        TitleLabel.Font = Enum.Font.GothamBold
        TitleLabel.TextSize = 10
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        TitleLabel.Parent = StationFrame
    end

    -- Inject metatable redirection agar Station bertingkah seperti Tab (mendukung semua komponen di bawah)
    local StationObj = setmetatable({}, { __index = self })
    StationObj.Page = StationFrame -- Mengalihkan tujuan pembuatan objek ke dalam frame Station ini
    
    return StationObj
end

function Tab:AddSection(text)
    local SectionFrame = Instance.new("Frame")
    SectionFrame.Size = UDim2.new(1, 0, 0, 24)
    SectionFrame.BackgroundTransparency = 1
    SectionFrame.Parent = self.Page

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -5, 1, 0)
    Label.Position = UDim2.new(0, 5, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Theme.Accent
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 13
    Label.Parent = SectionFrame
end

function Tab:AddParagraph(title, text)
    local ParaFrame = Instance.new("Frame")
    ParaFrame.Size = UDim2.new(1, 0, 0, 58)
    ParaFrame.BackgroundColor3 = Theme.Element
    ParaFrame.Parent = self.Page
    Instance.new("UICorner", ParaFrame).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", ParaFrame).Color = Theme.Border

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -24, 0, 20)
    TitleLabel.Position = UDim2.new(0, 12, 0, 6)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Theme.TextMain
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.GothamMedium
    TitleLabel.TextSize = 12
    TitleLabel.Parent = ParaFrame

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -24, 1, -30)
    TextLabel.Position = UDim2.new(0, 12, 0, 26)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = text
    TextLabel.TextColor3 = Theme.TextDark
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextYAlignment = Enum.TextYAlignment.Top
    TextLabel.Font = Enum.Font.Gotham
    TextLabel.TextSize = 11
    TextLabel.TextWrapped = true
    TextLabel.Parent = ParaFrame
end

-- ==========================================
-- 4. KOMPONEN: INPUT (TextBox)
-- ==========================================
function Tab:AddInput(text, placeholder, callback)
    local InputFrame = Instance.new("Frame")
    InputFrame.Size = UDim2.new(1, 0, 0, 36)
    InputFrame.BackgroundColor3 = Theme.Element
    InputFrame.Parent = self.Page
    Instance.new("UICorner", InputFrame).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", InputFrame).Color = Theme.Border

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.5, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Theme.TextMain
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 12
    Label.Parent = InputFrame

    local TextBoxBg = Instance.new("Frame")
    TextBoxBg.Size = UDim2.new(0.4, 0, 0, 24)
    TextBoxBg.Position = UDim2.new(0.6, -12, 0.5, -12)
    TextBoxBg.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
    TextBoxBg.Parent = InputFrame
    Instance.new("UICorner", TextBoxBg).CornerRadius = UDim.new(0, 4)
    local BoxStroke = Instance.new("UIStroke", TextBoxBg)
    BoxStroke.Color = Theme.Border

    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(1, -10, 1, 0)
    TextBox.Position = UDim2.new(0, 5, 0, 0)
    TextBox.BackgroundTransparency = 1
    TextBox.Text = ""
    TextBox.PlaceholderText = placeholder or "Tulis disini..."
    TextBox.TextColor3 = Theme.TextMain
    TextBox.PlaceholderColor3 = Theme.TextDark
    TextBox.Font = Enum.Font.Gotham
    TextBox.TextSize = 11
    TextBox.TextXAlignment = Enum.TextXAlignment.Left
    TextBox.ClearTextOnFocus = false
    TextBox.Parent = TextBoxBg

    TextBox.Focused:Connect(function() TweenService:Create(BoxStroke, TweenInfo.new(0.2), {Color = Theme.Accent}):Play() end)
    TextBox.FocusLost:Connect(function()
        TweenService:Create(BoxStroke, TweenInfo.new(0.2), {Color = Theme.Border}):Play()
        if callback then callback(TextBox.Text) end
    end)
end

-- ==========================================
-- 5. KOMPONEN: SLIDER
-- ==========================================
function Tab:AddSlider(text, min, max, default, callback)
    local SliderValue = math.clamp(default or min, min, max)

    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 46)
    SliderFrame.BackgroundColor3 = Theme.Element
    SliderFrame.Parent = self.Page
    Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", SliderFrame).Color = Theme.Border

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 0, 20)
    Label.Position = UDim2.new(0, 12, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Theme.TextMain
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 12
    Label.Parent = SliderFrame

    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.3, 0, 0, 20)
    ValueLabel.Position = UDim2.new(0.7, -12, 0, 5)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(SliderValue)
    ValueLabel.TextColor3 = Theme.TextDark
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.Font = Enum.Font.Gotham
    ValueLabel.TextSize = 11
    ValueLabel.Parent = SliderFrame

    local TrackBg = Instance.new("Frame")
    TrackBg.Size = UDim2.new(1, -24, 0, 6)
    TrackBg.Position = UDim2.new(0, 12, 0, 30)
    TrackBg.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
    TrackBg.Parent = SliderFrame
    Instance.new("UICorner", TrackBg).CornerRadius = UDim.new(1, 0)

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((SliderValue - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Theme.Accent
    Fill.Parent = TrackBg
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

    local SliderBtn = Instance.new("TextButton")
    SliderBtn.Size = UDim2.new(1, 0, 1, 0)
    SliderBtn.BackgroundTransparency = 1
    SliderBtn.Text = ""
    SliderBtn.Parent = TrackBg

    local dragging = false
    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - TrackBg.AbsolutePosition.X) / TrackBg.AbsoluteSize.X, 0, 1)
        SliderValue = math.floor(min + ((max - min) * pos))
        ValueLabel.Text = tostring(SliderValue)
        TweenService:Create(Fill, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.new(pos, 0, 1, 0)}):Play()
        if callback then callback(SliderValue) end
    end

    SliderBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)
end

-- ==========================================
-- 6. KOMPONEN: KEYBIND
-- ==========================================
function Tab:AddKeybind(text, defaultKey, callback)
    local key = defaultKey or Enum.KeyCode.Unknown
    local isBinding = false

    local KeybindFrame = Instance.new("Frame")
    KeybindFrame.Size = UDim2.new(1, 0, 0, 36)
    KeybindFrame.BackgroundColor3 = Theme.Element
    KeybindFrame.Parent = self.Page
    Instance.new("UICorner", KeybindFrame).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", KeybindFrame).Color = Theme.Border

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Theme.TextMain
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 12
    Label.Parent = KeybindFrame

    local KeyBtnBg = Instance.new("Frame")
    KeyBtnBg.Size = UDim2.new(0, 65, 0, 22)
    KeyBtnBg.Position = UDim2.new(1, -77, 0.5, -11)
    KeyBtnBg.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    KeyBtnBg.Parent = KeybindFrame
    Instance.new("UICorner", KeyBtnBg).CornerRadius = UDim.new(0, 4)
    local KeyStroke = Instance.new("UIStroke", KeyBtnBg)
    KeyStroke.Color = Theme.Border

    local KeyBtn = Instance.new("TextButton")
    KeyBtn.Size = UDim2.new(1, 0, 1, 0)
    KeyBtn.BackgroundTransparency = 1
    KeyBtn.Text = key == Enum.KeyCode.Unknown and "None" or key.Name
    KeyBtn.TextColor3 = Theme.TextMain
    KeyBtn.Font = Enum.Font.GothamMedium
    KeyBtn.TextSize = 11
    KeyBtn.Parent = KeyBtnBg

    KeyBtn.MouseButton1Click:Connect(function()
        isBinding = true
        KeyBtn.Text = "..."
        KeyStroke.Color = Theme.Accent
    end)

    UserInputService.InputBegan:Connect(function(input, processed)
        if not isBinding and input.KeyCode == key and key ~= Enum.KeyCode.Unknown and not processed then
            if callback then callback() end
        end

        if isBinding and input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.Backspace then
                key = Enum.KeyCode.Unknown
                KeyBtn.Text = "None"
            else
                key = input.KeyCode
                KeyBtn.Text = key.Name
            end
            isBinding = false
            KeyStroke.Color = Theme.Border
        end
    end)
end

-- ==========================================
-- 7. KOMPONEN: DROPDOWN & TOGGLE & BUTTON
-- ==========================================
function Tab:AddDropdown(text, options, defaultOption, callback)
    local isDropped = false
    local selected = defaultOption or options[1] or "Select..."
    
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Size = UDim2.new(1, 0, 0, 36)
    DropdownFrame.BackgroundColor3 = Theme.Element
    DropdownFrame.ClipsDescendants = true
    DropdownFrame.Parent = self.Page
    Instance.new("UICorner", DropdownFrame).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", DropdownFrame).Color = Theme.Border

    local HeaderBtn = Instance.new("TextButton")
    HeaderBtn.Size = UDim2.new(1, 0, 0, 36)
    HeaderBtn.BackgroundTransparency = 1
    HeaderBtn.Text = ""
    HeaderBtn.Parent = DropdownFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0.5, 0, 1, 0)
    Title.Position = UDim2.new(0, 12, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = text
    Title.TextColor3 = Theme.TextMain
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Font = Enum.Font.GothamMedium
    Title.TextSize = 12
    Title.Parent = HeaderBtn

    local SelectedText = Instance.new("TextLabel")
    SelectedText.Size = UDim2.new(0.4, 0, 1, 0)
    SelectedText.Position = UDim2.new(0.6, -25, 0, 0)
    SelectedText.BackgroundTransparency = 1
    SelectedText.Text = selected
    SelectedText.TextColor3 = Theme.TextDark
    SelectedText.TextXAlignment = Enum.TextXAlignment.Right
    SelectedText.Font = Enum.Font.Gotham
    SelectedText.TextSize = 11
    SelectedText.Parent = HeaderBtn

    local Arrow = Instance.new("ImageLabel")
    Arrow.Size = UDim2.new(0, 14, 0, 14)
    Arrow.Position = UDim2.new(1, -20, 0.5, -7)
    Arrow.BackgroundTransparency = 1
    Arrow.Image = "rbxassetid://6031090390"
    Arrow.ImageColor3 = Theme.TextDark
    Arrow.Parent = HeaderBtn

    local DropContainer = Instance.new("ScrollingFrame")
    DropContainer.Size = UDim2.new(1, -10, 1, -40)
    DropContainer.Position = UDim2.new(0, 5, 0, 38)
    DropContainer.BackgroundTransparency = 1
    DropContainer.ScrollBarThickness = 1
    DropContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    DropContainer.Parent = DropdownFrame
    local DropLayout = Instance.new("UIListLayout", DropContainer)
    DropLayout.Padding = UDim.new(0, 2)

    for _, opt in ipairs(options) do
        local OptBtn = Instance.new("TextButton")
        OptBtn.Size = UDim2.new(1, 0, 0, 26)
        OptBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
        OptBtn.Text = opt
        OptBtn.TextColor3 = Theme.TextDark
        OptBtn.Font = Enum.Font.Gotham
        OptBtn.TextSize = 11
        OptBtn.Parent = DropContainer
        Instance.new("UICorner", OptBtn).CornerRadius = UDim.new(0, 4)

        OptBtn.MouseEnter:Connect(function() TweenService:Create(OptBtn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Border, TextColor3 = Theme.TextMain}):Play() end)
        OptBtn.MouseLeave:Connect(function() TweenService:Create(OptBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(24, 24, 28), TextColor3 = Theme.TextDark}):Play() end)

        OptBtn.MouseButton1Click:Connect(function()
            selected = opt
            SelectedText.Text = selected
            isDropped = false
            TweenService:Create(DropdownFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {Size = UDim2.new(1, 0, 0, 36)}):Play()
            TweenService:Create(Arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
            if callback then callback(selected) end
        end)
    end
    
    DropLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        DropContainer.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y)
    end)

    HeaderBtn.MouseButton1Click:Connect(function()
        isDropped = not isDropped
        local targetHeight = isDropped and (38 + math.min(#options * 28, 120)) or 36
        TweenService:Create(DropdownFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {Size = UDim2.new(1, 0, 0, targetHeight)}):Play()
        TweenService:Create(Arrow, TweenInfo.new(0.2), {Rotation = isDropped and 180 or 0}):Play()
    end)
end

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

    [[ ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(ToggleBtn, TweenInfo.new(0.18), {BackgroundColor3 = state and Theme.Accent or Color3.fromRGB(30, 30, 35)}):Play()
        TweenService:Create(InsideCircle, TweenInfo.new(0.15), {Position = state and UDim2.new(1, -13, 0.5, -5) or UDim2.new(0, 3, 0.5, -5)}):Play()
        if callback then callback(state) end
    end) ]]
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(ToggleBtn, TweenInfo.new(0.18), {BackgroundColor3 = state and Theme.Accent or Color3.fromRGB(30, 30, 35)}):Play()
        TweenService:Create(InsideCircle, TweenInfo.new(0.15), {Position = state and UDim2.new(1, -13, 0.5, -5) or UDim2.new(0, 3, 0.5, -5)}):Play()
        if callback then callback(state) end
    end)
end

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

    ButtonFrame.MouseEnter:Connect(function() TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Color = Theme.Accent}):Play() end)
    ButtonFrame.MouseLeave:Connect(function() TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Color = Theme.Border}):Play() end)
    
    ButtonFrame.MouseButton1Click:Connect(function()
        local origColor = ButtonFrame.BackgroundColor3
        ButtonFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
        task.wait(0.08)
        ButtonFrame.BackgroundColor3 = origColor
        if callback then callback() end
    end)
end

return UILibrary
