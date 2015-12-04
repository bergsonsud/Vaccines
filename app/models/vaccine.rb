class Vaccine < ActiveRecord::Base
	#has_and_belongs_to_many :users

<<<<<<< HEAD
	belongs_to :category
=======
>>>>>>> 7e9b44292b43636f7c6e64bf7164d96a098c9534
	has_many :users_vaccines	
    has_many :users, through: :users_vaccines
end
