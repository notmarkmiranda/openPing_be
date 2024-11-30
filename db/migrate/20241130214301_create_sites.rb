class CreateSites < ActiveRecord::Migration[8.0]
  def change
    create_table :sites do |t|
      t.string :url, null: false
      t.integer :frequency, null: false
      t.boolean :is_active, default: true
      t.datetime :last_pinged_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
