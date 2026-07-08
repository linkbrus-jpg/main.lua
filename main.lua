-- ==========================================
-- 1. SETUP SERVICES & VARIABLES
-- ==========================================
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Menggunakan gethui() agar kompatibel dengan semua executor
local TargetGui = (gethui and gethui()) or game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

-- ==========================================
-- 2. SETUP WINDUI & WINDOW UTAMA
-- ==========================================
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "My Super Hub",
    Icon = "door-open",
    Author = "by .ftgs and .ftgs",
})

Window:DisableTopbarButtons({
    "Close", 
    "Minimize", 
    "Fullscreen",
})

local Tab = Window:Tab({
    Title = "Auto Farm",
    Icon = "bird",
    Locked = false,
})

-- ==========================================
-- 3. SETUP TOMBOL FLOATING (DRAGGABLE) & TOGGLE UI
-- ==========================================
local ToggleGui = Instance.new("ScreenGui")
ToggleGui.Name = "WindUIToggleGui"
ToggleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ToggleGui.Parent = TargetGui

local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Parent = ToggleGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BackgroundTransparency = 0 
ToggleBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Image = "rbxassetid://116624035538123"

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12) 
UICorner.Parent = ToggleBtn

-- Logika Drag
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    ToggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleBtn.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

ToggleBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Logika Toggle Open/Close WindUI
local uiVisible = true
ToggleBtn.MouseButton1Click:Connect(function()
    if not dragging then 
        uiVisible = not uiVisible
        for _, gui in pairs(TargetGui:GetChildren()) do
            if gui:IsA("ScreenGui") and (gui.Name == "WindUI" or gui:FindFirstChild("Main")) then
                gui.Enabled = uiVisible
            end
        end
    end
end)

-- ==========================================
-- 4. VARIABEL & MENU AUTO FARM (WINDUI ELEMENTS)
-- ==========================================
local autoPickupEnabled = false
local autoSellEnabled = false
local autoRebirthEnabled = false
local autoTrainingEnabled = false 
local selectedItems = {}
local maxPickupLimit = 4 

-- AMAN: Mengambil opsi dropdown secara dinamis dengan proteksi Timeout agar tidak stuck di Baseplate
local itemOptions = {}
local assetsFolder = ReplicatedStorage:WaitForChild("Assets", 3) -- Maksimal hanya menunggu 3 detik
local itemsFolder = assetsFolder and assetsFolder:WaitForChild("Items", 3)

if itemsFolder then
    for _, item in ipairs(itemsFolder:GetChildren()) do
        if not table.find(itemOptions, item.Name) then
            table.insert(itemOptions, item.Name)
        end
    end
else
    -- Fallback opsi jika dijalankan di baseplate kosong agar UI tidak rusak/kosong
    table.insert(itemOptions, "Tidak ada item terdeteksi")
end

local Dropdown = Tab:Dropdown({
    Title = "Pilih Varian Item",
    Desc = "Pilih item yang terdeteksi di dalam game",
    Values = itemOptions,
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(options) 
        selectedItems = options
    end
})

local ToggleFarm = Tab:Toggle({
    Title = "Auto Pickup & Break Stages",
    Desc = "Hancurkan part dari ATAS sampai stage item lalu ambil item",
    Icon = "hand",
    Type = "Checkbox",
    Value = false,
    Callback = function(state) 
        autoPickupEnabled = state
        WindUI:Notify({
            Title = "Auto Pickup",
            Content = state and "Fitur Auto Pickup Diaktifkan!" or "Fitur Auto Pickup Dimatikan!",
            Duration = 2,
            Icon = state and "check" or "x",
        })
    end
})

local InputLimit = Tab:Input({
    Title = "Jumlah Item Sekali Jalan",
    Desc = "Berapa banyak item yang diambil sebelum kembali ke Surface",
    Value = tostring(maxPickupLimit),
    InputIcon = "hash",
    Type = "Input",
    Placeholder = "Masukkan angka (Default: 4)",
    Callback = function(input) 
        local parsed = tonumber(input)
        if parsed and parsed > 0 then
            maxPickupLimit = parsed
        end
    end
})

