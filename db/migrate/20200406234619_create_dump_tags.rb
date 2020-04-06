class CreateDumpTags < ActiveRecord::Migration[5.2]
  def change
    create_table :dump_tags do |t|
      t.references :dump, foreign_key: true, index: true
      t.references :tag, foreign_key: true, index: true

      t.timestamps
    end
  end
end
