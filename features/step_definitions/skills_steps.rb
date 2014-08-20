# Add a declarative step here for populating the DB with movies.

 Given /the following skills exist/ do |skills_table|
  skills_table.hashes.each do |skill|
    Skill.create!(skill)
  end

end

