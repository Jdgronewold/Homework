class CreateToys < ActiveRecord::Migration
  def change
    create_table :toys do |t|
      t.string :name
      t.references :toayable, polymorphic: true, index: true
    end
  end
end
