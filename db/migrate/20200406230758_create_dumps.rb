class CreateDumps < ActiveRecord::Migration[5.2]
  def change
    create_table :dumps do |t|
      t.string :goods, null: false
      t.string :price, null: false
      t.string :image
      t.text :description, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
