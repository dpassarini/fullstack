class AddInfoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :document, :string
    add_column :users, :name, :string
    add_column :users, :company_name, :string
    add_column :users, :birth_date, :date
  end
end
