class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :status
      t.integer :parent_account_id

      t.timestamps
    end
  end
end
