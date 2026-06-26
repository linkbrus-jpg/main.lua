-- ====================================================================
-- LOAD SERVICES LEBIH AWAL
-- ====================================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ====================================================================
-- HAPUS PART FISIK & PAKSA JEMBATAN SOLID PERMANEN
-- ====================================================================
task.spawn(function()
    -- 1. Hapus Dinding CorridorTrap di 'NPC & Piege'
    pcall(function()
        local npcPiege = workspace:FindFirstChild("NPC & Piege")
        if npcPiege and npcPiege:FindFirstChild("CorridorTrap") then
            local wallL = npcPiege.CorridorTrap:FindFirstChild("WallL")
            if wallL then wallL:Destroy() warn("[CLEANER] WallL di 'NPC & Piege' berhasil dihancurkan!") end
            local wallR = npcPiege.CorridorTrap:FindFirstChild("WallR")
            if wallR then wallR:Destroy() warn("[CLEANER] WallR di 'NPC & Piege' berhasil dihancurkan!") end
        end
    end)

    -- 2. Hapus Dinding CorridorTrap di 'NPC & 2Piege'
    pcall(function()
        local npcPiege2 = workspace:FindFirstChild("NPC & 2Piege")
        if npcPiege2 and npcPiege2:FindFirstChild("CorridorTrap") then
            local wallR = npcPiege2.CorridorTrap:FindFirstChild("WallR")
            if wallR then wallR:Destroy() warn("[CLEANER] WallR di 'NPC & 2Piege' berhasil dihancurkan!") end
            local wallL = npcPiege2.CorridorTrap:FindFirstChild("WallL")
            if wallL then wallL:Destroy() warn("[CLEANER] WallL di 'NPC & 2Piege' berhasil dihancurkan!") end
        end
    end)

    -- 3. Hapus Objek Tsunami Secara Fisik
    pcall(function()
        local npcPiege = workspace:FindFirstChild("NPC & Piege")
        local tsunami1 = npcPiege and npcPiege:FindFirstChild("Tsunami1")
        if tsunami1 then
            tsunami1:Destroy()
            warn("[CLEANER] Objek Tsunami1 berhasil dihancurkan secara total!")
        end
    end)

    -- 4. Hapus LavaPart di LavaTower Secara Fisik
    pcall(function()
        local npcPiege = workspace:FindFirstChild("NPC & Piege")
        local lavaTower = npcPiege and npcPiege:FindFirstChild("LavaTower")
        local lavaPart = lavaTower and lavaTower:FindFirstChild("LavaPart")
        if lavaPart then
            lavaPart:Destroy()
            warn("[CLEANER] LavaPart di LavaTower berhasil dihancurkan secara total!")
        end
    end)

    -- 5. PAKSA STUD PART (JEMBATAN) MUNCUL & SOLID TERUS-MENERUS
    pcall(function()
        RunService.Heartbeat:Connect(function()
            local keycaps = workspace:FindFirstChild("Keycaps")
            local bridgeContainer = keycaps and keycaps:FindFirstChild("Bridge")
            local bridge1 = bridgeContainer and bridgeContainer:FindFirstChild("Bridge1")
            local bridgePart = bridge1 and bridge1:FindFirstChild("Stud Part")
            
            if bridgePart and bridgePart:IsA("BasePart") then
                bridgePart.Transparency = 0 
                bridgePart.CanCollide = true 
            end
        end)
        warn("[ANTI-FALL] Jembatan 'Stud Part' sekarang terkunci solid permanen!")
    end)
end)

-- ====================================================================
-- LOAD UI HUB
-- ====================================================================
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local isRunning = false
local currentTask = nil
local selectedRoute = "Pilihan 1" 
local lastLog = 0 

