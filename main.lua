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

    -- 6. PENGHANCUR HITBOX NPC10 OTOMATIS (ANTI-HIT RE-LOOP)
    task.spawn(function()
        while true do
            pcall(function()
                local npc10 = workspace:FindFirstChild("NPC10")
                if npc10 then
                    local hitbox = npc10:FindFirstChild("Hitbox")
                    if hitbox then
                        hitbox:Destroy()
                        warn("[ANTI-HIT] Hitbox NPC10 Berhasil Dilenyapkan!")
                    end
                end
            end)
            task.wait(0.5) -- Cek setiap setengah detik untuk antisipasi NPC respawn
        end
    end)
end)

-- 7. PENGHANCUR NPC ZONE 12 TOTAL (ANTI-JATUH & ANTI-NABRAK)
    task.spawn(function()
        while true do
            pcall(function()
                local npcPiege = workspace:FindFirstChild("NPC & Piege")
                if npcPiege then
                    local zone12 = npcPiege:FindFirstChild("NPC_Zone12")
                    if zone12 then
                        -- Hapus SpawnNpc12
                        local spawnNpc = zone12:FindFirstChild("SpawnNpc12")
                        if spawnNpc then 
                            spawnNpc:Destroy() 
                        end
                        
                        -- Hapus Sol (Lantai/pijakan NPC yang suka bikin nyangkut)
                        local sol = zone12:FindFirstChild("Sol")
                        if sol then 
                            sol:Destroy() 
                        end
                        
                        -- Hapus Zona Serang (Hitbox tabrakan)
                        local attackZone = zone12:FindFirstChild("NPC12_AttackZone")
                        if attackZone then 
                            attackZone:Destroy() 
                            warn("[CLEANER] NPC_Zone12 (Spawn, Sol, AttackZone) berhasil dihapus!")
                        end
                    end
                end
            end)
            task.wait(1) -- Cek setiap 1 detik agar tidak lag, mengantisipasi jika NPC respawn
        end
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
        {pos = Vector3.new(-2851.6, 280.3, 1460.4), action = "jump"},
        Vector3.new(-2947.5, 295.1, 1466.5),
        Vector3.new(-2968.5, 295.5, 1448.5),
    },
    ["Pilihan 10"] = {
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
        {pos = Vector3.new(-2851.6, 280.3, 1460.4), action = "jump"},
        Vector3.new(-2947.5, 295.1, 1466.5),
        Vector3.new(-3912.4, 295.1, 1464.5),
        Vector3.new(-3938.4, 295.5, 1451.0),
    },
 ["Pilihan 11"] = {
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
        {pos = Vector3.new(-2851.6, 280.3, 1460.4), action = "jump"},
        Vector3.new(-2947.5, 295.1, 1466.5),
        Vector3.new(-3912.4, 295.1, 1464.5),
        Vector3.new(-3991.2, 295.1, 1462.8),
{pos = Vector3.new(-4103.7, 295.1, 1465.2), action = "jump"},
Vector3.new(-4103.7, 295.1, 1465.2),
Vector3.new(-4184.7, 295.1, 1464.7),
{pos = Vector3.new(-4292.8, 295.1, 1465.2), action = "jump"},
Vector3.new(-4292.8, 295.1, 1465.2),
Vector3.new(-4300.6, 295.1, 1463.5),
Vector3.new(-4307.6, 342.1, 1466.0),
Vector3.new(-4317.0, 342.0, 1465.9),
Vector3.new(-4314.4, 342.1, 1446.6),
{pos = Vector3.new(-4314.0, 342.7, 1336.8), action = "jump"},
Vector3.new(-4314.0, 342.7, 1336.8),
Vector3.new(-4315.8, 349.9, 1299.8),
Vector3.new(-4308.3, 349.9, 1301.7),
Vector3.new(-4300.2, 367.9, 1300.9),
Vector3.new(-4285.2, 367.9, 1301.1),
{pos = Vector3.new(-4191.9, 368.1, 1300.6), action = "jump"},
Vector3.new(-4191.9, 368.1, 1300.6),
Vector3.new(-4156.7, 368.1, 1302.4),
{pos = Vector3.new(-4057.7, 368.1, 1302.3), action = "jump"},
Vector3.new(-4057.7, 368.1, 1302.3),
Vector3.new(-4026.8, 372.2, 1301.6),
Vector3.new(-4015.1, 390.5, 1305.8),
Vector3.new(-4008.8, 390.5, 1304.9),
Vector3.new(-4010.7, 390.5, 1324.4),
{pos = Vector3.new(-4007.5, 390.5, 1430.8), action = "jump"},
Vector3.new(-4007.5, 390.5, 1430.8),
Vector3.new(-4009.3, 390.5, 1475.4),
{pos = Vector3.new(-4011.0, 390.5, 1573.1), action = "jump"},
Vector3.new(-4011.0, 390.5, 1573.1),
Vector3.new(-4008.4, 390.5, 1608.7),
Vector3.new(-4018.8, 390.5, 1607.8),
{pos = Vector3.new(-4127.7, 392.1, 1606.7), action = "jump"},
Vector3.new(-4127.7, 392.1, 1606.7),
Vector3.new(-4172.0, 399.0, 1610.4),
{pos = Vector3.new(-4302.3, 392.0, 1609.4), action = "jump"},
Vector3.new(-4302.3, 392.0, 1609.4),
Vector3.new(-4349.1, 398.8, 1606.7),
Vector3.new(-4348.7, 405.2, 1574.1),
{pos = Vector3.new(-4347.5, 407.2, 1456.2), action = "jump"},
Vector3.new(-4347.5, 407.2, 1456.2),
Vector3.new(-4346.8, 433.2, 1403.5),
Vector3.new(-4346.6, 433.2, 1392.2),
Vector3.new(-4327.6, 433.3, 1393.7),
{pos = Vector3.new(-4245.0, 433.5, 1395.2), action = "jump"},
Vector3.new(-4245.0, 433.5, 1395.2),
Vector3.new(-4221.1, 440.6, 1395.4),
{pos = Vector3.new(-4125.8, 441.8, 1388.9), action = "jump"},
Vector3.new(-4125.8, 441.8, 1388.9),
Vector3.new(-4106.8, 449.2, 1405.5),
{pos = Vector3.new(-4047.6, 448.3, 1467.7), action = "jump"},
Vector3.new(-4047.6, 448.3, 1467.7),
Vector3.new(-4051.7, 456.3, 1494.7),
{pos = Vector3.new(-4089.5, 452.3, 1576.7), action = "jump"},
Vector3.new(-4089.5, 452.3, 1576.7),
Vector3.new(-4112.4, 451.8, 1575.1),
{pos = Vector3.new(-4162.1, 453.7, 1544.7), action = "jump"},
Vector3.new(-4162.1, 453.7, 1544.7),
Vector3.new(-4189.1, 452.7, 1548.2),
{pos = Vector3.new(-4255.8, 455.6, 1528.9), action = "jump"},
Vector3.new(-4255.8, 455.6, 1528.9),
Vector3.new(-4312.2, 472.3, 1531.3),
Vector3.new(-4362.4, 469.6, 1530.6),
Vector3.new(-4370.7, 470.0, 1508.2),
    },
     ["Pilihan 12"] = {
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
        {pos = Vector3.new(-2851.6, 280.3, 1460.4), action = "jump"},
        Vector3.new(-2947.5, 295.1, 1466.5),
        Vector3.new(-3912.4, 295.1, 1464.5),
        Vector3.new(-3991.2, 295.1, 1462.8),
{pos = Vector3.new(-4103.7, 295.1, 1465.2), action = "jump"},
Vector3.new(-4103.7, 295.1, 1465.2),
Vector3.new(-4184.7, 295.1, 1464.7),
{pos = Vector3.new(-4292.8, 295.1, 1465.2), action = "jump"},
Vector3.new(-4292.8, 295.1, 1465.2),
Vector3.new(-4300.6, 295.1, 1463.5),
Vector3.new(-4307.6, 342.1, 1466.0),
Vector3.new(-4317.0, 342.0, 1465.9),
Vector3.new(-4314.4, 342.1, 1446.6),
{pos = Vector3.new(-4314.0, 342.7, 1336.8), action = "jump"},
Vector3.new(-4314.0, 342.7, 1336.8),
Vector3.new(-4315.8, 349.9, 1299.8),
Vector3.new(-4308.3, 349.9, 1301.7),
Vector3.new(-4300.2, 367.9, 1300.9),
Vector3.new(-4285.2, 367.9, 1301.1),
{pos = Vector3.new(-4191.9, 368.1, 1300.6), action = "jump"},
Vector3.new(-4191.9, 368.1, 1300.6),
Vector3.new(-4156.7, 368.1, 1302.4),
{pos = Vector3.new(-4057.7, 368.1, 1302.3), action = "jump"},
Vector3.new(-4057.7, 368.1, 1302.3),
Vector3.new(-4026.8, 372.2, 1301.6),
Vector3.new(-4015.1, 390.5, 1305.8),
Vector3.new(-4008.8, 390.5, 1304.9),
Vector3.new(-4010.7, 390.5, 1324.4),
{pos = Vector3.new(-4007.5, 390.5, 1430.8), action = "jump"},
Vector3.new(-4007.5, 390.5, 1430.8),
Vector3.new(-4009.3, 390.5, 1475.4),
{pos = Vector3.new(-4011.0, 390.5, 1573.1), action = "jump"},
Vector3.new(-4011.0, 390.5, 1573.1),
Vector3.new(-4008.4, 390.5, 1608.7),
Vector3.new(-4018.8, 390.5, 1607.8),
{pos = Vector3.new(-4127.7, 392.1, 1606.7), action = "jump"},
Vector3.new(-4127.7, 392.1, 1606.7),
Vector3.new(-4172.0, 399.0, 1610.4),
{pos = Vector3.new(-4302.3, 392.0, 1609.4), action = "jump"},
Vector3.new(-4302.3, 392.0, 1609.4),
Vector3.new(-4349.1, 398.8, 1606.7),
Vector3.new(-4348.7, 405.2, 1574.1),
{pos = Vector3.new(-4347.5, 407.2, 1456.2), action = "jump"},
Vector3.new(-4347.5, 407.2, 1456.2),
Vector3.new(-4346.8, 433.2, 1403.5),
Vector3.new(-4346.6, 433.2, 1392.2),
Vector3.new(-4327.6, 433.3, 1393.7),
{pos = Vector3.new(-4245.0, 433.5, 1395.2), action = "jump"},
Vector3.new(-4245.0, 433.5, 1395.2),
Vector3.new(-4221.1, 440.6, 1395.4),
{pos = Vector3.new(-4125.8, 441.8, 1388.9), action = "jump"},
Vector3.new(-4125.8, 441.8, 1388.9),
Vector3.new(-4106.8, 449.2, 1405.5),
{pos = Vector3.new(-4047.6, 448.3, 1467.7), action = "jump"},
Vector3.new(-4047.6, 448.3, 1467.7),
Vector3.new(-4051.7, 456.3, 1494.7),
{pos = Vector3.new(-4089.5, 452.3, 1576.7), action = "jump"},
Vector3.new(-4089.5, 452.3, 1576.7),
Vector3.new(-4112.4, 451.8, 1575.1),
{pos = Vector3.new(-4162.1, 453.7, 1544.7), action = "jump"},
Vector3.new(-4162.1, 453.7, 1544.7),
Vector3.new(-4189.1, 452.7, 1548.2),
{pos = Vector3.new(-4255.8, 455.6, 1528.9), action = "jump"},
Vector3.new(-4255.8, 455.6, 1528.9),
Vector3.new(-4312.2, 472.3, 1531.3),
Vector3.new(-4362.4, 469.6, 1530.6),
Vector3.new(-4391.7, 469.6, 1531.3),
Vector3.new(-4591.4, 469.7, 1522.8),
Vector3.new(-4576.0, 469.7, 1347.0),
Vector3.new(-4525.8, 469.7, 1348.6),
Vector3.new(-4523.9, 469.7, 1451.8),
Vector3.new(-4466.1, 469.7, 1454.7),
Vector3.new(-4475.8, 469.7, 1133.2),
Vector3.new(-4747.6, 469.7, 1148.8),
Vector3.new(-4732.9, 469.7, 1407.4),
Vector3.new(-4907.9, 469.7, 1393.1),
Vector3.new(-4904.1, 469.7, 1609.7),
Vector3.new(-5037.3, 572.8, 1623.2),
Vector3.new(-5040.8, 467.8, 1147.1),
Vector3.new(-5245.3, 467.8, 1131.8),
Vector3.new(-5221.8, 467.8, 1240.2),
Vector3.new(-5155.0, 467.8, 1245.0),
Vector3.new(-5159.7, 467.8, 1383.7),
Vector3.new(-5229.3, 467.8, 1376.9),
Vector3.new(-5224.9, 467.8, 1462.1),
Vector3.new(-5287.1, 467.8, 1468.0),
                Vector3.new(-5336.2, 469.2, 1475.3),
        Vector3.new(-5340.4, 469.6, 1459.4),
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
    Values = { "Pilihan 1", "Pilihan 2", "Pilihan 3", "Pilihan 4", "Pilihan 5", "Pilihan 6", "Pilihan 7", "Pilihan 8", "Pilihan 9", "Pilihan 10", "Pilihan 11", "Pilihan 12"},
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
                    -- MODE LOMPAT KILAT & PRESISI (ANTI-BUG DETEKSI MATI)
                    -- ================================================================
                    local character = LocalPlayer.Character
                    local humanoid = character and character:FindFirstChild("Humanoid")
                    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                    
                    if character and humanoid and rootPart and humanoid.Health > 0 then
                        humanoid.Jump = true 
                        
                        local startPos = rootPart.Position
                        local distance = (targetPos - startPos).Magnitude
                        
                        local duration = math.clamp(distance / 150, 0.15, 0.4)
                        local elapsed = 0
                        
                        while elapsed < duration and isRunning do
                            -- FIX BUG: Cek berkala apakah mati saat sedang meluncur di udara
                            if not humanoid or humanoid.Health <= 0 or not rootPart or not rootPart.Parent then
                                playerDied = true
                                break
                            end
                            
                            local dt = task.wait()
                            elapsed = elapsed + dt
                            local t = math.clamp(elapsed / duration, 0, 1)
                            
                            local peakHeight = math.clamp(distance * 0.08, 2, 6)
                            local currentArc = math.sin(t * math.pi) * peakHeight
                            
                            local currentLerp = startPos:Lerp(targetPos, t)
                            rootPart.CFrame = CFrame.new(currentLerp.X, currentLerp.Y + currentArc, currentLerp.Z) * rootPart.CFrame.Rotation
                            rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        end
                        
                        -- KUNCI POSISI MUTLAK (Jika masih hidup)
                        if isRunning and not playerDied and humanoid and humanoid.Health > 0 and rootPart then
                            rootPart.CFrame = CFrame.new(targetPos) * rootPart.CFrame.Rotation
                            rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                            task.wait(0.02)
                        end
                    else
                        playerDied = true
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
                
                -- [LOGIK RESPONDING RE-RUN] Menunggu respawn sempurna jika mati
                if playerDied then
                    print("[MATI] Karaktermu mati! Menunggu respawn otomatis...")
                    LocalPlayer.CharacterAdded:Wait() -- Menunggu tubuh baru terbuat sempurna
                    task.wait(2) -- Delay aman agar game memuat physics karakter baru
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

-- TOGGLE UNTUK MEMULAI PERJALANAN
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
