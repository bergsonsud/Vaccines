class User < ActiveRecord::Base

	has_many :users_vaccines
    has_many :vaccines, through: :users_vaccines
    validates_presence_of :name, :cpf, :birth
    validates_uniqueness_of :cpf, message: "já está cadastrado no sistema"
    validates_format_of :cpf, with: /\A\d{11}\z/, message: "deve conter apenas os 11 dígitos numéricos, sem pontos ou traços"
    validate :cpf_algoritmo_valido

    before_validation :normalizar_cpf

	def self.search(query)
    	where("name like ? OR cpf like ?", "%#{query}%", "%#{query}%")
  	end

  	def self.age(user)
  		age = Date.today.year - user.birth.year  		
    	age -= 1 if Date.today < user.birth + age.years    	
    	return age
  	end


    def self.age_category(user)
      age = Date.today.year - user.birth.year
			age -= 1 if Date.today < user.birth + age.years

			category = Category.find_by_sql ["SELECT id FROM categories WHERE categories.age_max>= ? limit 1", age]
			category = Category.find(category[0].id)
			category = category
    
      return category
    end



  private

  def normalizar_cpf
    self.cpf = cpf.gsub(/[\.\-\s]/, '') if cpf.present?
  end

  def cpf_algoritmo_valido
    return if cpf.blank? || cpf !~ /\A\d{11}\z/
    return errors.add(:cpf, "inválido") if cpf.chars.uniq.length == 1

    soma = 9.times.sum { |i| cpf[i].to_i * (10 - i) }
    resto = soma % 11
    digito1 = resto < 2 ? 0 : 11 - resto
    return errors.add(:cpf, "inválido") if digito1 != cpf[9].to_i

    soma = 10.times.sum { |i| cpf[i].to_i * (11 - i) }
    resto = soma % 11
    digito2 = resto < 2 ? 0 : 11 - resto
    errors.add(:cpf, "inválido") if digito2 != cpf[10].to_i
  end

end