-- ====================================================================
-- DATARAN RUTE & KOORDINAT
-- ====================================================================
local routes = {
    ["Pilihan 1"] = {
        Vector3.new(0.6, 7.5, 270.9),
        Vector3.new(-16.8, 7.9, 285.7)
    },
    ["Pilihan 2"] = {
        Vector3.new(0.6, 7.5, 270.9),
        Vector3.new(53.4, 8.2, 398.2),
        Vector3.new(13.1, 7.5, 487.3),
        Vector3.new(-16.1, 7.9, 505.3),
    },
    ["Pilihan 3"] = {
        Vector3.new(0.6, 7.5, 270.9),
        Vector3.new(53.4, 8.2, 398.2),
        Vector3.new(13.1, 7.5, 487.3),
        Vector3.new(19.3, 7.5, 526.2),
        Vector3.new(18.8, 13.7, 578.8),
        Vector3.new(19.3, 51.8, 683.4),
        Vector3.new(18.3, 75.8, 752.0),
        Vector3.new(-0.3, 75.8, 765.1),
        Vector3.new(-17.9, 76.1, 777.1),
    },
    ["Pilihan 4"] = {
        Vector3.new(0.6, 7.5, 270.9),
        Vector3.new(53.4, 8.2, 398.2),
        Vector3.new(13.1, 7.5, 487.3),
        Vector3.new(19.3, 7.5, 526.2),
        Vector3.new(18.8, 13.7, 578.8),
        Vector3.new(19.3, 51.8, 683.4),
        Vector3.new(18.3, 75.8, 752.0),
        Vector3.new(0.2, 75.8, 813.9),
        Vector3.new(5.1, 75.6, 929.7),
        Vector3.new(99.8, 75.8, 939.9),
        Vector3.new(101.3, 75.8, 998.9),
        Vector3.new(11.3, 75.8, 1005.5),
        Vector3.new(4.9, 75.7, 1104.3),
        Vector3.new(-14.2, 76.1, 1107.0),
    },
    ["Pilihan 5"] = {
        Vector3.new(0.6, 7.5, 270.9),
        Vector3.new(53.4, 8.2, 398.2),
        Vector3.new(13.1, 7.5, 487.3),
        Vector3.new(19.3, 7.5, 526.2),
        Vector3.new(18.8, 13.7, 578.8),
        Vector3.new(19.3, 51.8, 683.4),
        Vector3.new(18.3, 75.8, 752.0),
        Vector3.new(0.2, 75.8, 813.9),
        Vector3.new(5.1, 75.6, 929.7),
        Vector3.new(99.8, 75.8, 939.9),
        Vector3.new(101.3, 75.8, 998.9),
        Vector3.new(11.3, 75.8, 1005.5),
        Vector3.new(4.9, 75.7, 1104.3),
        Vector3.new(2.0, 75.8, 1148.7), 
        Vector3.new(5.6, 75.8, 1409.1), 
        Vector3.new(-17.6, 76.1, 1410.9),
    },
    ["Pilihan 6"] = {
        Vector3.new(0.6, 7.5, 270.9),
        Vector3.new(53.4, 8.2, 398.2),
        Vector3.new(13.1, 7.5, 487.3),
        Vector3.new(19.3, 7.5, 526.2),
        Vector3.new(18.8, 13.7, 578.8),
        Vector3.new(19.3, 51.8, 683.4),
        Vector3.new(18.3, 75.8, 752.0),
        Vector3.new(0.2, 75.8, 813.9),
        Vector3.new(5.1, 75.6, 929.7),
        Vector3.new(99.8, 75.8, 939.9),
        Vector3.new(101.3, 75.8, 998.9),
        Vector3.new(11.3, 75.8, 1005.5),
        Vector3.new(4.9, 75.7, 1104.3),
        Vector3.new(2.0, 75.8, 1148.7),
        Vector3.new(5.6, 75.8, 1409.1),
        Vector3.new(1.8, 75.8, 1423.3), 
        Vector3.new(-514.4, 53.1, 1466.0),
        Vector3.new(-539.0, 53.5, 1449.1),
    },
    ["Pilihan 7"] = {
        Vector3.new(0.6, 7.5, 270.9),
        Vector3.new(53.4, 8.2, 398.2),
        Vector3.new(13.1, 7.5, 487.3),
        Vector3.new(19.3, 7.5, 526.2),
        Vector3.new(18.8, 13.7, 578.8),
        Vector3.new(19.3, 51.8, 683.4),
        Vector3.new(18.3, 75.8, 752.0),
        Vector3.new(0.2, 75.8, 813.9),
        Vector3.new(5.1, 75.6, 929.7),
        Vector3.new(99.8, 75.8, 939.9),
        Vector3.new(101.3, 75.8, 998.9),
        Vector3.new(11.3, 75.8, 1005.5),
        Vector3.new(4.9, 75.7, 1104.3),
        Vector3.new(2.0, 75.8, 1148.7),
        Vector3.new(5.6, 75.8, 1409.1),
        Vector3.new(1.8, 75.8, 1423.3), 
        Vector3.new(-514.4, 53.1, 1466.0),
        Vector3.new(-560.5, 53.1, 1466.0), 
        Vector3.new(-1002.7, 53.1, 1465.2),
        Vector3.new(-1010.5, 53.5, 1447.1),
    },
    ["Pilihan 8"] = {
        Vector3.new(0.6, 7.5, 270.9),
        Vector3.new(53.4, 8.2, 398.2),
        Vector3.new(13.1, 7.5, 487.3),
        Vector3.new(19.3, 7.5, 526.2),
        Vector3.new(18.8, 13.7, 578.8),
        Vector3.new(19.3, 51.8, 683.4),
        Vector3.new(18.3, 75.8, 752.0),
        Vector3.new(0.2, 75.8, 813.9),
        Vector3.new(5.1, 75.6, 929.7),
        Vector3.new(99.8, 75.8, 939.9),
        Vector3.new(101.3, 75.8, 998.9),
        Vector3.new(11.3, 75.8, 1005.5),
        Vector3.new(4.9, 75.7, 1104.3),
        Vector3.new(2.0, 75.8, 1148.7),
        Vector3.new(5.6, 75.8, 1409.1),
        Vector3.new(1.8, 75.8, 1423.3), 
        Vector3.new(-514.4, 53.1, 1466.0),
        Vector3.new(-560.5, 53.1, 1466.0), 
        Vector3.new(-1002.7, 53.1, 1465.2),
        Vector3.new(-1087.4, 51.5, 1465.4),
        Vector3.new(-1094.3, 295.1, 1462.1),
        Vector3.new(-1120.9, 295.1, 1462.4),
        Vector3.new(-1120.0, 295.5, 1446.1),
    },
    ["Pilihan 9"] = {
        Vector3.new(0.6, 7.5, 270.9),
        Vector3.new(53.4, 8.2, 398.2),
        Vector3.new(13.1, 7.5, 487.3),
        Vector3.new(19.3, 7.5, 526.2),
        Vector3.new(18.8, 13.7, 578.8),
        Vector3.new(19.3, 51.8, 683.4),
        Vector3.new(18.3, 75.8, 752.0),
        Vector3.new(0.2, 75.8, 813.9),
        Vector3.new(5.1, 75.6, 929.7),
        Vector3.new(99.8, 75.8, 939.9),
        Vector3.new(101.3, 75.8, 998.9),
        Vector3.new(11.3, 75.8, 1005.5),
        Vector3.new(4.9, 75.7, 1104.3),
        Vector3.new(2.0, 75.8, 1148.7),
        Vector3.new(5.6, 75.8, 1409.1),
        Vector3.new(1.8, 75.8, 1423.3), 
        Vector3.new(-514.4, 53.1, 1466.0),
        Vector3.new(-560.5, 53.1, 1466.0), 
        Vector3.new(-1002.7, 53.1, 1465.2),
        Vector3.new(-1087.4, 51.5, 1465.4),
        Vector3.new(-1094.3, 295.1, 1462.1),
        -- Rute Teroptimasi (Lompat Cepat & Kunci Koordinat Pas)
        Vector3.new(-1242.5, 301.8, 1463.6), 
        {pos = Vector3.new(-1351.7, 280.8, 1472.8), action = "jump"}, 
        Vector3.new(-1500.1, 335.3, 1464.8), 
        {pos = Vector3.new(-1563.2, 319.7, 1464.2), action = "jump"}, 
        Vector3.new(-1621.8, 319.7, 1471.3), 
        {pos = Vector3.new(-1751.8, 287.9, 1470.9), action = "jump"}, 
        Vector3.new(-1861.7, 314.3, 1444.8), 
        {pos = Vector3.new(-1942.6, 304.5, 1469.0), action = "jump"}, 
        Vector3.new(-2041.3, 304.5, 1462.4), 
        {pos = Vector3.new(-2123.7, 303.4, 1471.0), action = "jump"}, 
        Vector3.new(-2176.7, 321.8, 1467.3), 
        {pos = Vector3.new(-2242.2, 311.1, 1463.8), action = "jump"}, 
        Vector3.new(-2341.5, 321.7, 1461.3), 
        {pos = Vector3.new(-2407.3, 319.8, 1464.0), action = "jump"}, 
        Vector3.new(-2524.7, 319.8, 1455.0), 
        Vector3.new(-2594.5, 291.3, 1487.4), 
        Vector3.new(-2708.5, 291.3, 1481.8), 
        Vector3.new(-2780.6, 302.9, 1462.9), 
        {pos = Vector3.new(-2851.6, 280.3, 1460.4), action = "jump"}  
    }
}

