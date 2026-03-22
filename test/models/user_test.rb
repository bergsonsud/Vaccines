require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def usuario_base
    User.new(name: 'joão silva', cpf: '123.456.789-00', birth: 30.years.ago)
  end

  test "capitaliza a primeira letra de cada palavra do nome ao salvar" do
    user = usuario_base
    user.save!
    assert_equal 'João Silva', user.name
  end

  test "capitaliza nome digitado totalmente em maiusculas" do
    user = usuario_base
    user.name = 'JOÃO SILVA'
    user.save!
    assert_equal 'João Silva', user.name
  end

  test "capitaliza nome com multiplas palavras" do
    user = usuario_base
    user.name = 'maria das graças oliveira'
    user.save!
    assert_equal 'Maria Das Graças Oliveira', user.name
  end

  test "não altera nome que já está correto" do
    user = usuario_base
    user.name = 'Pedro Henrique'
    user.save!
    assert_equal 'Pedro Henrique', user.name
  end

end
