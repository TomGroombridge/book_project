class ChangeContentInBooks < ActiveRecord::Migration
  def change
    remove_column :books, :content
    add_column :books, :content, :text
  end
end
