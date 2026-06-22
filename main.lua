
local UILibrary = {}
UILibrary.__index = UILibrary

local Tab = {}
Tab.__index = Tab

-- Servis Roblox
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

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
            TweenService:Create(guiObject, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetPos}):Play()
        end
    end)
end

-- ==========================================
-- 1. UTAMA: MEMBUAT WINDOW (JENDELA UTAMA)
-- ==========================================
function UILibrary.CreateWindow(config)
    local Window = setmetatable({}, UILibrary)
    Window.Tabs = {}
    Window.CurrentTab = nil
    
    local titleText = config.Title or "Custom Hub"
    local logoId = config.Logo or "rbxassetid://0"
    
    -- ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CustomUILibrary"
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false
    Window.ScreenGui = ScreenGui

    -- 🔲 LOGO OPEN (Kotak & Bisa Digeser)
    local OpenButton = Instance.new("ImageButton")
    OpenButton.Name = "OpenLogo"
    OpenButton.Size = UDim2.new(0, 45, 0, 45)
    OpenButton.Position = UDim2.new(0.1, 0, 0.1, 0)
    OpenButton.Image = logoId
    OpenButton.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    OpenButton.Visible = false
    OpenButton.Parent = ScreenGui
    Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 8) -- Kotak Halus
    local OpenStroke = Instance.new("UIStroke", OpenButton)
    OpenStroke.Color = Color3.fromRGB(235, 45, 45)
    OpenStroke.Thickness = 1.5
    makeDraggable(OpenButton) -- Membuat logo bisa digeser

    -- ⚫ MAIN FRAME (Lebih Kecil & Modern)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 520, 0, 340) -- Diperkecil agar pas
    MainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
    MainFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
    MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Color3.fromRGB(235, 45, 45)
    MainStroke.Thickness = 1.5
    makeDraggable(MainFrame) -- Membuat jendela bisa digeser

    -- TOPBAR
    local Topbar = Instance.new("Frame")
    Topbar.Size = UDim2.new(1, 0, 0, 35)
    Topbar.BackgroundTransparency = 1
    Topbar.Parent = MainFrame

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    TitleLabel.Position = UDim2.new(0, 12, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = titleText
    TitleLabel.TextColor3 = Color3.fromRGB(235, 45, 45)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 15
    TitleLabel.Parent = Topbar

    -- ❌ CLOSE BUTTON
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 24, 0, 24)
    CloseButton.Position = UDim2.new(1, -32, 0.5, -12)
    CloseButton.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(235, 45, 45)
    CloseButton.TextSize = 20
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = Topbar
    Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", CloseButton).Color = Color3.fromRGB(40, 40, 40)

    -- SIDEBAR (Tempat List Tab)
    local Sidebar = Instance.new("ScrollingFrame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 130, 1, -45)
    Sidebar.Position = UDim2.new(0, 10, 0, 35)
    Sidebar.BackgroundTransparency = 1
    Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
    Sidebar.ScrollBarThickness = 0
    Sidebar.Parent = MainFrame

    local SidebarLayout = Instance.new("UIListLayout", Sidebar)
    SidebarLayout.Padding = UDim.new(0, 5)

    -- CONTAINER UTAMA (Tempat Isi Konten)
    local ContainerHolder = Instance.new("Frame")
    ContainerHolder.Name = "ContainerHolder"
    ContainerHolder.Size = UDim2.new(1, -160, 1, -45)
    ContainerHolder.Position = UDim2.new(0, 150, 0, 35)
    ContainerHolder.BackgroundTransparency = 1
    ContainerHolder.Parent = MainFrame

    -- Interaksi Buka / Tutup
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
    
    -- Membuat Tombol Tab di Sidebar
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "Tab"
    TabButton.Size = UDim2.new(1, 0, 0, 32)
    TabButton.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(150, 150, 150)
    TabButton.Font = Enum.Font.GothamMedium
    TabButton.TextSize = 13
    TabButton.Parent = currentWindow.Sidebar
    Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 6)
    local TabStroke = Instance.new("UIStroke", TabButton)
    TabStroke.Color = Color3.fromRGB(28, 28, 28)

    -- ScollFrame Konten Khusus Tab ini
    local TabPage = Instance.new("ScrollingFrame")
    TabPage.Name = name .. "Page"
    TabPage.Size = UDim2.new(1, 0, 1, 0)
    TabPage.BackgroundTransparency = 1
    TabPage.Visible = false
    TabPage.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabPage.ScrollBarThickness = 2
    TabPage.ScrollBarImageColor3 = Color3.fromRGB(235, 45, 45)
    TabPage.Parent = currentWindow.ContainerHolder

    local PageLayout = Instance.new("UIListLayout", TabPage)
    PageLayout.Padding = UDim.new(0, 6)
    
    -- Auto adjust tinggi canvas scroll agar tidak terpotong
    PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
    end)

    -- Fungsi Klik Ganti Tab
    local function activateTab()
        for _, v in pairs(currentWindow.ContainerHolder:GetChildren()) do
            if v:IsA("ScrollingFrame") then v.Visible = false end
        end
        for _, v in pairs(currentWindow.Sidebar:GetChildren()) do
            if v:IsA("TextButton") then 
                v.TextColor3 = Color3.fromRGB(150, 150, 150)
                v.UIStroke.Color = Color3.fromRGB(28, 28, 28)
            end
        end
        TabPage.Visible = true
        TabButton.TextColor3 = Color3.fromRGB(235, 45, 45)
        TabStroke.Color = Color3.fromRGB(235, 45, 45)
    end

    TabButton.MouseButton1Click:Connect(activateTab)

    -- Aktifkan otomatis jika ini tab pertama
    if #currentWindow.Sidebar:GetChildren() == 2 then -- 2 karena ada UIListLayout di dalamnya
        activateTab()
    end

    TabObj.Page = TabPage
    return TabObj
