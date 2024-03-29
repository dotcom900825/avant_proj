class CreateAvantData < ActiveRecord::Migration
  def change
    create_table :avant_data do |t|
      t.string :subject_identification
      t.string :sequence_id
      t.string :primary_study_id
      t.string :aeidrp_id
      t.string :primary_study
      t.string :other_id
      t.string :enrollment_date
      t.string :seqpresent
      t.integer :sdtj_01_deg
      t.integer :sdtj_015_deg
      t.integer :lanl_01_deg
      t.integer :lanl_015_deg
      t.integer :sdtj_01
      t.integer :sdtj_015
      t.integer :lanl_01
      t.integer :lanl_015
      t.string :name
      t.date :interview_time
      t.integer :baseline_age
      t.integer :question_duration
      t.integer :gender
      t.string  :race
      t.integer :martial_status
      t.integer :sexual_orientation
      t.string :rfhiv
      t.integer :idu
      t.integer :blood_trans
      t.integer :sharp_exposure
      t.string :sex_prostitutes
      t.string :transaction_sex_loc
      t.string :transaction_sex_type_loc
      t.string :idu_loc_use
      t.string :idu_loc_use_type
      t.string :acute_hiv
      t.string :first_pos_hiv
      t.string :cd4dx
      t.string :hivvldx
      t.string :locdx
      t.string :edi
      t.string :edicat
      t.string :cd4_curr
      t.string :hiv_vlcurr
      t.string :date_curr
      t.integer :std_last_year
      t.string :residence_country
      t.string :residence_city
      t.string :residence_state
      t.string :born_country
      t.string :born_state
      t.string :born_city
      t.integer :citizenship
      t.integer :education
      t.string :ethnicity
      t.integer :deported
      t.string :monthly_income
      t.string :language
      t.text :address
      t.string :zip
      t.integer :occupation
      t.integer :informal_occ
      t.string :loc_occ
      t.integer :border_xing
      t.integer :gc
      t.integer :hcv
      t.integer :on_art
      t.string :on_art_date
      t.string :art_pie
      t.string :art_nnrti
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
      t.integer :recent_institution
      t.timestamps
    end
  end
end