local ToggleSell = Tab:Toggle({
    Title = "Auto Sell",
    Desc = "Otomatis menjual loot (Sangat cocok digabung dengan Auto Farm)",
    Icon = "coins",
    Type = "Checkbox",
    Value = false,
    Callback = function(state) 
        autoSellEnabled = state
        WindUI:Notify({
            Title = "Auto Sell",
            Content = state and "Fitur Auto Sell Diaktifkan!" or "Fitur Auto Sell Dimatikan!",
            Duration = 2,
            Icon = state and "check" or "x",
        })
    end
})

local ToggleRebirth = Tab:Toggle({
    Title = "Auto Rebirth",
    Desc = "Otomatis Rebirth jika syarat terpenuhi",
    Icon = "refresh-cw",
    Type = "Checkbox",
    Value = false,
    Callback = function(state) 
        autoRebirthEnabled = state
        WindUI:Notify({
            Title = "Auto Rebirth",
            Content = state and "Fitur Auto Rebirth Diaktifkan!" or "Fitur Auto Rebirth Dimatikan!",
            Duration = 2,
            Icon = state and "check" or "x",
        })
    end
})

local ToggleTraining = Tab:Toggle({
    Title = "Auto Click Training Area",
    Desc = "Bypass animasi! Super Spam klik otomatis saat di area Training",
    Icon = "mouse-pointer-2",
    Type = "Checkbox",
    Value = false,
    Callback = function(state) 
        autoTrainingEnabled = state
        WindUI:Notify({
            Title = "Auto Training",
            Content = state and "Fitur Auto Training Diaktifkan!" or "Fitur Auto Training Dimatikan!",
            Duration = 2,
            Icon = state and "check" or "x",
        })
    end
})

-- ==========================================
-- 5. FUNGSI-FUNGSI PENDUKUNG LOKAL
-- ==========================================

-- Fungsi Baru: Mendeteksi apakah target ada di arah depan player berdiri
local function isInFront(rootPart, targetPos)
    if not rootPart then return false end
    
    -- Mengabaikan sumbu Y untuk memastikan deteksi murni horizontal depan/belakang
    local targetDir = (Vector3.new(targetPos.X, rootPart.Position.Y, targetPos.Z) - rootPart.Position).Unit
    local lookDir = Vector3.new(rootPart.CFrame.LookVector.X, 0, rootPart.CFrame.LookVector.Z).Unit
    
    -- Mencegah error NaN jika posisinya menumpuk persis
    if targetDir.Magnitude ~= targetDir.Magnitude then return true end
    
    local dot = lookDir:Dot(targetDir)
    -- Angka > 0.3 berarti item ada di dalam kerucut pandang depan yang wajar (~70 derajat)
    return dot > 0.3
end

local function isSelectedItem(itemName)
    if #selectedItems == 0 then return false end
    for _, selected in ipairs(selectedItems) do
        if string.find(string.lower(itemName), string.lower(selected)) then
            return true
        end
    end
    return false
end

local function breakTarget(targetObject)
    if not targetObject then return end

    local isPart = targetObject:IsA("BasePart")
    if isPart and (targetObject.Transparency >= 1 or not targetObject.CanCollide) then
        return 
    end

    local character = LocalPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChild("Humanoid")

    while targetObject and targetObject.Parent and autoPickupEnabled and rootPart and humanoid do
        
        if isPart and (targetObject.Transparency >= 1 or not targetObject.CanCollide) then
            break 
        end
        
        rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)

        local success, targetCFrame = pcall(function() return targetObject:GetPivot() end)
        if success and targetCFrame then
            local targetPos = targetCFrame.Position
            rootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 4.5, 0))
        else
            break 
        end
        
        local tool = character:FindFirstChildOfClass("Tool")
        if not tool then
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            if backpack then
                tool = backpack:FindFirstChildOfClass("Tool")
                if tool then
                    humanoid:EquipTool(tool)
                end
            end
        end
        
        if tool then
            tool:Activate()
        end
        
        local cd = targetObject:FindFirstChildOfClass("ClickDetector")
        if cd then fireclickdetector(cd) end
        
        local prompt = targetObject:FindFirstChildOfClass("ProximityPrompt")
        if prompt then
            local old = prompt.HoldDuration
            prompt.HoldDuration = 0
            fireproximityprompt(prompt)
            prompt.HoldDuration = old
        end
        
        task.wait()
    end
