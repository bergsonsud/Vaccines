class CreateVaccines < ActiveRecord::Migration
  def change
    create_table :vaccines do |t|
      t.string :name
<<<<<<< HEAD
      t.integer :category_id
      
=======

>>>>>>> 7e9b44292b43636f7c6e64bf7164d96a098c9534
      t.timestamps null: false
    end
  end
end
