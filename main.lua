-- Rayfield UI読み込み（Rayfieldライブラリのパスは環境に合わせてください）
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
    Name = "Pixel Blade - Auto Script",
    LoadingTitle = "Pixel Blade Script",
    LoadingSubtitle = "by ChatGPT",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PixelBladeScripts",
        FileName = "Config"
    },
    Discord = {
        Enabled = false
    }
})

-- 変数
local AutoAttackEnabled = false
local AutoChestEnabled = false
local AutoPickupEnabled = false
local AutoUpgradeEnabled = false
local AutoStatAllocateEnabled = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ヘルパー関数
local function getNearestEnemy()
    local closest = nil
    local dist = math.huge
    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
        if enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
            local distance = (HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
            if distance < dist then
                dist = distance
                closest = enemy
            end
        end
    end
    return closest
end

-- オート攻撃処理
spawn(function()
    while wait(0.1) do
        if AutoAttackEnabled then
            local enemy = getNearestEnemy()
            if enemy then
                -- 攻撃関数呼び出し（ゲーム固有の攻撃関数に置き換えてください）
                -- 例: LocalPlayer.Character.Humanoid:MoveTo(enemy.HumanoidRootPart.Position)
                -- ここはゲームに合わせて調整が必要です
            end
        end
    end
end)

-- UI作成
local Tab = Window:CreateTab("Main", 4483362458) -- アイコンIDは任意

-- オート攻撃トグル
Tab:CreateToggle({
    Name = "Auto Attack",
    CurrentValue = false,
    Flag = "AutoAttack",
    Callback = function(value)
        AutoAttackEnabled = value
    end,
})

-- オートチェストトグル
Tab:CreateToggle({
    Name = "Auto Chest",
    CurrentValue = false,
    Flag = "AutoChest",
    Callback = function(value)
        AutoChestEnabled = value
    end,
})

-- オート拾得トグル
Tab:CreateToggle({
    Name = "Auto Pickup",
    CurrentValue = false,
    Flag = "AutoPickup",
    Callback = function(value)
        AutoPickupEnabled = value
    end,
})

-- 自動装備強化トグル
Tab:CreateToggle({
    Name = "Auto Upgrade Gear",
    CurrentValue = false,
    Flag = "AutoUpgrade",
    Callback = function(value)
        AutoUpgradeEnabled = value
    end,
})

-- ステータス自動振り分けトグル
Tab:CreateToggle({
    Name = "Auto Stat Allocate",
    CurrentValue = false,
    Flag = "AutoStatAllocate",
    Callback = function(value)
        AutoStatAllocateEnabled = value
    end,
})

-- スピード調整スライダー
local speed = 16
Tab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 100},
    Increment = 1,
    Suffix = "speed",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(value)
        speed = value
        if Character and Character:FindFirstChild("Humanoid") then
            Character.Humanoid.WalkSpeed = speed
        end
    end,
})

-- テレポート機能（サンプルとして座標入力）
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
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            Character.HumanoidRootPart.CFrame = CFrame.new(teleportX, teleportY, teleportZ)
        end
    end,
})

print("Pixel Blade Auto Script loaded!")

