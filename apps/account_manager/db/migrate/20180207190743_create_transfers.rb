class CreateTransfers < ActiveRecord::Migration[5.1]
  def change
    create_table :transfers do |t|
      t.integer :value_cents
      t.string :description
      t.integer :receiver_account_id
      t.integer :sender_account_id
      t.string :charge_identifier 

      t.timestamps
    end
  end
end
