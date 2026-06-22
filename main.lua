local UILibrary = {}
UILibrary.__index = UILibrary

-- Servis bawaan Roblox
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

-- ==========================================
-- 1. FUNGSI MEMBUAT WINDOW UTAMA
-- ==========================================
function UILibrary.CreateWindow(config)
    local Window = setmetatable({}, UILibrary)
    
    local titleText = config.Title or "Custom Hub"
    local logoId = config.Logo or "rbxassetid://0" -- Ganti dengan ID gambar logo kamu
    
    -- Membuat ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MyCustomUI"
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui") -- Pakai CoreGui jika exploit
    ScreenGui.ResetOnSpawn = false

    -- 🔴 TOMBOL LOGO (Untuk Membuka UI)
    local OpenButton = Instance.new("ImageButton")
    OpenButton.Name = "OpenLogo"
    OpenButton.Size = UDim2.new(0, 50, 0, 50)
    OpenButton.Position = UDim2.new(0.5, -25, 0, 10) -- Di tengah atas layar
    OpenButton.Image = logoId
    OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    OpenButton.Visible = false -- Disembunyikan saat UI utama terbuka
    OpenButton.Parent = ScreenGui
    
    local LogoCorner = Instance.new("UICorner", OpenButton)
    LogoCorner.CornerRadius = UDim.new(1, 0) -- Membuatnya bulat

    -- ⚫ MAIN FRAME (Jendela Utama)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Warna Dark
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner", MainFrame)
    MainCorner.CornerRadius = UDim.new(0, 8)
    
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Color3.fromRGB(255, 50, 50) -- Aksen Merah pinggiran
    MainStroke.Thickness = 2

    -- TOPBAR
    local Topbar = Instance.new("Frame")
    Topbar.Size = UDim2.new(1, 0, 0, 40)
    Topbar.BackgroundTransparency = 1
    Topbar.Parent = MainFrame

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0.8, 0, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = titleText
    TitleLabel.TextColor3 = Color3.fromRGB(255, 50, 50) -- Teks Merah
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 18
    TitleLabel.Parent = Topbar

    -- ❌ TOMBOL CLOSE
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -40, 0, 5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = Topbar
    Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 6)

    -- CONTAINER (Tempat menaruh isi tab)
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -150, 1, -50)
    ContentContainer.Position = UDim2.new(0, 140, 0, 40)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame

    -- LOGIKA OPEN / CLOSE
    CloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        OpenButton.Visible = true
    end)

    OpenButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        OpenButton.Visible = false
    end)

    -- Simpan data di dalam objek Window
    Window.Container = ContentContainer
    Window.CurrentY = 0 -- Untuk menyusun item ke bawah
    
    return Window
end

-- ==========================================
-- 2. FUNGSI MEMBUAT KOMPONEN (TOGGLE)
-- ==========================================
function UILibrary:AddToggle(text, defaultState, callback)
    local state = defaultState or false

    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -20, 0, 40)
    ToggleFrame.Position = UDim2.new(0, 10, 0, self.CurrentY)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleFrame.Parent = self.Container
    Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 40, 0, 20)
    ToggleBtn.Position = UDim2.new(1, -50, 0.5, -10)
    ToggleBtn.BackgroundColor3 = state and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(60, 60, 60)
    ToggleBtn.Text = ""
    ToggleBtn.Parent = ToggleFrame
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

    -- Logika Klik Toggle
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        -- Ubah warna pakai tween agar halus (opsional, di sini pakai cara instan)
        ToggleBtn.BackgroundColor3 = state and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(60, 60, 60)
        
        if callback then
            callback(state)
        end
    end)

    -- Update posisi Y untuk item berikutnya
    self.CurrentY = self.CurrentY + 45
end

return UILibrary
