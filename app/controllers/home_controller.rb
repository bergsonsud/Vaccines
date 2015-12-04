class HomeController < ApplicationController
  def index

  	#@vaccine = Vaccine.select["SELECT c.name,count(*) from Vaccines v inner join Categories c on c.id = v.category_id group by category_id"]
  	@vaccines = Vaccine.select("name").group("category_id").count
  	


  end
end
