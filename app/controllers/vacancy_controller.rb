class VacancyController < ApplicationController

  def index
    @vacancies = Vacancy.all
  end

end
