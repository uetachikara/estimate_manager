# Estimate Manager

取引先・案件・見積を一元管理できる **見積管理Webアプリケーション**です。  
実務での利用を想定し、設計・UI・テストまで含めて実装しています。

---

## 📌 概要

Estimate Manager は、以下の業務フローをシンプルに管理できます。

- 取引先を登録する
- 取引先に紐づく案件を管理する
- 案件ごとに見積を作成・管理する
- 見積明細を複数行入力し、金額を自動計算する

---

## ✨ 主な機能

### 🔐 認証機能
- ユーザー登録 / ログイン / ログアウト
- パスワード再設定
- ユーザーごとのデータ分離

### 🏢 取引先管理
- 取引先の登録 / 編集 / 削除
- 一覧・詳細表示
- 案件との関連付け

### 📁 案件管理
- 案件の登録 / 編集 / 削除
- ステータス管理（日本語表示）
  - リード
  - 進行中
  - 完了
- ステータスは色付きバッジで表示

### 🧾 見積管理
- 見積の登録 / 編集 / 削除
- 見積番号の管理
- ステータス管理
  - 下書き
  - 送付済み
  - 受注
  - 失注
- 見積明細を複数行登録可能
  - 内容
  - 数量
  - 単価
- 小計・消費税・合計金額を自動計算
- Stimulus による明細の動的追加（＋ボタン）

---

## 🎨 UI / UX
- Bootstrap を利用したシンプルで業務向けのUI
- 日本語UI（I18n対応）
- 入力・確認のしやすさを重視した画面構成
- ステータスの視認性を高めるバッジ表示

---

## 🛠 技術スタック

| 分類 | 技術 |
|---|---|
| Backend | Ruby 3.3 / Ruby on Rails 8.1 |
| Database | MySQL |
| 認証 | Devise |
| Frontend | ERB / Bootstrap 5 |
| JavaScript | Hotwire（Turbo / Stimulus） |
| テスト | RSpec（System Spec） |
| その他 | Importmap / I18n |

---

## 🗂 データ構成

- User
  - has_many :clients
  - has_many :projects
  - has_many :quotes

- Client（取引先）
  - belongs_to :user
  - has_many :projects

- Project（案件）
  - belongs_to :client
  - belongs_to :user
  - has_many :quotes
  - enum :status

- Quote（見積）
  - belongs_to :project
  - belongs_to :user
  - has_many :quote_items
  - enum :status

- QuoteItem（見積明細）
  - belongs_to :quote
  - 金額は Quote モデル側で集計

---

## 🚀 セットアップ

```bash
git clone https://github.com/uetachikara/estimate_manager.git
cd estimate_manager

bundle install
rails db:create
rails db:migrate

rails s
