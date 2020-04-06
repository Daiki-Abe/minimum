class CreateDumpTags < ActiveRecord::Migration[5.2]
  def change
    create_table :dump_tags do |t|

      t.timestamps
    end
  end
end
