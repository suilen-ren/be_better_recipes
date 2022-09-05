class CreateBodyweights < ActiveRecord::Migration[6.1]
  def change
    create_table :bodyweights do |t|
      t.integer :user_id, null: false
      t.integer :weight, null: false

      t.timestamps
    end
  end
end
