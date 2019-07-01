class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :name
      t.integer :user_id, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
