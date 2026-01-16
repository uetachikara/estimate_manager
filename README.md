# README
# Estimate Manager（見積・案件管理アプリ）

Estimate Manager は、**取引先・案件・見積を一元管理する業務向けWebアプリケーション**です。  
実務での利用を想定し、UI・設計・テストまで含めて実装しています。

---

## アプリ概要

- 取引先（Client）管理
- 案件（Project）管理
- 見積（Quote）管理
- ステータス管理（enum + 日本語表示）
- ユーザー認証（Devise）
- system spec による E2E テスト

---

## 使用技術

- Ruby 3.3
- Ruby on Rails 8.1
- MySQL
- Bootstrap 5
- Devise
- RSpec / Capybara

---

## 主な機能

### 認証機能
- ログイン / ログアウト
- 新規ユーザー登録
- パスワード再設定
- 業務アプリを意識したログイン画面UI

### 取引先管理
- 取引先の登録 / 編集 / 削除
- 一覧画面で案件数を表示
- N+1 を避けたクエリ設計

### 案件管理
- 案件の登録 / 編集
- ステータス管理（リード / 進行中 / 完了）
- ステータスは **色付きバッジ + 日本語表示**

### 見積管理
- 見積の登録 / 編集
- ステータス管理（下書き / 送付済み / 受注 / 失注）
- 金額を業務向け表示形式で表示

---

## テスト

### System Spec（E2Eテスト）

ユーザー操作による一連の業務フローを system spec で検証しています。

bundle exec rspec spec/system/estimate_flow_spec.rb
テスト内容
ユーザーがログインできる

取引先を作成できる

案件を作成できる

見積を作成できる

セットアップ手順
bash
コードをコピーする
git clone https://github.com/uetachikara/estimate_manager.git
cd estimate_manager

bundle install
rails db:create db:migrate
bin/dev
ブラウザで以下にアクセスしてください。

text
コードをコピーする
http://localhost:3000
設計・実装で意識した点
業務アプリとしての視認性

ステータスの色分け

一覧・詳細画面の役割を明確化

保守性

enum + I18n による日本語化

表示ロジックは model に集約

品質

system spec による E2E テスト

N+1 を避けた実装

今後の改善案
権限管理（管理者 / 一般ユーザー）

見積の PDF 出力

検索・絞り込み機能

本番環境へのデプロイ

作者
GitHub: https://github.com/uetachikara



