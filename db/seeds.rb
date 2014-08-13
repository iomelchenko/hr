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
applicants = [{:name => 'Иванов Иван Иванович', :contact_information => 'Kiev, tel. 050 1234567',
               :status => 'job search', :desirable_salary => 2000},
              {:name => 'Васильев Сергей Петрович', :contact_information => 'Kharkiv, tel. 097 7654321',
               :status => 'job search', :desirable_salary => 1500},
              {:name => 'Митрофанов Георгий Сергеевич', :contact_information => 'Lugansk, tel. 096 3214567',
               :status => 'job search', :desirable_salary => 900},
              {:name => 'Крылова Елена Ивановна', :contact_information => 'Minsk, tel. 098 7893245',
               :status => 'job search', :desirable_salary => 1200},
              {:name => 'Дербунов Игорь Васильевич', :contact_information => 'Odessa, tel. 058 3301212',
               :status => 'search postponed', :desirable_salary => 1200}               
             ]

applicants.each do |applicant|
  Applicant.create!(applicant)
end


sql_del = "delete from skills_vacancies"
ActiveRecord::Base.connection.execute(sql_del)
sql = "insert into skills_vacancies (skill_id,vacancy_id) values (1,2);
       insert into skills_vacancies (skill_id,vacancy_id) values (3,2);
       insert into skills_vacancies (skill_id,vacancy_id) values (4,2);
       insert into skills_vacancies (skill_id,vacancy_id) values (6,2);
       insert into skills_vacancies (skill_id,vacancy_id) values (7,2);
       insert into skills_vacancies (skill_id,vacancy_id) values (3,1);
       insert into skills_vacancies (skill_id,vacancy_id) values (4,1);
       insert into skills_vacancies (skill_id,vacancy_id) values (1,3);
       insert into skills_vacancies (skill_id,vacancy_id) values (2,3);
       insert into skills_vacancies (skill_id,vacancy_id) values (3,3);
       insert into skills_vacancies (skill_id,vacancy_id) values (4,4);
       insert into skills_vacancies (skill_id,vacancy_id) values (5,5);
       insert into skills_vacancies (skill_id,vacancy_id) values (6,6);
       insert into skills_vacancies (skill_id,vacancy_id) values (7,7);"   

ActiveRecord::Base.connection.execute(sql)


sql_del = "delete from applicants_skills"
ActiveRecord::Base.connection.execute(sql_del)
sql = "insert into applicants_skills (applicant_id, skill_id) values (1,1);
       insert into applicants_skills (applicant_id, skill_id) values (1,2);
       insert into applicants_skills (applicant_id, skill_id) values (1,3);
       insert into applicants_skills (applicant_id, skill_id) values (1,4);
       insert into applicants_skills (applicant_id, skill_id) values (1,5);
       insert into applicants_skills (applicant_id, skill_id) values (1,6);
       insert into applicants_skills (applicant_id, skill_id) values (1,7);
       insert into applicants_skills (applicant_id, skill_id) values (2,1);
       insert into applicants_skills (applicant_id, skill_id) values (2,2);
       insert into applicants_skills (applicant_id, skill_id) values (2,3);
       insert into applicants_skills (applicant_id, skill_id) values (2,4);
       insert into applicants_skills (applicant_id, skill_id) values (2,6);
       insert into applicants_skills (applicant_id, skill_id) values (4,1);
       insert into applicants_skills (applicant_id, skill_id) values (4,3);
       insert into applicants_skills (applicant_id, skill_id) values (4,4);
       insert into applicants_skills (applicant_id, skill_id) values (5,3);
       insert into applicants_skills (applicant_id, skill_id) values (5,4);
       insert into applicants_skills (applicant_id, skill_id) values (3,4);"   

ActiveRecord::Base.connection.execute(sql)



