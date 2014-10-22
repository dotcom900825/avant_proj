class CreateAvantData < ActiveRecord::Migration
  def change
    create_table :avant_data do |t|
      t.string :subject_identification
      t.string :name
      t.date :interview_time
      t.integer :baseline_age
      t.integer :question_duration
      t.integer :gender
      t.integer :martial_status
      t.integer :sexual_orientation
      t.string :residence_country
      t.string :residence_city
      t.string :born_country
      t.string :born_city
      t.integer :citizenship
      t.integer :education
      t.string :ethnicity
      t.integer :deported
      t.string :monthly_income
      t.string :language
      t.integer :gonorrhea
      t.integer :chlamydia
      t.integer :syphilis
      t.integer :hepatitis_c
      t.integer :human_papillomavirus
      t.integer :heroin
      t.integer :meth
      t.integer :alcohol_consumption
      t.integer :sharing_needle
      t.integer :transactional_sex
      t.integer :partner_number 
      t.timestamps
    end
  end
end
