require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "usuário válido deve ser salvo" do
    user = User.new(name: "Carlos Ferreira", cpf: "11122233344", birth: Date.today - 25.years)
    assert user.valid?, user.errors.full_messages.inspect
  end

  test "CPF com apenas dígitos deve ser válido" do
    user = User.new(name: "Teste", cpf: "11122233344", birth: Date.today - 30.years)
    assert user.valid?
  end

  test "CPF com letras deve ser inválido" do
    user = User.new(name: "Teste", cpf: "123ABC78901", birth: Date.today - 20.years)
    assert user.invalid?
    assert user.errors[:cpf].any?
  end

  test "CPF com menos de 11 dígitos deve ser inválido" do
    user = User.new(name: "Teste", cpf: "1234567", birth: Date.today - 20.years)
    assert user.invalid?
    assert user.errors[:cpf].any?
  end

  test "CPF com mais de 11 dígitos deve ser inválido" do
    user = User.new(name: "Teste", cpf: "123456789012", birth: Date.today - 20.years)
    assert user.invalid?
    assert user.errors[:cpf].any?
  end

  test "CPF formatado com pontos e traço deve ser normalizado para apenas dígitos" do
    user = User.new(name: "Teste", cpf: "111.222.333-44", birth: Date.today - 20.years)
    user.valid?
    assert_equal "11122233344", user.cpf
  end

  test "CPF duplicado deve ser inválido" do
    user = User.new(name: "Outro Usuário", cpf: users(:one).cpf, birth: Date.today - 20.years)
    assert user.invalid?
    assert user.errors[:cpf].any?
  end

  test "CPF único deve ser válido" do
    user = User.new(name: "Novo Usuário", cpf: "55566677788", birth: Date.today - 20.years)
    assert user.valid?
  end

  test "data de nascimento em formato brasileiro DD/MM/YYYY deve ser aceita" do
    user = User.new(name: "Teste Data", cpf: "55566677799", birth: "15/01/1990")
    assert user.valid?, user.errors.full_messages.inspect
    assert_equal Date.new(1990, 1, 15), user.birth.to_date
  end

  test "nome é obrigatório" do
    user = User.new(cpf: "11122233344", birth: Date.today - 20.years)
    assert user.invalid?
    assert user.errors[:name].any?
  end

  test "CPF é obrigatório" do
    user = User.new(name: "Teste", birth: Date.today - 20.years)
    assert user.invalid?
    assert user.errors[:cpf].any?
  end

  test "data de nascimento é obrigatória" do
    user = User.new(name: "Teste", cpf: "11122233344")
    assert user.invalid?
    assert user.errors[:birth].any?
  end

end
