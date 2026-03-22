class AddUniqueIndexToVaccinesName < ActiveRecord::Migration
  def change
    add_index :vaccines, :name, unique: true
  end
end
