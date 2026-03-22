class Vaccine < ActiveRecord::Base
	belongs_to :category
	has_many :users_vaccines	
    has_many :users, through: :users_vaccines

    validates_presence_of :name, :category_id
    validates_uniqueness_of :name, case_sensitive: false, message: "já está cadastrada"

end
