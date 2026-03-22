require 'test_helper'

class VaccineTest < ActiveSupport::TestCase
  def setup
    @category = categories(:one)
    @vaccine = Vaccine.new(name: "Varicela", category_id: @category.id)
  end

  test "deve ser valida com atributos corretos" do
    assert @vaccine.valid?
  end

  test "deve exigir nome" do
    @vaccine.name = nil
    assert_not @vaccine.valid?
    assert_includes @vaccine.errors[:name], "can't be blank"
  end

  test "deve exigir categoria" do
    @vaccine.category_id = nil
    assert_not @vaccine.valid?
    assert_includes @vaccine.errors[:category_id], "can't be blank"
  end

  test "nao deve permitir cadastrar duas vacinas com o mesmo nome" do
    @vaccine.save!
    duplicata = Vaccine.new(name: "Varicela", category_id: @category.id)
    assert_not duplicata.valid?
    assert_includes duplicata.errors[:name], "já está cadastrada"
  end

  test "nao deve permitir cadastrar vacinas com o mesmo nome em case diferente" do
    @vaccine.save!
    duplicata = Vaccine.new(name: "varicela", category_id: @category.id)
    assert_not duplicata.valid?
    assert_includes duplicata.errors[:name], "já está cadastrada"
  end

  test "deve permitir vacinas com nomes diferentes" do
    @vaccine.save!
    outra = Vaccine.new(name: "Gripe", category_id: @category.id)
    assert outra.valid?
  end
end
