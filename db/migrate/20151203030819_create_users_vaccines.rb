class CreateUsersVaccines < ActiveRecord::Migration
  def change
  	create_table :users_vaccines do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :vaccine, index: true, foreign_key: true
      t.timestamps null: false
  	end
  end
end

