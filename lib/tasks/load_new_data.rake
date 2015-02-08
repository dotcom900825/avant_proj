require "csv"

task :load_new_data => :environment do
  counter = 0

  CSV.foreach(File.expand_path('../new_data.csv', __FILE__)).each do |row|
    if counter == 0
      puts row
    else
      SdtjDemo.create(:pid=>row[1],
        :x=>row[2],
        :sequence_id=>row[4],
        :primary_study=>row[5],
        :aehpid=>row[6],
        :sequence_date=>row[7],
        :aeh=>row[8],
        :edi_class=>row[9],
        :edi_date=>row[10],
        :zip=>row[12],
        :date_of_sequence=>row[13],
        :date_of_enrollment=>row[14],
        :race=>row[15],
        :ethnicity=>row[16],
        :marital_status=>row[17],
        :age=>row[19],
        :sex=>row[20],
        :sexual_orientation=>row[21],
        :risk_factor_hiv=>row[22],
        :inject_drug=>row[23],
        :blood_transfusion=>row[24],
        :sharps_exposure=>row[25],
        :transactional_sex=>row[26],
        :sex_with_prostitutes=>row[27],
        :number_of_partners=>row[28],
        :heroin_usage=>row[29],
        :meth_usage=>row[30],
        :alcohol_consumption=>row[31],
        :recent_institutionalization=>row[32],
        :first_hiv_test=>row[33],
        :estimated_date_of_infection=>row[34],
        :category_of_edi=>row[35],
        :current_cd4_count=>row[36],
        :current_hiv_load=>row[37],
        :date_of_current_lab_values=>row[38],
        :std_history_within_last_year=>row[39],
        :syphilis=>row[40],
        :gonorrhea=>row[41],
        :chlamydia=>row[42],
        :hcv=>row[43],
        :location_of_residence_at_time_of_interview=>row[44],
        :loc_res_city=>row[45],
        :state=>row[47],
        :country=>row[48],
        :border_cross_last_year=>row[49],
        :birth_nation=>row[50],
        :birth_state=>row[51],
        :birth_city=>row[52],
        :deported=>row[53],
        :cur_vl_log=>row[62],
        :cluster_id=>row[65],
        :mean_path_length=>row[67],
        :relative_to_cluster_min=>row[68],
        :degree=>row[69],
        :betweenness_centrality=>row[70],
        :clustering_binary=>row[71])
    end

    counter += 1
  end
end