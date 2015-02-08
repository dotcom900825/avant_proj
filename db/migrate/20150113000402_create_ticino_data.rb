class CreateTicinoData < ActiveRecord::Migration
  def change
    create_table :ticino_data do |t|
      t.integer :subject_id
      t.string :site_subject
      t.string :site_name
      t.date :interview_date
      t.integer :age
      t.integer :question_duration
      t.string :gender
      t.string :marital_status
      t.string :sexual_orientation
      t.string :country_of_residence
      t.string :city_of_residence
      t.string :country_of_birth
      t.string :city_of_birth
      t.string :citizenship
      t.integer :education_in_years
      t.string :ethnicity
      t.string :previously_deported
      t.string :monthly_income
      t.string :languages
      t.string :height
      t.string :gonorrhea_diagnosis
      t.string :chlamydia_diagnosis
      t.string :syphilis_diagnosis
      t.string :hepatitis_c_diagnosis
      t.string :human_papillomavirus_diagnosis
      t.string :heroin_usage
      t.string :methamphetamine_usage
      t.string :alcohol_consumption
      t.string :sharing_needles
      t.string :transactional_sex
      t.string :number_of_sexual_partners
      t.string :first_hiv_pos_date
      t.string :currently_on_art
      t.string :art_begin_date
      t.string :hivvl_curr
      t.string :cd4_curr
      t.string :edi_date
      t.string :edi_cat
      t.string :temperature
      t.string :oral_ulceration
      t.string :pharyngitis
      t.string :thrush
      t.string :inguinal
      t.string :hepatomegaly
      t.string :rash
      t.timestamps
    end
  end
end
