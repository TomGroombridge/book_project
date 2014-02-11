class AddUserIdToSelections < ActiveRecord::Migration
  def change
    add_reference :selections, :user, index: true
  end
end
