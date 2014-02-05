class AddContentToBooks < ActiveRecord::Migration
  def change
    add_column :books, :content, :string
  end
end
