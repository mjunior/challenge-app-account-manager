class AddPersonIdToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :person_id, :integer
  end
end
