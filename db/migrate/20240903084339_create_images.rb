class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.string :telegram_id
      t.references :imageable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
