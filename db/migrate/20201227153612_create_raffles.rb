class CreateRaffles < ActiveRecord::Migration[6.1]
  def change
    create_table :raffles do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.integer :first_number, null: false
      t.integer :last_number, null: false
      t.integer :price, null: false
      t.string :payment_info, null: false
      t.integer :status, default: 0
      t.integer :category, default: 0, null: false
      t.timestamps
    end
  end
end
