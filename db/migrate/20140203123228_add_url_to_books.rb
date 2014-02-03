class AddUrlToBooks < ActiveRecord::Migration
  def change
    add_column :books, :url, :string
  end
end