end

local function getTargetStageLimit(targetPos)
    local stagesFolder = workspace:FindFirstChild("Stages")
    if not stagesFolder then return 50 end 
    
    local closestStage = 50
    local minDistance = math.huge
    
    for _, stageModel in ipairs(stagesFolder:GetChildren()) do
        if string.match(stageModel.Name, "Stage %d+") then
            local stageNum = tonumber(string.match(stageModel.Name, "%d+"))
            if stageNum then
                local refPart = stageModel:FindFirstChild("Hitbox") or stageModel:FindFirstChildWhichIsA("BasePart", true)
                if refPart then
                    local dist = (refPart.Position - targetPos).Magnitude
                    if dist < minDistance then
                        minDistance = dist
                        closestStage = stageNum
                    end
                end
            end
        end
    end
    
    return closestStage
end

local function returnToSurface()
    local success, err = pcall(function()
        local gotoRemote = ReplicatedStorage.Remotes.Server.GotoSurface
        if gotoRemote:IsA("RemoteEvent") then
            gotoRemote:FireServer()
        elseif gotoRemote:IsA("RemoteFunction") then
            gotoRemote:InvokeServer()
        end
    end)
    
    if success then
        WindUI:Notify({
            Title = "Teleport Surface",
            Content = "Berhasil kembali ke permukaan!",
            Duration = 3,
            Icon = "arrow-up",
        })
        task.wait(4)
    end
end

local function clearStages(maxStage)
    local stagesFolder = workspace:FindFirstChild("Stages")
    if not stagesFolder then return end

    for i = 1, maxStage do
        if not autoPickupEnabled then break end
        
        local stageName = "Stage " .. tostring(i)
        local mainStage = stagesFolder:FindFirstChild(stageName)
        
        if mainStage then
            local subStagesFolder = mainStage:FindFirstChild("Stages")
            if subStagesFolder then
                for subI = 1, 3 do
                    local subPart = subStagesFolder:FindFirstChild(tostring(subI))
                    if subPart then
                        breakTarget(subPart)
                    end
                end
            end
            
            local hitbox = mainStage:FindFirstChild("Hitbox")
            if hitbox then
                breakTarget(hitbox)
            end
        end
    end
end

-- ==========================================
-- 6. LOOP UTAMA (BACKGROUND TASKS)
-- ==========================================

-- Loop Auto Sell & Rebirth
task.spawn(function()
    while task.wait(1) do
        if autoSellEnabled then
            pcall(function()
                local sellRemote = ReplicatedStorage.Remotes.Server.SellAllLoot
                if sellRemote:IsA("RemoteEvent") then
                    sellRemote:FireServer()
                elseif sellRemote:IsA("RemoteFunction") then
                    sellRemote:InvokeServer()
                end
            end)
        end
        
        if autoRebirthEnabled then
            pcall(function()
                local rebirthRemote = ReplicatedStorage.Remotes.Server.Rebirth
                if rebirthRemote:IsA("RemoteEvent") then
                    rebirthRemote:FireServer()
                elseif rebirthRemote:IsA("RemoteFunction") then
                    rebirthRemote:InvokeServer()
                end
            end)
        end
    end
end)

