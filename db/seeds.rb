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

Applicant.delete_all
applicants = [{:name => 'Иванов Иван Иванович', :contact_information => 'Kiev, tel. 0501234567',
               :status => 'job search', :desirable_salary => 2000},
              {:name => 'Васильев Сергей Петрович', :contact_information => 'Kharkiv, tel. 0977654321',
               :status => 'job search', :desirable_salary => 1500},
              {:name => 'Митрофанов Георгий Сергеевич', :contact_information => 'Lugansk, tel. 0963214567',
               :status => 'job search', :desirable_salary => 900},
              {:name => 'Крылова Елена Ивановна', :contact_information => 'Minsk, tel. 0987893245',
               :status => 'job search', :desirable_salary => 1200},
              {:name => 'Дербунов Игорь Васильевич', :contact_information => 'Odessa, tel. 0583301212',
               :status => 'search postponed', :desirable_salary => 1200}               
             ]

applicants.each do |applicant|
  Applicant.create!(applicant)
end


sql_del = "delete from skills_vacancies"
ActiveRecord::Base.connection.execute(sql_del)
sql = "INSERT INTO skills_vacancies 
          SELECT 1,2
          UNION ALL SELECT 3,2
          UNION ALL SELECT 4,2
          UNION ALL SELECT 6,2
          UNION ALL SELECT 7,2
          UNION ALL SELECT 3,1
          UNION ALL SELECT 4,1
          UNION ALL SELECT 1,3
          UNION ALL SELECT 2,3
          UNION ALL SELECT 3,3
          UNION ALL SELECT 4,3
          UNION ALL SELECT 5,3
          UNION ALL SELECT 6,3
          UNION ALL SELECT 7,3;"  

ActiveRecord::Base.connection.execute(sql)


sql_del = "delete from applicants_skills"
ActiveRecord::Base.connection.execute(sql_del)
sql = "INSERT INTO applicants_skills 
          SELECT 1,2
          UNION ALL SELECT 1,2
          UNION ALL SELECT 1,3
          UNION ALL SELECT 1,4
          UNION ALL SELECT 1,5
          UNION ALL SELECT 1,6
          UNION ALL SELECT 1,7
          UNION ALL SELECT 2,1
          UNION ALL SELECT 2,2
          UNION ALL SELECT 2,3
          UNION ALL SELECT 2,4
          UNION ALL SELECT 2,6
          UNION ALL SELECT 4,1
          UNION ALL SELECT 4,3
          UNION ALL SELECT 4,4
          UNION ALL SELECT 5,4
          UNION ALL SELECT 5,4;"   

ActiveRecord::Base.connection.execute(sql)

