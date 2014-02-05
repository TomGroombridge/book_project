class CreateJoinTableBooksSelections < ActiveRecord::Migration
  def change
    create_join_table :books, :selections do |t|
      # t.index [:book_id, :selection_id]
      # t.index [:selection_id, :book_id]
    end
  end
end
