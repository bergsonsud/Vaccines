class User < ActiveRecord::Base

	has_many :users_vaccines
    has_many :vaccines, through: :users_vaccines
    validates_presence_of :name, :cpf, :birth

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


  	
end
