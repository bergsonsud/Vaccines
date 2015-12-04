class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :cpf
      t.datetime :birth
      t.timestamps null: false
    end
  end
end
