class CreateBuyTags < ActiveRecord::Migration[5.2]
  def change
    create_table :buy_tags do |t|
      t.references :buy, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
