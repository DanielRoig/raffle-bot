class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.integer :telegram_id, null: false, unique: true
      t.string :telegram_first_name, null: false
      t.string :telegram_username

      t.timestamps
    end

    add_index :users, :telegram_id, unique: true
  end
end
