class CreateDumps < ActiveRecord::Migration[5.2]
  def change
    create_table :dumps do |t|

      t.timestamps
    end
  end
end
