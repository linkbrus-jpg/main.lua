local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Konfigurasi Statis (Kecepatan dikunci ke 80)
local walkSpeedValue = 60
local isAutoRunning = false

-- ==========================================
-- 1. KONFIGURASI KOORDINAT
-- ==========================================
local waypoints = {
    {pos = Vector3.new(-45.3, -456.0, -2049.0), action = "Jump"},
    {pos = Vector3.new(-83.5, -456.0, -2047.4), action = "Jump"},
    {pos = Vector3.new(-141.0, -456.0, -2049.0), action = "Jump"},
    {pos = Vector3.new(-184.2, -456.0, -2048.3), action = "Run"},
    {pos = Vector3.new(-329.7, -456.0, -2047.8), action = "Jump"},
    {pos = Vector3.new(-368.9, -456.0, -2048.3), action = "Jump"},
    {pos = Vector3.new(-426.6, -456.0, -2051.5), action = "Jump"},
    {pos = Vector3.new(-486.5, -456.0, -2051.2), action = "Jump"},
    {pos = Vector3.new(-540.2, -456.0, -2050.2), action = "Jump"},
    {pos = Vector3.new(-596.9, -456.0, -2048.4), action = "Jump"},
    {pos = Vector3.new(-641.3, -456.0, -2049.2), action = "Run"},
    {pos = Vector3.new(-815.3, -450.1, -2047.9 ), action = "Jump"},
    {pos = Vector3.new(-852.5, -456.7, -2047.1), action = "Jump"},
    {pos = Vector3.new(-902.8, -459.5, -2034.4), action = "Jump"},
    {pos = Vector3.new(-956.8, -456.9, -2047.0), action = "Jump"},
    {pos = Vector3.new(-1014.5, -460.6, -2059.1), action = "Jump"},
    {pos = Vector3.new(-1070.9, -456.7, -2052.4), action = "Jump"},
    {pos = Vector3.new(-1122.4, -456.0, -2071.7), action = "Jump"},
    {pos = Vector3.new(-1148.5, -450.0, -2097.4), action = "Jump"},
    {pos = Vector3.new(-1164.3, -444.0, -2116.8), action = "Jump"},
    {pos = Vector3.new(-1181.4, -438.0, -2127.4), action = "Jump"},
    {pos = Vector3.new(-1200.6, -432.0, -2134.8), action = "Jump"},
    {pos = Vector3.new(-1219.5, -426.0, -2131.4), action = "Jump"},
    {pos = Vector3.new(-1234.3, -420.0, -2122.9), action = "Jump"},
    {pos = Vector3.new(-1234.8, -414.0, -2097.6), action = "Run"},
    {pos = Vector3.new(-1214.9, -410.0, -2011.2), action = "Run"},
    {pos = Vector3.new(-1258.7, -415.5, -1951.7), action = "Jump"},
    {pos = Vector3.new(-1278.0, -418.3, -1924.5), action = "Jump"},
    {pos = Vector3.new(-1309.5, -418.3, -1884.1), action = "Jump"},
    {pos = Vector3.new(-1347.5, -414.1, -1848.7), action = "Jump"},
    {pos = Vector3.new(-1393.1, -418.3, -1830.1), action = "Jump"},
    {pos = Vector3.new(-1445.4, -418.3, -1813.1), action = "Jump"},
    {pos = Vector3.new(-1494.9, -414.0, -1790.5), action = "Run"},
    {pos = Vector3.new(-1509.7, -416.6, -1755.4), action = "Jump"},
    {pos = Vector3.new(-1522.5, -415.1, -1722.4), action = "Jump"},
    {pos = Vector3.new(-1539.8, -412.8, -1672.4), action = "Jump"},
    {pos = Vector3.new(-1563.9, -406.5, -1650.8), action = "Jump"},
    {pos = Vector3.new(-1602.5, -409.0, -1647.8), action = "Jump"},
    {pos = Vector3.new(-1655.8, -407.9, -1647.5), action = "Jump"},
    {pos = Vector3.new(-1709.7, -406.9, -1647.2), action = "Jump"},
    {pos = Vector3.new(-1753.3, -406.6, -1648.6), action = "Run"},
    {pos = Vector3.new(-1827.5, -406.1, -1619.1), action = "Run"},
    {pos = Vector3.new(-1908.6, -386.0, -1562.1), action = "Run"},
    {pos = Vector3.new(-1928.2, -391.8, -1494.9), action = "Jump"},
    {pos = Vector3.new(-1934.8, -389.9, -1469.5), action = "Run"},
    {pos = Vector3.new(-1954.1, -382.0, -1413.0), action = "Jump"},
    {pos = Vector3.new(-1978.3, -375.9, -1433.5), action = "Run"},
    {pos = Vector3.new(-1992.6, -369.3, -1448.4), action = "Jump"},
    {pos = Vector3.new(-2001.7, -365.2, -1457.1), action = "Run"},
    {pos = Vector3.new(-2028.7, -354.0, -1485.3), action = "Run"},
    {pos = Vector3.new(-2079.1, -349.5, -1492.7), action = "Jump"},
    {pos = Vector3.new(-2097.7, -343.8, -1495.7), action = "Run"},
    {pos = Vector3.new(-2138.4, -331.9, -1498.7), action = "Run"},
    {pos = Vector3.new(-2169.1, -320.0, -1418.6), action = "Run"},
    {pos = Vector3.new(-2222.0, -320.3, -1339.9), action = "Run"},
    {pos = Vector3.new(-2305.9, -320.4, -1327.8), action = "Jump"},
    {pos = Vector3.new(-2330.4, -320.4, -1295.2), action = "Run"},
    {pos = Vector3.new(-2324.5, -316.9, -1212.6), action = "Jump"},
    {pos = Vector3.new(-2351.6, -306.3, -1204.1), action = "Run"},
    {pos = Vector3.new(-2421.3, -287.8, -1184.1), action = "Run"},
    {pos = Vector3.new(-2404.7, -274.2, -1132.8), action = "Jump"},
    {pos = Vector3.new(-2397.2, -269.1, -1100.8), action = "Run"},
    {pos = Vector3.new(-2422.2, -269.1, -1071.7), action = "Jump"},
    {pos = Vector3.new(-2439.7, -269.1, -1050.6), action = "Run"},
    {pos = Vector3.new(-2486.1, -269.1, -994.8), action = "Jump"},
    {pos = Vector3.new(-2520.0, -285.2, -949.9), action = "Run"},
    {pos = Vector3.new(-2624.1, -267.2, -815.1), action = "Run"},
    {pos = Vector3.new(-2719.6, -278.0, -693.6), action = "Run"},
    {pos = Vector3.new(-2720.6, -307.1, -591.1), action = "Jump"},
    {pos = Vector3.new(-2722.7, -299.5, -573.3), action = "Run"},
    {pos = Vector3.new(-2724.0, -270.0, -532.6), action = "Jump"},
    {pos = Vector3.new(-2804.5, -319.6, -567.0), action = "Jump"},
    {pos = Vector3.new(-2833.3, -311.0, -585.6), action = "Run"},
    {pos = Vector3.new(-2879.0, -274.0, -609.3), action = "Run"},
    {pos = Vector3.new(-2888.0, -296.6, -565.4), action = "Jump"},
    {pos = Vector3.new(-2900.8, -300.0, -534.3), action = "Jump"},
    {pos = Vector3.new(-2908.8, -290.6, -511.8), action = "Run"},
    {pos = Vector3.new(-3001.3, -266.9, -271.7), action = "Jump"},
    {pos = Vector3.new(-3030.8, -270.4, -256.3), action = "Run"},
    {pos = Vector3.new(-3058.9, -266.1, -239.5), action = "Run"},
    {pos = Vector3.new(-3115.3, -268.2, -216.7), action = "Run"},
    {pos = Vector3.new(-3129.5, -268.1, -208.8), action = "Run"},
    {pos = Vector3.new(-3179.3, -268.1, -53.9), action = "Jump"},
    {pos = Vector3.new(-3186.6, -268.1, -30.2), action = "Jump"},
    {pos = Vector3.new(-3171.3, -263.1, -5.6), action = "Run"},
    {pos = Vector3.new(-3076.1, -221.7, 75.8), action = "Run"},
    {pos = Vector3.new(-3063.5, -206.0, 151.3), action = "Run"},
    {pos = Vector3.new(-3095.7, -205.9, 175.2), action = "Jump"},
    {pos = Vector3.new(-3111.7, -202.3, 187.6), action = "Run"},
    {pos = Vector3.new(-3126.9, -198.7, 200.4), action = "Jump"},
    {pos = Vector3.new(-3142.4, -195.3, 212.0), action = "Run"},
    {pos = Vector3.new(-3176.0, -186.0, 241.4), action = "Run"},
    {pos = Vector3.new(-3226.2, -188.4, 236.2), action = "Jump"},
    {pos = Vector3.new(-3248.6, -188.3, 232.9), action = "Run"},
    {pos = Vector3.new(-3273.1, -188.2, 229.4), action = "Jump"},
    {pos = Vector3.new(-3298.2, -188.0, 226.3), action = "Run"},
    {pos = Vector3.new(-3319.7, -187.9, 222.3), action = "Jump"},
    {pos = Vector3.new(-3345.1, -187.8, 218.3), action = "Run"},
    {pos = Vector3.new(-3367.9, -187.7, 216.4), action = "Jump"},
    {pos = Vector3.new(-3390.7, -187.5, 213.2), action = "Run"},
    {pos = Vector3.new(-3429.5, -182.0, 204.1), action = "Run"},
    {pos = Vector3.new(-3427.5, -185.4, 162.6), action = "Jump"},
    {pos = Vector3.new(-3428.0, -185.7, 146.5), action = "Run"},
    {pos = Vector3.new(-3427.9, -186.4, 118.9), action = "Jump"},
    {pos = Vector3.new(-3438.3, -186.9, 101.9), action = "Run"},
    {pos = Vector3.new(-3437.9, -187.4, 83.4), action = "Jump"},
    {pos = Vector3.new(-3423.2, -187.8, 65.4), action = "Run"},
    {pos = Vector3.new(-3423.3, -188.4, 40.9), action = "Jump"},
    {pos = Vector3.new(-3436.0, -188.9, 21.6), action = "Run"},
    {pos = Vector3.new(-3433.7, -189.4, 3.2), action = "Jump"},
    {pos = Vector3.new(-3420.6, -189.8, -13.7), action = "Run"},
    {pos = Vector3.new(-3417.9, -188.9, -77.4), action = "Run"},
}

