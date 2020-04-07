class CreateDumpComments < ActiveRecord::Migration[5.2]
  def change
    create_table :dump_comments do |t|
      t.text :text, null: false
      t.references :user, foreign_key: true, index: true
      t.references :dump, foreign_key: true

      t.timestamps
    end
  end
end
