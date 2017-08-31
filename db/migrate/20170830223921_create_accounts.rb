class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.integer :parent_id
      t.datetime :creation_date
      t.string :type

      t.timestamps
    end
  end
end