-- ====================================================================
-- INTERFACE WINDOW (WindUI)
-- ====================================================================
local Window = WindUI:CreateWindow({
    Title = "My Super Hub",
    Icon = "door-open",
    Author = "by .ftgs and .ftgs", 
})

local Tab = Window:Tab({
    Title = "Auto Farm Route",
    Icon = "bird", 
    Locked = false,
})

local Dropdown = Tab:Dropdown({
    Title = "Pilih Rute Jalan",
    Desc = "Pilih rute terlebih dahulu sebelum menyalakan Toggle",
    Values = { "Pilihan 1", "Pilihan 2", "Pilihan 3", "Pilihan 4", "Pilihan 5", "Pilihan 6", "Pilihan 7", "Pilihan 8", "Pilihan 9" }, 
    Value = "Pilihan 1",
    Multi = false, 
    AllowNone = false,
    Callback = function(option) 
        if type(option) == "table" then
            selectedRoute = option[1]
        else
            selectedRoute = option
        end
        print("Rute aktif diganti ke: " .. tostring(selectedRoute))
    end
})

-- ====================================================================
-- FUNGSI UTAMA PERGERAKAN BOT
-- ====================================================================
local function startRoute(routeName)
    currentTask = task.spawn(function()
        while isRunning do
            local waypoints = routes[routeName]
            if not waypoints then break end
            
            for i, data in ipairs(waypoints) do
                if not isRunning then break end
                
                local targetPos = type(data) == "table" and data.pos or data
                local isJump = type(data) == "table" and data.action == "jump"
                
                warn(string.format("[BOT] %s -> Menuju koordinat ke-%d/%d [%.1f, %.1f, %.1f]", routeName, i, #waypoints, targetPos.X, targetPos.Y, targetPos.Z))
                
                local reached = false
                local playerDied = false
                
                if isJump then
                    -- ================================================================
                    -- MODE LOMPAT KILAT & PRESISI (ANTI-BUG)
                    -- ================================================================
                    local character = LocalPlayer.Character
                    local humanoid = character and character:FindFirstChild("Humanoid")
                    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                    
                    if character and humanoid and rootPart and humanoid.Health > 0 then
                        humanoid.Jump = true 
                        
                        local startPos = rootPart.Position
                        local distance = (targetPos - startPos).Magnitude
                        
                        -- Mengatur durasi waktu meluncur (Dinaikkan menjadi speed 150 studs/sec, max cuma 0.4 detik)
                        local duration = math.clamp(distance / 150, 0.15, 0.4)
                        local elapsed = 0
                        
                        while elapsed < duration and isRunning and humanoid.Health > 0 do
                            local dt = task.wait()
                            elapsed = elapsed + dt
                            local t = math.clamp(elapsed / duration, 0, 1)
                            
                            -- Lengkungan dibuat lebih rendah agar melesat cepat ke depan
                            local peakHeight = math.clamp(distance * 0.08, 2, 6)
                            local currentArc = math.sin(t * math.pi) * peakHeight
                            
                            local currentLerp = startPos:Lerp(targetPos, t)
                            rootPart.CFrame = CFrame.new(currentLerp.X, currentLerp.Y + currentArc, currentLerp.Z) * rootPart.CFrame.Rotation
                            rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0) -- Hapus gravitasi instan selama meluncur
                        end
                        
                        -- KUNCI POSISI MUTLAK (Harus Pas!)
                        if isRunning and humanoid.Health > 0 then
                            rootPart.CFrame = CFrame.new(targetPos) * rootPart.CFrame.Rotation
                            rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                            task.wait(0.02) -- Freeze physics sesaat agar posisi tidak bergeser
                        end
                    end
                    reached = true
                else
                    -- ================================================================
                    -- MODE LARI NORMAL
                    -- ================================================================
                    local connection
                    connection = RunService.RenderStepped:Connect(function()
                        local character = LocalPlayer.Character
                        local humanoid = character and character:FindFirstChild("Humanoid")
                        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                        
                        if not isRunning then
                            if connection then connection:Disconnect() end
                            reached = true
                            return
                        end
                        
                        if not character or not character.Parent or not humanoid or not rootPart or humanoid.Health <= 0 then
                            if connection then connection:Disconnect() end
                            playerDied = true
                            reached = true
                            return
                        end
                        
                        humanoid.AutoRotate = true
                        local currentPos = rootPart.Position
                        local flatTargetPos = Vector3.new(targetPos.X, currentPos.Y, targetPos.Z)
                        local distance = (flatTargetPos - currentPos).Magnitude
                        
                        if distance < 2.5 then 
                            if connection then connection:Disconnect() end
                            
                            rootPart.CFrame = CFrame.new(flatTargetPos.X, rootPart.Position.Y, flatTargetPos.Z) * rootPart.CFrame.Rotation
                            rootPart.AssemblyLinearVelocity = Vector3.new(0, rootPart.AssemblyLinearVelocity.Y, 0)
                            humanoid:Move(Vector3.new(0, 0, 0)) 
                            
                            reached = true
                            return
                        end
                        
                        local direction = (flatTargetPos - currentPos).Unit
                        humanoid:Move(direction, false)
                    end)
                    
                    repeat task.wait() until reached or not isRunning
                end
                
                if not isRunning then break end
                
                -- [LOGIK MATI] Mulai ulang rute setelah delay 5 detik
                if playerDied then
                    print("[MATI] Karaktermu mati! Menunggu respawn + delay 5 detik...")
                    task.wait(5)
                    print("[BOT] Memulai ulang rute dari koordinat pertama...")
                    break 
                end
                
                -- CEK: Sampai Tujuan Akhir Rute
                if i == #waypoints then
                    print("Sampai di tujuan akhir! Menunggu 5 detik...")
                    
                    local character = LocalPlayer.Character
                    local humanoid = character and character:FindFirstChild("Humanoid")
                    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                    if humanoid then humanoid:Move(Vector3.new(0, 0, 0)) end
                    if rootPart then rootPart.AssemblyLinearVelocity = Vector3.new(0, rootPart.AssemblyLinearVelocity.Y, 0) end
                    
                    task.wait(5) 
                    print("Mengulang rute dari koordinat awal...")
                end
            end
        end
    end)
end

-- ====================================================================
-- FUNGSI UNTUK BERHENTI
-- ====================================================================
local function stopRoute()
    isRunning = false
    if currentTask then currentTask = nil end
    
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChild("Humanoid")
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if humanoid then humanoid:Move(Vector3.new(0, 0, 0)) end
    if rootPart then rootPart.AssemblyLinearVelocity = Vector3.new(0, rootPart.AssemblyLinearVelocity.Y, 0) end
    print("Auto Run dihentikan.")
end

-- 2. TOGGLE UNTUK MEMULAI PERJALANAN
local Toggle = Tab:Toggle({
    Title = "Mulai Perjalanan",
    Desc = "Nyalakan untuk menjalankan rute yang dipilih di atas",
    Icon = "bird",
    Type = "Checkbox",
    Value = false, 
    Callback = function(state) 
        if state then
            isRunning = true
            startRoute(selectedRoute)
        else
            stopRoute()
        end
    end
})
