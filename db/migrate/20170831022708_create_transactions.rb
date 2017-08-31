class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :origin_id
      t.integer :destionation_id
      t.integer :transaction_type
      t.decimal :amount
      t.string :token

      t.timestamps
    end
  end
end
