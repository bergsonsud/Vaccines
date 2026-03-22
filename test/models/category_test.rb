require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "categoria invalida sem name" do
    category = Category.new(age_min: 0, age_max: 12)
    assert_not category.valid?
    assert_includes category.errors[:name], "can't be blank"
  end

  test "categoria valida com name presente" do
    category = Category.new(name: "Infantil", age_min: 0, age_max: 12)
    assert category.valid?
  end
end