-- Loop Auto Training
task.spawn(function()
    local clickRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Server"):WaitForChild("Click")
    
    while task.wait() do 
        if autoTrainingEnabled then
            local character = LocalPlayer.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            local mapFolder = workspace:FindFirstChild("Map")
            local trainingAreas = mapFolder and mapFolder:FindFirstChild("Training Areas")

            if rootPart and trainingAreas then
                local isInArea = false
                
                for _, area in ipairs(trainingAreas:GetChildren()) do
                    local hitbox = area:FindFirstChild("Hitbox")
                    if hitbox and (hitbox.Position - rootPart.Position).Magnitude <= 50 then
                        isInArea = true
                        break 
                    end
                end

                if isInArea then
                    pcall(function()
                        clickRemote:FireServer()
                    end)
                    
                    local tool = character:FindFirstChildOfClass("Tool")
                    if tool then 
                        tool:Activate() 
                    end
                end
            end
        end
    end
end)

-- Loop Auto Farm (Telah Diperbarui Sesuai Request)
task.spawn(function()
    local streamingFolder = ReplicatedStorage:WaitForChild("Streaming")
    local currentPickupCount = 0 
    
    while task.wait(0.1) do
        if autoPickupEnabled then
            local character = LocalPlayer.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            if not rootPart then continue end

            -- 1. Mengumpulkan semua item yang valid dan sedang spawn
            local validItems = {}
            for _, container in ipairs(streamingFolder:GetChildren()) do
                for _, item in ipairs(container:GetChildren()) do
                    if isSelectedItem(item.Name) and item.Parent then
                        local prompt = item:FindFirstChildOfClass("ProximityPrompt")
                        if prompt then
                            local itemSuccess, itemCFrame = pcall(function() return item:GetPivot() end)
                            if itemSuccess and itemCFrame then
                                local targetStageNum = getTargetStageLimit(itemCFrame.Position)
                                table.insert(validItems, {
                                    Instance = item,
                                    Position = itemCFrame.Position,
                                    Stage = targetStageNum,
                                    Prompt = prompt
                                })
                            end
                        end
                    end
                end
            end

            -- 2. Mengurutkan item dengan logika: Stage Saat Ini -> Arah Depan -> Jarak Terdekat
            table.sort(validItems, function(a, b)
                if a.Stage == b.Stage then
                    local aFront = isInFront(rootPart, a.Position)
                    local bFront = isInFront(rootPart, b.Position)
                    
                    -- Prioritaskan item yang ada di DEPAN
                    if aFront and not bFront then return true end
                    if bFront and not aFront then return false end
                    
                    -- Jika keduanya sama-sama di depan / sama-sama tidak, ambil jarak terdekat
                    local distA = (a.Position - rootPart.Position).Magnitude
                    local distB = (b.Position - rootPart.Position).Magnitude
                    return distA < distB
                end
                -- Prioritaskan stage paling awal
                return a.Stage < b.Stage
            end)

            -- 3. Eksekusi pada target pertama (yang paling memenuhi kriteria di atas)
            if #validItems > 0 then
                local targetData = validItems[1]
                local item = targetData.Instance
                local prompt = targetData.Prompt

                clearStages(targetData.Stage)
                
                if not autoPickupEnabled then continue end
                
                rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                rootPart.CFrame = CFrame.new(targetData.Position)
                task.wait(0.25)
                
                local originalHold = prompt.HoldDuration
                prompt.HoldDuration = 0
                
                fireproximityprompt(prompt)
                prompt.HoldDuration = originalHold
                
                task.wait(0.2) 
                
                currentPickupCount = currentPickupCount + 1
                
                WindUI:Notify({
                    Title = "Item Looted!",
                    Content = "Berhasil mengambil: " .. item.Name,
                    Duration = 2,
                    Icon = "package",
                })
                
                if currentPickupCount >= maxPickupLimit then
                    returnToSurface()
                    currentPickupCount = 0 
                end
            end
        end
    end
end)
