class HomeController < ApplicationController
  def index
    @vaccines = Vaccine.select("name").group("category_id").count
    @g_vaccines = UsersVaccine.group(:vaccine_id).count
    @c_vaccines = UsersVaccine.joins("INNER JOIN vaccines on vaccines.id = users_vaccines.vaccine_id").joins("INNER JOIN categories on vaccines.category_id = categories.id").group("categories.id").count

    draw #call function
  end

  def draw

    @chartCategory = Array.new()
    @chartCategory[0] = 'Categoria', 'Quantidade'
    @vaccines.each do |vaccine|
      @chartCategory[@chartCategory.size] = Category.find(vaccine[0]).name,vaccine[1]
    end

    @group_vaccines = Array.new()
    @group_vaccines[0] = 'Vacina', 'Quantidade'
    @g_vaccines.each do |vaccine|
      @group_vaccines[@group_vaccines.size] = Vaccine.find(vaccine[0]).name,vaccine[1]
    end


    @category_vaccines = Array.new()
    @category_vaccines[0] = 'Categoria', 'Quantidade'
    @c_vaccines.each do |vaccine|
      @category_vaccines[@category_vaccines.size] = Category.find(vaccine[0]).name,vaccine[1]
    end

  end
end
