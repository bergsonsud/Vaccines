class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :age_min
      t.integer :age_max

      t.timestamps null: false
    end
  end
end
