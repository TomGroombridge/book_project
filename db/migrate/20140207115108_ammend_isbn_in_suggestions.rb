class AmmendIsbnInSuggestions < ActiveRecord::Migration
  def change
    remove_column :suggestions, :isbn
    add_column :suggestions, :isbn, :string
  end
end
