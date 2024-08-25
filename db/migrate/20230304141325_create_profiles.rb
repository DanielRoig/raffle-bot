class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false
      t.text :description

      t.timestamps
    end
  end
end
