class CreateHates < ActiveRecord::Migration[5.2]
  def change
    create_table :hates do |t|
      t.references :user, foreign_key: true
      t.references :buy, foreign_key: true

      t.timestamps
    end
  end
end
