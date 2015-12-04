class User < ActiveRecord::Base
	#has_and_belongs_to_many :vaccines

	has_many :users_vaccines

    has_many :vaccines, through: :users_vaccines

	def self.search(query)  
    	where("name like ? OR cpf like ?", "%#{query}%", "%#{query}%")
  	end
end
