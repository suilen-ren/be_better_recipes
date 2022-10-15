require "rails_helper"

describe "レシピ投稿機能に関するテスト" , type: :system do
    before do
        @user = FactoryBot.create(:user)
    end

    context "レシピの新規投稿に関するテスト" do
        before do
            sign_in @user
            visit new_recipe_path
        end
        it "投稿画面のパスが正しいか" do
            expect(current_path).to eq("/recipes/new")
        end

        it "すべてを空欄にして投稿したら保存されないことの確認" do
            click_button "レシピを保存する"
            expect(current_path).to eq("/recipes/new")
            expect(page).to have_content "すべての項目"
        end
        it "文字数オーバーしたら保存されないことの確認" do
            fill_in "recipe[title]", with: Faker::Lorem.characters(number: 10)
            fill_in "recipe[feature]", with: Faker::Lorem.characters(number: 1001)
            fill_in "recipe[making]", with: Faker::Lorem.characters(number: 1001)
            choose "recipe_permit_user_true"

            attach_file "recipe[image]","#{Rails.root}/app/assets/images/no_image.jpg"
            click_button("レシピを保存する")

            expect(page).to have_content "すべての項目"
        end

        it "すべての項目を入力したら保存されることの確認" do
            fill_in "recipe[title]", with: Faker::Lorem.characters(number: 10)
            fill_in "recipe[feature]", with: Faker::Lorem.characters(number: 100)
            fill_in "recipe[making]", with: Faker::Lorem.characters(number: 100)
            choose "recipe_permit_user_true"

            attach_file "recipe[image]","#{Rails.root}/app/assets/images/no_image.jpg"
            click_button("レシピを保存する")

            expect(page).to have_content("新規レシピを保存")
        end

    end
    context "レシピ一覧、詳細の確認テスト" do
        before do
            sign_in @user
            visit new_recipe_path
            fill_in "recipe[title]", with: Faker::Lorem.characters(number: 10)
            fill_in "recipe[feature]", with: Faker::Lorem.characters(number: 100)
            fill_in "recipe[making]", with: Faker::Lorem.characters(number: 100)

            attach_file "recipe[image]","#{Rails.root}/app/assets/images/no_image.jpg"
            click_button("レシピを保存する")
            visit recipes_path

        end
        it "レシピ一覧が表示されてるか" do
            expect(page).to have_current_path("/recipes")
            expect(page).to have_content Recipe.find_by(id: 1).title
        end
        it "レシピ詳細に遷移し、正しく表示されているか" do
            visit recipe_path(1)
            expect(page).to have_current_path "/recipes/1"
            expect(page).to have_content Recipe.find_by(id:1).title
            expect(page).to have_content Recipe.find_by(id:1).feature
            expect(page).to have_content Recipe.find_by(id:1).making
        end
    end

    context "編集機能、削除に関するテスト" do
        before do
            sign_in @user
            visit new_recipe_path
            fill_in "recipe[title]", with: Faker::Lorem.characters(number: 10)
            fill_in "recipe[feature]", with: Faker::Lorem.characters(number: 100)
            fill_in "recipe[making]", with: Faker::Lorem.characters(number: 100)
            choose "recipe_permit_user_true"

            attach_file "recipe[image]","#{Rails.root}/app/assets/images/no_image.jpg", make_visible: true
            click_button("レシピを保存する")
            visit edit_recipe_path(1)
        end

        it "編集機能のバリデーションチェック" do
            fill_in "recipe[title]", with: nil
            fill_in "recipe[feature]", with: Faker::Lorem.characters(number: 100)
            fill_in "recipe[making]", with: Faker::Lorem.characters(number: 100)
            choose "recipe_permit_user_true"

            attach_file "recipe[image]","#{Rails.root}/app/assets/images/no_image.jpg", make_visible: true
            click_button("レシピを保存する")

            expect(page).to have_current_path(edit_recipe_path(1))
        end
        it "編集機能がきちんと反映されているか" do
            fill_in "recipe[title]", with: "とてもつらい"
            fill_in "recipe[feature]", with: Faker::Lorem.characters(number: 100)
            fill_in "recipe[making]", with: Faker::Lorem.characters(number: 100)
            choose "recipe_permit_user_true"

            attach_file "recipe[image]","#{Rails.root}/app/assets/images/no_image.jpg", make_visible: true
            click_button("レシピを保存する")

            expect(page).to have_current_path(recipe_path(1))
            expect(page).to have_content("とてもつらい")
        end
        it "削除機能が機能するか" do
            # 削除機能はラックテストじゃ機能しないっぽいので飛ばします。仕様書でチェックします
        end
    end
    context "コメント機能についてのテスト" do
        before do
            sign_in @user
            visit new_recipe_path
            fill_in "recipe[title]", with: Faker::Lorem.characters(number: 10)
            fill_in "recipe[feature]", with: Faker::Lorem.characters(number: 100)
            fill_in "recipe[making]", with: Faker::Lorem.characters(number: 100)
            choose "recipe_permit_user_true"

            attach_file "recipe[image]","#{Rails.root}/app/assets/images/no_image.jpg", make_visible: true
            click_button("レシピを保存する")
            visit recipe_path(1)
        end

        it "コメントがきちんと反映されるか" do
            fill_in "comment[comment_text]", with: Faker::Lorem.characters(number: 15)
            click_button("投稿する")
            expect(page).to have_current_path("/recipes/1")
            sign_out @user
            visit users_guest_sign_in_path
            visit recipe_path(1)
            expect(page).to have_content Comment.find_by(id: 1).comment_text
        end
        it "コメントがきちんと削除できるか" do
            #削除機能はJSを用いているためラックテストでは無理　仕様書でテストします。
        end
    end









end
