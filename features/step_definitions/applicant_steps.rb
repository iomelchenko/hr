# Add a declarative step here for populating the DB with movies.

 Given /the following applicants exist/ do |applicants_table|
  applicants_table.hashes.each do |applicant|
    Applicant.create!(applicant)
  end

end

