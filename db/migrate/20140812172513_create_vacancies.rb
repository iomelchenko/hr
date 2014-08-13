class CreateVacancies < ActiveRecord::Migration
  def change
    create_table   :vacancies do |t|
      t.string     :name
      t.integer    :validity_period
      t.integer    :salary
      t.text       :contact_information
     #t.references :skill
      t.timestamps     
    end
  end
end
