class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, index: { unique: true }, null: true
      t.date :birth
      t.string :born_country
      t.text :biography

      t.timestamps
    end
  end
end
