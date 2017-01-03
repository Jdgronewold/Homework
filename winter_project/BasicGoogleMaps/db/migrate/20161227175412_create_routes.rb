class CreateRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :routes do |t|
      t.integer :user_id, null: false
      t.string :start_address
      t.string :end_address

      t.timestamps
    end
    add_index :routes, :user_id
  end
end