local function applyStats(humanoid)
    if humanoid then
        humanoid.WalkSpeed = walkSpeedValue
    end
end

-- Mencari indeks koordinat terdekat berdasarkan posisi karakter saat ini
local function getNearestWaypointIndex(character)
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return 1 end

    local nearestDistance = math.huge
    local nearestIndex = 1

    for i, wp in ipairs(waypoints) do
        local pos1 = Vector3.new(rootPart.Position.X, 0, rootPart.Position.Z)
        local pos2 = Vector3.new(wp.pos.X, 0, wp.pos.Z)
        local distance = (pos1 - pos2).Magnitude

        if distance < nearestDistance then
            nearestDistance = distance
            nearestIndex = i
        end
    end
    return nearestIndex
end

local function startAutoPathing()
    while isAutoRunning do
        local character = LocalPlayer.Character
        
        -- Jika karakter mati atau belum respawn penuh
        if not character or not character:FindFirstChild("Humanoid") or character.Humanoid.Health <= 0 then
            character = LocalPlayer.CharacterAdded:Wait()
            character:WaitForChild("HumanoidRootPart")
            character:WaitForChild("Humanoid")
            task.wait(0.5)
        end

        local humanoid = character:WaitForChild("Humanoid")
        local rootPart = character:WaitForChild("HumanoidRootPart")

        applyStats(humanoid)
        local currentIndex = getNearestWaypointIndex(character)

        while isAutoRunning and currentIndex <= #waypoints do
            
            -- ===============================================
            -- SISTEM RE-CHECK JIKA TIBA-TIBA MATI
            -- ===============================================
            if not character or not character.Parent or humanoid.Health <= 0 then
                -- [TIMING TUNGGU SETELAH MATI]: Menunggu 5 detik penuh setelah terdeteksi mati
                task.wait(5) 
                
                -- Tunggu karakter benar-benar hidup kembali di tempat spawn baru
                character = LocalPlayer.CharacterAdded:Wait()
                rootPart = character:WaitForChild("HumanoidRootPart")
                humanoid = character:WaitForChild("Humanoid")
                task.wait(0.5) 
                
                -- Cari lagi koordinat paling dekat dari titik berdiri saat ini
                currentIndex = getNearestWaypointIndex(character)
                applyStats(humanoid)
                continue 
            end

            local target = waypoints[currentIndex]
            local stuckTimer = 0
            
            -- ===============================================
            -- FASE 1: JALAN MENUJU KOORDINAT TARGET
            -- ===============================================
            while isAutoRunning and humanoid.Health > 0 do
                local pos2D = Vector3.new(rootPart.Position.X, 0, rootPart.Position.Z)
                local target2D = Vector3.new(target.pos.X, 0, target.pos.Z)
                local distance = (pos2D - target2D).Magnitude
                
                -- Jarak toleransi di-set ke 5 karena kecepatan lari 80 sangat kencang
                if distance <= 5 then
                    break
                end

                humanoid:MoveTo(target.pos)
                task.wait(0.02)
                stuckTimer = stuckTimer + 0.02

                if stuckTimer > 3 then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    humanoid.Jump = true
                    stuckTimer = 0
                end
            end

            if humanoid.Health <= 0 or not isAutoRunning then continue end

            -- ===============================================
            -- FASE 2: LOMPAT PARABOLA PRESISI (ANTI-FALL / ANTI-MISSED)
            -- ===============================================
            if target.action == "Jump" then
                local nextTarget = waypoints[currentIndex + 1]
                
                if nextTarget then
                    local startPos = rootPart.Position
                    local endPos = nextTarget.pos
                    
                    -- Hitung jarak asli horizontal antar koordinat
                    local distance = (Vector3.new(startPos.X, 0, startPos.Z) - Vector3.new(endPos.X, 0, endPos.Z)).Magnitude
                    
                    -- DETEKSI JARAK: Jarak sempit = lompat sedikit, jarak jauh = lompat agak banyak
                    local jumpHeight = math.clamp(distance * 0.45, 12, 45) 
                    
                    -- Durasi melayang disesuaikan secara natural dengan kecepatan 80
                    local duration = math.max(distance / 80, 0.25) * 1.5
                    
                    -- Trigger animasi lompat agar terlihat asli
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    
                    -- Sistem gerak lengkungan (arc) parabola agar mendarat PAS di koordinat depannya
                    local t = 0
                    while t < 1 and humanoid.Health > 0 and isAutoRunning do
                        local dt = task.wait(0.01)
                        t = t + (dt / duration)
                        if t > 1 then t = 1 end
                        
                        -- Interpolasi posisi horizontal (X dan Z) & kalkulasi tinggi kurva (Y)
                        local currentXZ = startPos:Lerp(endPos, t)
                        local heightOffset = 4 * jumpHeight * t * (1 - t)
                        local currentY = startPos.Y + (endPos.Y - startPos.Y) * t + heightOffset
                        
                        -- Mengunci posisi dan arah hadap karakter ke koordinat depan selama melompat
                        rootPart.CFrame = CFrame.lookAt(
                            Vector3.new(currentXZ.X, currentY, currentXZ.Z), 
                            Vector3.new(endPos.X, currentY, endPos.Z)
                        )
                    end
                    
                    -- Mengunci posisi akhir mutlak di koordinat target pendaratan
                    if humanoid.Health > 0 then
                        rootPart.CFrame = CFrame.new(endPos)
                    end
                    task.wait(0.05)
                end
            end

            -- Index koordinat bertambah setelah sukses mendarat dengan selamat
            currentIndex = currentIndex + 1
        end

        task.wait(0.1)
    end
end

-- ==========================================
-- 3. INTERFACE WINDUI (BERSIH DARI SLIDER)
-- ==========================================
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "My Super Hub",
    Icon = "door-open",
    Author = "by .ftgs and .ftgs", 
})

local Tab = Window:Tab({
    Title = "Auto Farm",
    Icon = "bird",
    Locked = false,
})

local autoPathThread = nil

Tab:Toggle({
    Title = "Auto Path (Locked Speed 80)",
    Desc = "Lari otomatis & Sistem Lompat Presisi Parabola.",
    Icon = "footprints",
    Type = "Checkbox",
    Value = false, 
    Callback = function(state) 
        isAutoRunning = state
        if isAutoRunning then
            if autoPathThread then task.cancel(autoPathThread) end
            autoPathThread = task.spawn(startAutoPathing)
        else
            if autoPathThread then 
                task.cancel(autoPathThread) 
                autoPathThread = nil
            end
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid:MoveTo(char.HumanoidRootPart.Position)
            end
        end
    end
})
