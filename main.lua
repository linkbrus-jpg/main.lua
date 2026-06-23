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
    {pos = Vector3.new(-3373.5, -177.7, -49.4), action = "Jump"},
    {pos = Vector3.new(-3355.7, -171.1, -43.1), action = "Jump"},
    {pos = Vector3.new(-3339.5, -159.7, -19.7), action = "Jump"},
    {pos = Vector3.new(-3313.5, -148.1, -9.9), action = "Jump"},
    {pos = Vector3.new(-3295.9, -136.6, 12.2), action = "Jump"},
    {pos = Vector3.new(-3270.8, -126.6, 21.9), action = "Jump"},
    {pos = Vector3.new(-3252.9, -114.8, 44.8), action = "Jump"},
    {pos = Vector3.new(-3234.7, -105.2, 58.9), action = "Run"},
    {pos = Vector3.new(-3212.1, -98.0, 73.1), action = "Run"},
    {pos = Vector3.new(-3184.9, -104.1, 76.9), action = "Jump"},
    {pos = Vector3.new(-3164.3, -111.9, 70.4), action = "Jump"},
    {pos = Vector3.new(-3136.9, -122.5, 83.7), action = "Jump"},
    {pos = Vector3.new(-3111.2, -132.3, 77.5), action = "Jump"},
    {pos = Vector3.new(-3084.6, -144.0, 91.7), action = "Run"},
    {pos = Vector3.new(-2968.3, -160.4, 140.4), action = "Run"},
    {pos = Vector3.new(-2910.9, -153.5, 187.1), action = "Jump"},
    {pos = Vector3.new(-2886.4, -153.5, 208.9), action = "Jump"},
    {pos = Vector3.new(-2848.4, -153.5, 209.8), action = "Jump"},
    {pos = Vector3.new(-2824.2, -153.7, 218.2), action = "Jump"},
    {pos = Vector3.new(-2798.0, -153.8, 226.8), action = "Jump"},
    {pos = Vector3.new(-2771.9, -154.0, 237.3), action = "Jump"},
    {pos = Vector3.new(-2749.6, -154.1, 243.0), action = "Jump"},
    {pos = Vector3.new(-2722.1, -154.2, 254.0), action = "Jump"},
    {pos = Vector3.new(-2698.2, -154.4, 261.7), action = "Jump"},
    {pos = Vector3.new(-2669.2, -154.5, 271.8), action = "Jump"},
    {pos = Vector3.new(-2634.1, -164.1, 273.2), action = "Jump"},
    {pos = Vector3.new(-2622.6, -161.5, 297.2), action = "Jump"},
    {pos = Vector3.new(-2614.3, -154.8, 321.7), action = "Jump"},
    {pos = Vector3.new(-2603.3, -148.1, 348.8), action = "Jump"},
    {pos = Vector3.new(-2596.2, -141.4, 368.2), action = "Jump"},
    {pos = Vector3.new(-2587.2, -134.5, 394.0), action = "Jump"},
    {pos = Vector3.new(-2579.3, -127.9, 417.3), action = "Jump"},
    {pos = Vector3.new(-2571.8, -121.2, 443.2), action = "Jump"},
    {pos = Vector3.new(-2565.9, -118.8, 465.4), action = "Run"},
    {pos = Vector3.new(-2509.4, -120.1, 552.1), action = "Run"},
    {pos = Vector3.new(-2373.6, -142.0, 572.6), action = "Run"},
    {pos = Vector3.new(-2383.9, -146.2, 604.5), action = "Jump"},
    {pos = Vector3.new(-2399.0, -150.5, 622.4), action = "Run"},
    {pos = Vector3.new(-2415.5, -156.4, 660.8), action = "Jump"},
    {pos = Vector3.new(-2412.7, -169.1, 687.6), action = "Run"},
    {pos = Vector3.new(-2428.0, -176.3, 728.9), action = "Jump"},
    {pos = Vector3.new(-2439.5, -173.9, 741.8), action = "Run"},
    {pos = Vector3.new(-2453.5, -170.0, 795.6), action = "Run"},
    {pos = Vector3.new(-2417.6, -173.9, 783.8), action = "Run"},
    {pos = Vector3.new(-2254.6, -204.8, 688.3), action = "Run"},
    {pos = Vector3.new(-2215.1, -202.0, 701.9), action = "Run"},
    {pos = Vector3.new(-2253.9, -215.8, 755.3), action = "Run"},
    {pos = Vector3.new(-2258.0, -223.7, 769.4), action = "Run"},
    {pos = Vector3.new(-2293.8, -248.6, 819.8), action = "Run"},
    {pos = Vector3.new(-2334.0, -254.0, 865.1), action = "Run"},
    {pos = Vector3.new(-2320.7, -256.5, 900.5), action = "Jump"},
    {pos = Vector3.new(-2299.5, -255.7, 923.7), action = "Run"},
    {pos = Vector3.new(-2254.1, -255.7, 934.7), action = "Run"},
    {pos = Vector3.new(-2267.6, -248.3, 924.4), action = "Run"},
    {pos = Vector3.new(-2250.5, -248.3, 906.2), action = "Run"},
    {pos = Vector3.new(-2238.4, -240.3, 920.9), action = "Run"},
    {pos = Vector3.new(-2221.1, -232.5, 934.9), action = "Run"},
    {pos = Vector3.new(-2238.3, -232.5, 950.0), action = "Run"},
    {pos = Vector3.new(-2253.9, -224.5, 937.0), action = "Run"},
    {pos = Vector3.new(-2267.0, -217.4, 921.3), action = "Run"},
    {pos = Vector3.new(-2205.9, -209.4, 880.3), action = "Run"},
    {pos = Vector3.new(-2158.5, -209.9, 924.1), action = "Run"},
    {pos = Vector3.new(-2049.1, -211.9, 1037.2), action = "Run"},
    {pos = Vector3.new(-2018.4, -207.1, 1053.9), action = "Run"},
    {pos = Vector3.new(-1974.8, -201.3, 1041.5), action = "Run"},
    {pos = Vector3.new(-1955.1, -197.0, 1012.8), action = "Run"},
    {pos = Vector3.new(-1958.3, -191.6, 970.7), action = "Run"},
    {pos = Vector3.new(-1986.0, -186.7, 943.5), action = "Run"},
    {pos = Vector3.new(-2023.1, -181.9, 940.7), action = "Run"},
    {pos = Vector3.new(-2056.2, -177.2, 958.7), action = "Run"},
    {pos = Vector3.new(-2069.3, -171.5, 1002.7), action = "Jump"},
    {pos = Vector3.new(-2059.1, -167.1, 1036.3), action = "Run"},
    {pos = Vector3.new(-2062.8, -163.8, 1061.8), action = "Run"},
    {pos = Vector3.new(-2082.6, -159.3, 1090.9), action = "Run"},
    {pos = Vector3.new(-2120.5, -154.4, 1096.6), action = "Run"},
    {pos = Vector3.new(-2157.7, -149.1, 1081.2), action = "Run"},
    {pos = Vector3.new(-2170.6, -144.4, 1046.0), action = "Run"},
    {pos = Vector3.new(-2158.9, -139.0, 1006.9), action = "Jump"},
    {pos = Vector3.new(-2133.0, -134.9, 988.1), action = "Run"},
    {pos = Vector3.new(-2089.0, -129.2, 992.0), action = "Run"},
    {pos = Vector3.new(-2071.8, -127.3, 1007.7), action = "Run"},
    {pos = Vector3.new(-1955.3, -121.2, 1122.5), action = "Run"},
    {pos = Vector3.new(-1893.8, -126.8, 1175.3), action = "Run"},
    {pos = Vector3.new(-1927.5, -146.1, 1217.8), action = "Run"},
    {pos = Vector3.new(-1916.6, -146.1, 1225.0), action = "Jump"},
    {pos = Vector3.new(-1897.2, -146.1, 1242.2), action = "Run"},
    {pos = Vector3.new(-1883.3, -146.1, 1251.5), action = "Run"},
    {pos = Vector3.new(-1863.8, -136.5, 1226.7), action = "Jump"},
    {pos = Vector3.new(-1853.1, -128.5, 1211.6), action = "Run"},
    {pos = Vector3.new(-1831.5, -113.8, 1185.4), action = "Jump"},
    {pos = Vector3.new(-1819.2, -104.3, 1167.1), action = "Run"},
    {pos = Vector3.new(-1793.0, -93.0, 1138.2), action = "Run"},
    {pos = Vector3.new(-1748.6, -92.9, 1175.0), action = "Run"},
    {pos = Vector3.new(-1770.3, -103.9, 1203.6), action = "Jump"},
    {pos = Vector3.new(-1797.9, -124.3, 1242.0), action = "Run"},
    {pos = Vector3.new(-1819.7, -134.2, 1268.7), action = "Run"},
    {pos = Vector3.new(-1768.2, -90.5, 1302.2), action = "Run"},
    {pos = Vector3.new(-1797.3, -88.4, 1343.0), action = "Run"},
    {pos = Vector3.new(-1795.3, -88.1, 1359.3), action = "Jump"},
    {pos = Vector3.new(-1790.8, -87.4, 1384.1), action = "Run"},
    {pos = Vector3.new(-1787.5, -86.8, 1406.7), action = "Jump"},
    {pos = Vector3.new(-1785.2, -86.1, 1429.4), action = "Run"},
    {pos = Vector3.new(-1784.0, -85.3, 1451.7), action = "Jump"},
    {pos = Vector3.new(-1777.6, -84.8, 1472.8), action = "Run"},
    {pos = Vector3.new(-1737.9, -86.0, 1466.6), action = "Run"},
    {pos = Vector3.new(-1751.2, -69.3, 1358.1), action = "Run"},
    {pos = Vector3.new(-1705.8, -70.7, 1351.2), action = "Run"},
    {pos = Vector3.new(-1695.2, -66.0, 1409.4), action = "Run"},
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
