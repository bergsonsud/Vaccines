class Vaccine < ActiveRecord::Base
	#has_and_belongs_to_many :users

	has_many :users_vaccines	
    has_many :users, through: :users_vaccines
end
