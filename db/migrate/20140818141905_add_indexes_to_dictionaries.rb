class AddIndexesToDictionaries < ActiveRecord::Migration
  def change
  	add_index(:applicants, :id)
  	add_index(:vacancies, :id)
  	add_index(:skills, :id)
  end
end
