require 'test_helper'

class VaccineTest < ActiveSupport::TestCase
  def setup
    @category = categories(:one)
    @vaccine = Vaccine.new(name: 'Vacina Teste', category_id: @category.id)
  end

  test "deve ser valida com atributos corretos" do
    assert @vaccine.valid?
  end

  test "nome e obrigatorio" do
    @vaccine.name = nil
    assert_not @vaccine.valid?
    assert_includes @vaccine.errors[:name], "can't be blank"
  end

  test "categoria e obrigatoria" do
    @vaccine.category_id = nil
    assert_not @vaccine.valid?
    assert_includes @vaccine.errors[:category_id], "can't be blank"
  end

  test "nao permite cadastrar vacina com nome duplicado" do
    @vaccine.save!
    vacina_duplicada = Vaccine.new(name: 'Vacina Teste', category_id: @category.id)
    assert_not vacina_duplicada.valid?
    assert_includes vacina_duplicada.errors[:name], "has already been taken"
  end

  test "nao permite cadastrar vacina com nome duplicado ignorando maiusculas e minusculas" do
    @vaccine.save!
    vacina_duplicada = Vaccine.new(name: 'vacina teste', category_id: @category.id)
    assert_not vacina_duplicada.valid?
    assert_includes vacina_duplicada.errors[:name], "has already been taken"
  end

  test "permite vacinas com nomes diferentes" do
    @vaccine.save!
    outra_vacina = Vaccine.new(name: 'Outra Vacina', category_id: @category.id)
    assert outra_vacina.valid?
  end
end
