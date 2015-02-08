class CreateSdtjDemos < ActiveRecord::Migration
  def change
    create_table :sdtj_demos do |t|
      t.string :pid
      t.string :x
      t.string :sequence_id
      t.string :primary_study
      t.string :aehpid
      t.string :sequence_date
      t.string :aeh
      t.string :edi_class
      t.string :edi_date
      t.string :zip
      t.string :date_of_sequence
      t.string :date_of_enrollment
      t.string :race
      t.string :ethnicity
      t.string :marital_status
      t.string :age
      t.string :sex
      t.string :sexual_orientation
      t.string :risk_factor_hiv
      t.string :inject_drug
      t.string :blood_transfusion
      t.string :sharps_exposure
      t.string :transactional_sex
      t.string :sex_with_prostitutes
      t.string :number_of_partners
      t.string :heroin_usage
      t.string :meth_usage
      t.string :alcohol_consumption
      t.string :recent_institutionalization
      t.string :first_hiv_test
      t.string :estimated_date_of_infection
      t.string :category_of_edi
      t.string :current_cd4_count
      t.string :current_hiv_load
      t.string :date_of_current_lab_values
      t.string :std_history_within_last_year
      t.string :syphilis
      t.string :gonorrhea
      t.string :chlamydia
      t.string :hcv
      t.string :location_of_residence_at_time_of_interview
      t.string :loc_res_city
      t.string :state
      t.string :country
      t.string :border_cross_last_year
      t.string :birth_nation
      t.string :birth_state
      t.string :birth_city
      t.string :deported
      t.string :cur_vl_log
      t.string :cluster_id
      t.string :mean_path_length
      t.string :relative_to_cluster_min
      t.string :degree
      t.string :betweenness_centrality
      t.string :clustering_binary
      t.timestamps
    end
  end
end
