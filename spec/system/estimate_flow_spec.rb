require "rails_helper"

RSpec.describe "見積管理フロー", type: :system do
  it "ログインして、取引先→案件→見積を作成できる" do
    # ユーザー作成（Devise）
    user = User.create!(
      email: "test@example.com",
      password: "password",
      password_confirmation: "password"
    )

    # ログイン（UI経由：実務に近い）
    visit new_user_session_path
    fill_in "メールアドレス", with: "test@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"

    # 取引先作成
    click_link "新規登録" # clients/index にある想定
    fill_in "取引先名", with: "株式会社テスト"
    fill_in "担当者", with: "山田 太郎"
    fill_in "電話", with: "03-1234-5678"
    fill_in "メール", with: "taro@example.com"
    find('input[name="commit"],button[name="commit"]').click

    expect(page).to have_content("取引先を登録しました。")
    expect(page).to have_content("株式会社テスト")

    # 取引先一覧へ戻る（ボタン名が違う場合は合わせてください）
    click_link "戻る"
    expect(page).to have_content("取引先一覧")

    # 案件へ（ナビが無い場合は直接）
    visit projects_path

    click_link "新規登録"
    fill_in "案件名", with: "Webサイト改修"

    # ステータス：日本語表示の select にしている前提
    select "進行中", from: "ステータス"

    # 取引先：projects/_form の collection_select で「株式会社テスト」が出る想定
    select "株式会社テスト", from: "取引先"
    find('input[name="commit"],button[name="commit"]').click

    expect(page).to have_content("案件を登録しました。")
    expect(page).to have_content("Webサイト改修")

    # 見積へ
    visit quotes_path

    click_link "新規登録"
    select "下書き", from: "ステータス"
    fill_in "小計（円）", with: "100000"
    fill_in "発行日", with: "2026-01-15"
    fill_in "備考", with: "テスト見積です"

    select "Webサイト改修", from: "案件"
    find('input[name="commit"],button[name="commit"]').click

    expect(page).to have_content("見積を登録しました。")
  end
end
