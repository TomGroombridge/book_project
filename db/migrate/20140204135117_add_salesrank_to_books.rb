class AddSalesrankToBooks < ActiveRecord::Migration
  def change
    add_column :books, :sales_rank, :integer
  end
end
