class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string  :name,       :null => false, :default => ""
      t.integer :user_limit, :null => false, :default => 5
      t.date    :renewal_date
      t.date    :expiry_date
      t.string  :phone
      t.string  :fax
      t.string  :address1
      t.string  :address2
      t.string  :city
      t.string  :postcode
      t.string  :state
      t.string  :country

      t.timestamps
    end

    add_index :accounts, :name, :unique => true
  end
end
