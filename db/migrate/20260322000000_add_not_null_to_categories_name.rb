class AddNotNullToCategoriesName < ActiveRecord::Migration
  def up
    change_column_null :categories, :name, false
  end

  def down
    change_column_null :categories, :name, true
  end
end
