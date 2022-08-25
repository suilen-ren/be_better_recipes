class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :user_id ,null: false
      t.text :title ,null: false
      t.text :feature ,null: false
      t.text :making , null: false
      t.boolean :permit_user ,null: false, default: true
      t.boolean :permit_admin ,null:false, default: true

      t.timestamps
    end
  end
end
