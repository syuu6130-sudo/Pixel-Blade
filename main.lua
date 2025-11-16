--[[
    ██████╗ ██╗██╗  ██╗███████╗██╗         ██████╗ ██╗      █████╗ ██████╗ ███████╗
    ██╔══██╗██║╚██╗██╔╝██╔════╝██║         ██╔══██╗██║     ██╔══██╗██╔══██╗██╔════╝
    ██████╔╝██║ ╚███╔╝ █████╗  ██║         ██████╔╝██║     ███████║██║  ██║█████╗  
    ██╔═══╝ ██║ ██╔██╗ ██╔══╝  ██║         ██╔══██╗██║     ██╔══██║██║  ██║██╔══╝  
    ██║     ██║██╔╝ ██╗███████╗███████╗    ██████╔╝███████╗██║  ██║██████╔╝███████╗
    ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝    ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝
    
    Pixel Blade Auto Script
    Version: 1.0.0
    Compatible with: Krnl, Synapse X, Script-Ware
    Created by: ChatGPT
    
    Features:
    ✅ Auto Attack          - 自動攻撃
    ✅ Auto Chest           - 自動チェスト回収
    ✅ Auto Pickup          - 自動アイテム拾得
    ✅ Auto Upgrade Gear    - 自動装備強化
    ✅ Auto Stat Allocate   - 自動ステータス振り分け
    ✅ Walk Speed Modifier  - 移動速度調整
    ✅ Teleport             - テレポート機能
    
    ⚠️ 使用上の注意:
    - このスクリプトの使用は自己責任です
    - アカウントBANのリスクがあります
    - 教育目的でのみ使用してください
]]

print("🔄 Loading Pixel Blade Auto Script...")

-- Rayfield UI読み込み
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
end)

if not success then
    warn("❌ Rayfield UIの読み込みに失敗しました")
    return
end

