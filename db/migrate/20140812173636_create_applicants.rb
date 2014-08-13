class CreateApplicants < ActiveRecord::Migration
  def change
    create_table   :applicants do |t|
      t.string     :name
      t.text       :contact_information      
      t.string     :status
      t.integer    :desirable_salary
      #t.references :skill
    end
  end
end



