module UsersHelper
  def mascarar_cpf(cpf)
    return '' if cpf.blank?
    digits = cpf.gsub(/\D/, '')
    return cpf if digits.length < 4
    ultimos = digits.last(4)
    "***.***.**#{ultimos[0..1]}-#{ultimos[2..3]}"
  end
end
