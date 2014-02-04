class CreateFetchData < ActiveRecord::Migration
  def change
    create_table :fetch_data do |t|

      t.timestamps
    end
  end
end
