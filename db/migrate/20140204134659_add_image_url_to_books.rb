class AddImageUrlToBooks < ActiveRecord::Migration
  def change
    add_column :books, :image_url, :string
    add_column :books, :number_of_pages, :integer
    add_column :books, :detail_page_url, :string
    remove_column :books, :image
    remove_column :books, :url
  end
end
