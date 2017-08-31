class AddStatusToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :status, :integer, :default => 1
  end
end
