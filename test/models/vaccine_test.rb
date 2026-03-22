require 'test_helper'

class VaccineTest < ActiveSupport::TestCase
  def setup
    @category = categories(:one)
    @vaccine = Vaccine.new(name: "Vacina Febre Amarela", category_id: @category.id)
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

  test "nao deve permitir cadastrar vacina com nome duplicado" do
    @vaccine.save!
    vacina_duplicada = Vaccine.new(name: "Vacina Febre Amarela", category_id: @category.id)
    assert_not vacina_duplicada.valid?
    assert_includes vacina_duplicada.errors[:name], "já está cadastrada"
  end

  test "nao deve permitir cadastrar vacina com nome duplicado ignorando maiusculas e minusculas" do
    @vaccine.save!
    vacina_duplicada = Vaccine.new(name: "vacina febre amarela", category_id: @category.id)
    assert_not vacina_duplicada.valid?
    assert_includes vacina_duplicada.errors[:name], "já está cadastrada"
  end

  test "deve permitir cadastrar vacinas com nomes diferentes" do
    @vaccine.save!
    outra_vacina = Vaccine.new(name: "Vacina Tetano", category_id: @category.id)
    assert outra_vacina.valid?
  end
end
