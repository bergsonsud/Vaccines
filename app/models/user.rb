class User < ActiveRecord::Base

	has_many :users_vaccines
    has_many :vaccines, through: :users_vaccines

    before_validation :normalize_cpf, :parse_birth_date

    validates_presence_of :name, :cpf, :birth
    validates_format_of :cpf, with: /\A\d{11}\z/, message: "deve conter exatamente 11 dígitos numéricos"
    validates_uniqueness_of :cpf, message: "já está cadastrado para outro usuário"

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

    def normalize_cpf
      self.cpf = cpf.gsub(/\D/, '') if cpf.present?
    end

    # Aceita datas no formato brasileiro DD/MM/YYYY vindas do datepicker
    def parse_birth_date
      raw = birth_before_type_cast
      if raw.is_a?(String) && raw =~ /\A\d{2}\/\d{2}\/\d{4}\z/
        self.birth = Date.strptime(raw, "%d/%m/%Y")
      end
    end


end
