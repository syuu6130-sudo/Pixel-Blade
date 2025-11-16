# Pixel Blade Auto Script

Roblox Pixel Blade用の自動化スクリプト（Krnl対応）

## 機能

- ✅ Auto Attack（自動攻撃）
- ✅ Auto Chest（自動チェスト回収）
- ✅ Auto Pickup（自動アイテム拾得）
- ✅ Auto Upgrade Gear（自動装備強化）
- ✅ Auto Stat Allocate（自動ステータス振り分け）
- ✅ Walk Speed調整
- ✅ テレポート機能

## インストール方法

### 方法1: loadstring（推奨）

```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/あなたのユーザー名/pixel-blade-script/main/script.lua'))()
```

### 方法2: 直接コピー

1. [script.lua](script.lua)の内容をコピー
2. エクスプロイトに貼り付けて実行

## 対応エクスプロイト

- Krnl
- Synapse X
- Script-Ware
- その他主要なエクスプロイト

## 使用方法

1. Pixel Bladeに参加
2. エクスプロイトでスクリプトを実行
3. UIが表示されたら各機能をオン/オフで切り替え

### 各機能の説明

#### Auto Attack
最も近い敵を自動で攻撃します

#### Auto Chest
マップ上のチェストを自動で回収します

#### Auto Pickup
ドロップアイテムを自動で拾得します

#### Walk Speed
移動速度を16〜100の範囲で調整できます

#### テレポート
X, Y, Z座標を入力して任意の場所にテレポートできます

## 注意事項

⚠️ **重要**: このスクリプトの使用は自己責任でお願いします。
- アカウントBANのリスクがあります
- 公式ゲームの利用規約に違反する可能性があります
- 教育目的でのみ使用してください

## カスタマイズ

ゲーム固有の機能を追加したい場合は、`script.lua`を編集してください。

### 攻撃処理のカスタマイズ例

```lua
-- 49行目付近
local attackRemote = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Attack")
attackRemote:FireServer(enemy)
```

## 更新履歴

### v1.0.0 (2025-11-16)
- 初回リリース
- 基本機能実装

## ライセンス

MIT License

## 免責事項

このスクリプトは教育目的で作成されています。使用による如何なる損害についても、作成者は責任を負いません。

## サポート

問題が発生した場合は、[Issues](https://github.com/あなたのユーザー名/pixel-blade-script/issues)で報告してください。

---

## ファイル構造

```
pixel-blade-script/
├── README.md          # このファイル
├── script.lua         # メインスクリプト
├── LICENSE            # ライセンスファイル
└── .gitignore         # Git除外設定
```

## 貢献

プルリクエストを歓迎します！大きな変更の場合は、まずissueを開いて変更内容を議論してください。

## 作者

Created with ❤️ by ChatGPT

## スター⭐をお願いします！

このプロジェクトが役に立った場合は、GitHubでスターをつけてください！
