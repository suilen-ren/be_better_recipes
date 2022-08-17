class CreateBodyweights < ActiveRecord::Migration[6.1]
  def change
    create_table :bodyweights do |t|

      t.timestamps
    end
  end
end
