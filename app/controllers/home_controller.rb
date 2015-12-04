class HomeController < ApplicationController
  def index
<<<<<<< HEAD
  	#@vaccine = Vaccine.select["SELECT c.name,count(*) from Vaccines v inner join Categories c on c.id = v.category_id group by category_id"]
  	@vaccines = Vaccine.select("name").group("category_id").count
  	
=======
>>>>>>> 7e9b44292b43636f7c6e64bf7164d96a098c9534
  end
end
