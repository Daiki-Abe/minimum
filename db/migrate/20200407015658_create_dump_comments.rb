class CreateDumpComments < ActiveRecord::Migration[5.2]
  def change
    create_table :dump_comments do |t|

      t.timestamps
    end
  end
end
