require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "capitaliza a primeira letra de cada palavra do nome ao salvar" do
    user = User.new(name: "joao da silva", cpf: "123.456.789-00", birth: Date.new(1990, 1, 1))
    user.save(validate: false)
    assert_equal "Joao Da Silva", user.name
  end

  test "normaliza nome em maiusculas ao salvar" do
    user = User.new(name: "MARIA SANTOS", cpf: "987.654.321-00", birth: Date.new(1985, 6, 15))
    user.save(validate: false)
    assert_equal "Maria Santos", user.name
  end

  test "capitaliza nome com uma unica palavra" do
    user = User.new(name: "pedro", cpf: "111.222.333-44", birth: Date.new(2000, 3, 20))
    user.save(validate: false)
    assert_equal "Pedro", user.name
  end

  test "nao altera nome se for nil" do
    user = User.new(name: nil, cpf: "000.000.000-00", birth: Date.new(1995, 1, 1))
    user.valid?
    assert_nil user.name
  end
end
