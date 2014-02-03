class AddTitleToBooks < ActiveRecord::Migration
  def change
    add_column :books, :title, :string
  end
end
