# Add a declarative step here for populating the DB with movies.

 Given /the following vacancies exist/ do |vacancies_table|
  vacancies_table.hashes.each do |vacancy|
    Vacancy.create!(vacancy)
  end

end

