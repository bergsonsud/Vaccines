class User < ActiveRecord::Base
	has_and_belongs_to_many :vaccines

	 def self.search(query)  
    where("name like ? OR cpf like ?", "%#{query}%", "%#{query}%")

  end
end
