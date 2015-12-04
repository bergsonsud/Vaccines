class UsersVaccine < ActiveRecord::Base
	belongs_to :vaccine
	belongs_to :user

	validates_uniqueness_of :user_id, :scope => [:vaccine_id]
end
