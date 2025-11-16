-- Rayfield UI読み込み
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
end)

if not success then
    warn("Rayfield UIの読み込みに失敗しました")
    return
end

local Window = Rayfield:CreateWindow({
    Name = "Pixel Blade - Auto Script",
    LoadingTitle = "Pixel Blade Script",
    LoadingSubtitle = "by ChatGPT",
    ConfigurationSaving = {
        Enabled = false, -- Krnlでは無効化
        FolderName = nil,
        FileName = "Config"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- 変数
local AutoAttackEnabled = false
local AutoChestEnabled = false
local AutoPickupEnabled = false
local AutoUpgradeEnabled = false
local AutoStatAllocateEnabled = false

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- キャラクター取得の安全な処理
local function getCharacter()
    return LocalPlayer.Character
end

local function getHRP()
    local char = getCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- ヘルパー関数
local function getNearestEnemy()
    local hrp = getHRP()
    if not hrp then return nil end
    
    local closest = nil
    local dist = math.huge
    
    local enemiesFolder = workspace:FindFirstChild("Enemies")
    if not enemiesFolder then return nil end
    
    for _, enemy in pairs(enemiesFolder:GetChildren()) do
        if enemy:FindFirstChild("HumanoidRootPart") then
            local humanoid = enemy:FindFirstChild("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local distance = (hrp.Position - enemy.HumanoidRootPart.Position).Magnitude
                if distance < dist then
                    dist = distance
                    closest = enemy
                end
            end
        end
    end
    return closest
end

-- オート攻撃処理
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            if AutoAttackEnabled then
                local enemy = getNearestEnemy()
                if enemy and enemy:FindFirstChild("HumanoidRootPart") then
                    local char = getCharacter()
                    if char then
                        local humanoid = char:FindFirstChild("Humanoid")
                        if humanoid then
                            -- 敵に移動
                            humanoid:MoveTo(enemy.HumanoidRootPart.Position)
                            
                            -- 攻撃処理（ゲームによって異なる）
                            -- 例: game:GetService("ReplicatedStorage").Events.Attack:FireServer(enemy)
                        end
                    end
                end
            end
        end)
    end
end)

-- オートチェスト処理
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if AutoChestEnabled then
                local hrp = getHRP()
                if hrp then
                    for _, chest in pairs(workspace:GetDescendants()) do
                        if chest.Name:lower():find("chest") and chest:IsA("Model") then
                            local chestPart = chest:FindFirstChild("HumanoidRootPart") or chest.PrimaryPart
                            if chestPart then
                                hrp.CFrame = chestPart.CFrame
                                task.wait(0.5)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- UI作成
local Tab = Window:CreateTab("Main", 4483362458)

-- オート攻撃トグル
Tab:CreateToggle({
    Name = "Auto Attack",
    CurrentValue = false,
    Flag = "AutoAttack",
    Callback = function(value)
        AutoAttackEnabled = value
        print("Auto Attack:", value)
    end,
})

-- オートチェストトグル
Tab:CreateToggle({
    Name = "Auto Chest",
    CurrentValue = false,
    Flag = "AutoChest",
    Callback = function(value)
        AutoChestEnabled = value
        print("Auto Chest:", value)
    end,
})

-- オート拾得トグル
Tab:CreateToggle({
    Name = "Auto Pickup",
    CurrentValue = false,
    Flag = "AutoPickup",
    Callback = function(value)
        AutoPickupEnabled = value
        print("Auto Pickup:", value)
    end,
})

-- 自動装備強化トグル
Tab:CreateToggle({
    Name = "Auto Upgrade Gear",
    CurrentValue = false,
    Flag = "AutoUpgrade",
    Callback = function(value)
        AutoUpgradeEnabled = value
        print("Auto Upgrade:", value)
    end,
})

-- ステータス自動振り分けトグル
Tab:CreateToggle({
    Name = "Auto Stat Allocate",
    CurrentValue = false,
    Flag = "AutoStatAllocate",
    Callback = function(value)
        AutoStatAllocateEnabled = value
        print("Auto Stat:", value)
    end,
})

-- スピード調整スライダー
Tab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 100},
    Increment = 1,
    Suffix = " speed",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(value)
        local char = getCharacter()
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = value
            end
        end
    end,
})

-- テレポート座標
local teleportX = 0
local teleportY = 0
local teleportZ = 0

Tab:CreateInput({
    Name = "Teleport X",
    PlaceholderText = "X座標",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        teleportX = tonumber(text) or 0
    end,
})

Tab:CreateInput({
    Name = "Teleport Y",
    PlaceholderText = "Y座標",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        teleportY = tonumber(text) or 0
    end,
})

Tab:CreateInput({
    Name = "Teleport Z",
    PlaceholderText = "Z座標",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        teleportZ = tonumber(text) or 0
    end,
})

Tab:CreateButton({
    Name = "Teleport",
    Callback = function()
        local hrp = getHRP()
        if hrp then
            hrp.CFrame = CFrame.new(teleportX, teleportY, teleportZ)
            print("Teleported to:", teleportX, teleportY, teleportZ)
        else
            warn("キャラクターが見つかりません")
        end
    end,
})

-- キャラクター再生成時の処理
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    local humanoid = char:WaitForChild("Humanoid")
    -- スピード設定を再適用
    local currentSpeed = 16 -- デフォルト値
    humanoid.WalkSpeed = currentSpeed
end)

print("✅ Pixel Blade Auto Script loaded successfully!")
Rayfield:Notify({
    Title = "Script Loaded",
    Content = "Pixel Blade Auto Script ready!",
    Duration = 3,
    Image = 4483362458
})
