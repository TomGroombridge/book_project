class RemoveThumbnailFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :thumbnail
  end
end
