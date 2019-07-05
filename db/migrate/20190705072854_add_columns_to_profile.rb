class AddColumnsToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :avatar, :string
    add_column :profiles, :addres, :text
    add_column :profiles, :link, :string
  end
end
