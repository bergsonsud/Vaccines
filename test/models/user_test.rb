require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "deve ser inválido sem data de nascimento" do
    user = User.new(name: "Fulano de Tal", cpf: "12345678901")
    assert user.invalid?
    assert_includes user.errors[:birth], "can't be blank"
  end

  test "deve ser inválido quando a data de nascimento está no futuro" do
    user = User.new(name: "Fulano de Tal", cpf: "12345678901", birth: Date.today + 1)
    assert user.invalid?
    assert_includes user.errors[:birth], "não pode ser uma data futura"
  end

  test "deve ser válido quando a data de nascimento é hoje" do
    user = User.new(name: "Fulano de Tal", cpf: "12345678901", birth: Date.today)
    assert user.valid?
  end

  test "deve ser válido com data de nascimento no passado" do
    user = User.new(name: "Fulano de Tal", cpf: "12345678901", birth: Date.new(1990, 1, 1))
    assert user.valid?
  end

  test "deve ser inválido sem nome" do
    user = User.new(cpf: "12345678901", birth: Date.new(1990, 1, 1))
    assert user.invalid?
    assert_includes user.errors[:name], "can't be blank"
  end

  test "deve ser inválido sem CPF" do
    user = User.new(name: "Fulano de Tal", birth: Date.new(1990, 1, 1))
    assert user.invalid?
    assert_includes user.errors[:cpf], "can't be blank"
  end
end