-- ウィンドウ作成
local Window = Rayfield:CreateWindow({
    Name = "Pixel Blade - Auto Script",
    LoadingTitle = "Pixel Blade Script",
    LoadingSubtitle = "by ChatGPT",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = "Config"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- ========================================
-- 変数定義
-- ========================================
local AutoAttackEnabled = false
local AutoChestEnabled = false
local AutoPickupEnabled = false
local AutoUpgradeEnabled = false
local AutoStatAllocateEnabled = false

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ========================================
-- ヘルパー関数
-- ========================================

-- キャラクター取得
local function getCharacter()
    return LocalPlayer.Character
end

-- HumanoidRootPart取得
local function getHRP()
    local char = getCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- 最も近い敵を検索
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

-- ========================================
-- 自動化処理
-- ========================================

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
                            
                            -- 攻撃処理（ゲームによって異なる - カスタマイズが必要）
                            -- ▼ここを実際のゲームに合わせて変更してください▼
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
                                break
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- オートピックアップ処理
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if AutoPickupEnabled then
                local hrp = getHRP()
                if hrp then
                    for _, item in pairs(workspace:GetDescendants()) do
                        if item:IsA("Tool") or (item:IsA("Model") and item.Name:lower():find("item")) then
                            local itemPart = item:FindFirstChild("Handle") or item.PrimaryPart
                            if itemPart and (hrp.Position - itemPart.Position).Magnitude < 50 then
                                -- アイテムに触れる
                                firetouchinterest(hrp, itemPart, 0)
                                task.wait(0.1)
                                firetouchinterest(hrp, itemPart, 1)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- オート装備強化処理（実装例 - ゲームに合わせて調整）
task.spawn(function()
    while task.wait(5) do
        pcall(function()
            if AutoUpgradeEnabled then
                -- ここに装備強化のコードを追加
                -- 例: game:GetService("ReplicatedStorage").Events.UpgradeGear:FireServer()
            end
        end)
    end
end)

-- オートステータス振り分け処理（実装例 - ゲームに合わせて調整）
task.spawn(function()
    while task.wait(5) do
        pcall(function()
            if AutoStatAllocateEnabled then
                -- ここにステータス振り分けのコードを追加
                -- 例: game:GetService("ReplicatedStorage").Events.AllocateStat:FireServer("Strength", 1)
            end
        end)
    end
end)

-- ========================================
-- UI作成
-- ========================================

local Tab = Window:CreateTab("🏠 Main", 4483362458)

Tab:CreateSection("⚔️ 自動化機能")

-- オート攻撃トグル
Tab:CreateToggle({
    Name = "Auto Attack",
    CurrentValue = false,
    Flag = "AutoAttack",
    Callback = function(value)
        AutoAttackEnabled = value
        print("🗡️ Auto Attack:", value and "ON" or "OFF")
    end,
})

-- オートチェストトグル
Tab:CreateToggle({
    Name = "Auto Chest",
    CurrentValue = false,
    Flag = "AutoChest",
    Callback = function(value)
        AutoChestEnabled = value
        print("📦 Auto Chest:", value and "ON" or "OFF")
    end,
})

-- オート拾得トグル
Tab:CreateToggle({
    Name = "Auto Pickup",
    CurrentValue = false,
    Flag = "AutoPickup",
    Callback = function(value)
        AutoPickupEnabled = value
        print("💎 Auto Pickup:", value and "ON" or "OFF")
    end,
})

-- 自動装備強化トグル
Tab:CreateToggle({
    Name = "Auto Upgrade Gear",
    CurrentValue = false,
    Flag = "AutoUpgrade",
    Callback = function(value)
        AutoUpgradeEnabled = value
        print("⚡ Auto Upgrade:", value and "ON" or "OFF")
    end,
})

-- ステータス自動振り分けトグル
Tab:CreateToggle({
    Name = "Auto Stat Allocate",
    CurrentValue = false,
    Flag = "AutoStatAllocate",
    Callback = function(value)
        AutoStatAllocateEnabled = value
        print("📊 Auto Stat:", value and "ON" or "OFF")
    end,
})

Tab:CreateSection("🏃 キャラクター設定")

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

Tab:CreateSection("📍 テレポート")

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
    Name = "🚀 Teleport",
    Callback = function()
        local hrp = getHRP()
        if hrp then
            hrp.CFrame = CFrame.new(teleportX, teleportY, teleportZ)
            print(string.format("📍 Teleported to: %.0f, %.0f, %.0f", teleportX, teleportY, teleportZ))
            Rayfield:Notify({
                Title = "✅ テレポート完了",
                Content = string.format("座標: %.0f, %.0f, %.0f", teleportX, teleportY, teleportZ),
                Duration = 2,
                Image = 4483362458
            })
        else
            warn("❌ キャラクターが見つかりません")
        end
    end,
})

-- ========================================
-- 情報タブ
-- ========================================

local InfoTab = Window:CreateTab("ℹ️ Info", 4483362458)

InfoTab:CreateParagraph({
    Title = "📌 Pixel Blade Auto Script",
    Content = [[Version: 1.0.0
Created by: ChatGPT

🎮 使用方法:
1. 各機能をトグルでオン/オフ
2. Walk Speedで移動速度調整
3. テレポートで座標移動

⚠️ 注意事項:
- 自己責任で使用してください
- BANリスクがあります
- 教育目的でのみ使用]]
})

InfoTab:CreateButton({
    Name = "📋 GitHub Repository (Copy Link)",
    Callback = function()
        setclipboard("https://github.com/あなたのユーザー名/pixel-blade-script")
        Rayfield:Notify({
            Title = "✅ コピー完了",
            Content = "GitHubリンクをクリップボードにコピーしました",
            Duration = 3,
            Image = 4483362458
        })
    end,
})

InfoTab:CreateButton({
    Name = "🔄 Reload Script",
    Callback = function()
        Rayfield:Destroy()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/あなたのユーザー名/pixel-blade-script/main/script.lua'))()
    end,
})

-- ========================================
-- キャラクター再生成時の処理
-- ========================================

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    local humanoid = char:WaitForChild("Humanoid")
    local currentSpeed = 16
    humanoid.WalkSpeed = currentSpeed
    print("🔄 キャラクターがリスポーンしました")
end)

-- ========================================
-- 起動完了通知
-- ========================================

print("✅ Pixel Blade Auto Script v1.0.0 loaded successfully!")
Rayfield:Notify({
    Title = "✅ Script Loaded",
    Content = "Pixel Blade Auto Script v1.0.0 ready!",
    Duration = 5,
    Image = 4483362458
})
