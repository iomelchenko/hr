# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# countries dictionary
Vacancy.delete_all
vacancies = [{:name => 'DB developer', :validity_period => 2, 
	          :salary => 1500, :contact_information => 'DB development company'},
             {:name => 'Java developer', :validity_period => 3, 
	          :salary => 2500, :contact_information => 'Banks technology company'},
             {:name => 'Ruby developer', :validity_period => 5, 
	          :salary => 3500, :contact_information => 'WEB development company'}
  	 ]

vacancies.each do |vacancy|
  Vacancy.create!(vacancy)
end

Skill.delete_all
skills = [{:name => 'OOP programming'},
          {:name => 'Functional programming'},
          {:name => 'DB development'},
          {:name => 'Creating unit tests'},
          {:name => 'BDD'},
          {:name => 'TDD'},
          {:name => 'Management'}
  	 ]

skills.each do |skill|
  Skill.create!(skill)
end


