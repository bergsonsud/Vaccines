require 'test_helper'

class UsersHelperTest < ActionView::TestCase
  test "mascarar_cpf exibe somente os ultimos 4 digitos com cpf formatado" do
    assert_equal "***.***.**89-01", mascarar_cpf("123.456.789-01")
  end

  test "mascarar_cpf exibe somente os ultimos 4 digitos com cpf sem formatacao" do
    assert_equal "***.***.**89-01", mascarar_cpf("12345678901")
  end

  test "mascarar_cpf retorna string vazia para cpf nulo" do
    assert_equal '', mascarar_cpf(nil)
  end

  test "mascarar_cpf retorna string vazia para cpf em branco" do
    assert_equal '', mascarar_cpf('')
  end

  test "mascarar_cpf retorna cpf original se tiver menos de 4 digitos" do
    assert_equal "123", mascarar_cpf("123")
  end
end
