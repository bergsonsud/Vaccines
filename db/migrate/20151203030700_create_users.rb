class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :cpf
<<<<<<< HEAD
      t.datetime :birth
=======
>>>>>>> 7e9b44292b43636f7c6e64bf7164d96a098c9534

      t.timestamps null: false
    end
  end
end
