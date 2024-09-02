class CreateNumbers < ActiveRecord::Migration[6.1]
  def change
    create_table :numbers do |t|
      t.references :raffle, null: false, foreign_key: true
      t.integer :value, null: false
      t.references :user, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :numbers, [:raffle_id, :value], unique: true
  end
end
