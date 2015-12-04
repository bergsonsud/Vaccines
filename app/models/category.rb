class Category < ActiveRecord::Base
	has_many :vaccines
	validates_presence_of :name
end
