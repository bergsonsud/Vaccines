require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def cpf_valido
    "52998224725"
  end

  def usuario_valido
    User.new(name: "Teste Usuário", cpf: cpf_valido, birth: Date.new(1990, 1, 15))
  end

  test "usuario valido deve ser salvo" do
    assert usuario_valido.valid?
  end

  test "cpf com letras deve ser invalido" do
    user = usuario_valido
    user.cpf = "529abc24725"
    assert user.invalid?
    assert user.errors[:cpf].any?
  end

  test "cpf com pontos e traco deve ser normalizado e aceito" do
    user = usuario_valido
    user.cpf = "529.982.247-25"
    assert user.valid?, "CPF formatado deve ser normalizado e aceito: #{user.errors.full_messages}"
    assert_equal "52998224725", user.cpf
  end

  test "cpf duplicado deve ser invalido" do
    users(:one).save!
    user2 = usuario_valido
    user2.cpf = users(:one).cpf
    user2.name = "Outro Nome"
    assert user2.invalid?
    assert user2.errors[:cpf].any?
  end

  test "cpf com menos de 11 digitos deve ser invalido" do
    user = usuario_valido
    user.cpf = "1234567890"
    assert user.invalid?
    assert user.errors[:cpf].any?
  end

  test "cpf com mais de 11 digitos deve ser invalido" do
    user = usuario_valido
    user.cpf = "123456789012"
    assert user.invalid?
    assert user.errors[:cpf].any?
  end

  test "cpf com todos digitos iguais deve ser invalido" do
    user = usuario_valido
    user.cpf = "11111111111"
    assert user.invalid?
    assert user.errors[:cpf].any?
  end

  test "cpf com digitos verificadores errados deve ser invalido" do
    user = usuario_valido
    user.cpf = "52998224700"
    assert user.invalid?
    assert user.errors[:cpf].any?
  end

  test "nome obrigatorio" do
    user = usuario_valido
    user.name = nil
    assert user.invalid?
    assert user.errors[:name].any?
  end

  test "data de nascimento obrigatoria" do
    user = usuario_valido
    user.birth = nil
    assert user.invalid?
    assert user.errors[:birth].any?
  end

end