end

-- ==========================================
-- 3. KOMPONEN: TOGGLE (Dimasukkan ke Tab)
-- ==========================================
function Tab:AddToggle(text, defaultState, callback)
    local state = defaultState or false

    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -8, 0, 38)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    ToggleFrame.Parent = self.Page
    Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 6)
    local ElementStroke = Instance.new("UIStroke", ToggleFrame)
    ElementStroke.Color = Color3.fromRGB(28, 28, 28)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 34, 0, 18)
    ToggleBtn.Position = UDim2.new(1, -44, 0.5, -9)
    ToggleBtn.BackgroundColor3 = state and Color3.fromRGB(235, 45, 45) or Color3.fromRGB(45, 45, 45)
    ToggleBtn.Text = ""
    ToggleBtn.Parent = ToggleFrame
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
    
    local InsideCircle = Instance.new("Frame", ToggleBtn)
    InsideCircle.Size = UDim2.new(0, 12, 0, 12)
    InsideCircle.Position = state and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)
    InsideCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", InsideCircle).CornerRadius = UDim.new(1, 0)

    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        
        -- Efek Animasi perpindahan warna & posisi toggle (Fresh!)
        TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = state and Color3.fromRGB(235, 45, 45) or Color3.fromRGB(45, 45, 45)}):Play()
        TweenService:Create(InsideCircle, TweenInfo.new(0.15), {Position = state and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)}):Play()
        
        if callback then callback(state) end
    end)
end

-- ==========================================
-- 4. KOMPONEN BONUS: BUTTON (Dimasukkan ke Tab)
-- ==========================================
function Tab:AddButton(text, callback)
    local ButtonFrame = Instance.new("TextButton")
    ButtonFrame.Size = UDim2.new(1, -8, 0, 36)
    ButtonFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    ButtonFrame.Text = text
    ButtonFrame.TextColor3 = Color3.fromRGB(220, 220, 220)
    ButtonFrame.Font = Enum.Font.GothamMedium
    ButtonFrame.TextSize = 13
    ButtonFrame.Parent = self.Page
    Instance.new("UICorner", ButtonFrame).CornerRadius = UDim.new(0, 6)
    
    local BtnStroke = Instance.new("UIStroke", ButtonFrame)
    BtnStroke.Color = Color3.fromRGB(28, 28, 28)

    ButtonFrame.MouseButton1Click:Connect(function()
        -- Efek Flash klik modern
        ButtonFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        task.wait(0.1)
        ButtonFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        if callback then callback() end
    end)
end

return UILibrary
