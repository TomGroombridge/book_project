class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|

      t.timestamps
    end
  end
end
