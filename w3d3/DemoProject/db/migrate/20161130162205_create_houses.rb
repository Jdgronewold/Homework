class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.text :address, null: false
      t.integer :yr_built
    end
  end
end
