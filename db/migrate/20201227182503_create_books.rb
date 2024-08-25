class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.references :author, null: false
      t.string :title, null: false
      t.integer :category, null: false
      t.integer :isbn, null: false, index: { unique: true }
      t.integer :price, null: false

      t.timestamps
    end
  end
end
