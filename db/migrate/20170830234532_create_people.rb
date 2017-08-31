class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :full_name
      t.string :cnpj
      t.string :company_name
      t.string :trade_name
      t.string :cpf
      t.string :type
      t.datetime :birthdate
      t.timestamps
    end
  end
end
