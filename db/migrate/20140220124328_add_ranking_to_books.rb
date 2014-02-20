class AddRankingToBooks < ActiveRecord::Migration
  def change
    add_column :books, :ranking, :integer 
  end
end
