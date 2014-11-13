require "CSV"

task :load_avantgarde_data => :environment do
  counter = 0
  sex_orientation = {"MSM"=> 0, "Bi"=>1, "Het"=> 2}
  gender = {"Male"=>0, "Female"=> 1, "TG"=> 2}
  marital_status = {"Single"=>0, "Married"=>1, "Seperated"=> 2, "Divorced"=> 3, "CommonLaw"=> 4, "Widowed"=> 5}

  CSV.foreach("/Users/thomas/Downloads/avantgarde.csv").each do |row|
    if counter == 0
      puts row
    else
      AvantData.create(:sequence_id=>row[0], :primary_study_id=>row[1], :aeidrp_id=>row[2], :primary_study=>row[3], :other_id=>row[4], :enrollment_date=>row[5], :seqpresent=>row[6], :sdtj_01_deg=>row[7].to_i, :sdtj_015_deg=>row[8].to_i, :lanl_01_deg=>row[9].to_i, :lanl_015_deg=>row[10].to_i, :sdtj_01=>row[11].to_i, :sdtj_015=>row[12].to_i, :lanl_01=>row[13].to_i, :lanl_015=>row[14].to_i, :baseline_age=>row[15].to_i, :gender=>gender[row[16]], :race=>row[17], :ethnicity=>row[19], :marital_status=>marital_status[row[20]], :sexual_orientation=>sex_orientation[row[21]], :rfhiv=>row[22], :idu=>row[23].to_i, :blood_trans=>row[24].to_i, :sharp_exposure=>row[25].to_i, :transactional_sex=>row[26].to_i, :sex_prostitutes=>row[27], :partner_number=>row[28], :transaction_sex_loc=>row[29], :transaction_sex_type_loc=>row[30], :idu_loc_use=>row[31], :idu_loc_use_type=>row[32], :sharing_needle=>row[33], :heroin=>row[34], :meth=>row[35], :alcohol_consumption=>row[36], :recent_institution=>row[37], :acute_hiv=>row[38], :first_pos_hiv=>row[39], :cd4dx=>row[40], :hivvldx=>row[41], :locdx=>row[42], :edi=>row[43], :edicat=>row[44], :cd4_curr=>row[45], :hiv_vlcurr=>row[46], :date_curr=>row[47], :std_last_year=>row[48], :syphilis=>row[49], :gc=>row[50], :chlamydia=>row[51], :hcv=>row[52], :on_art=>row[53], :on_art_date=>row[54], :art_pie=>row[55], :art_nnrti=>row[56], :education=>row[57], :address=>row[58], :zip=>row[59], :residence_state=>row[60], :residence_country=>row[61], :occupation=>row[62], :informal_occ=>row[63], :loc_occ=>row[64], :border_xing=>row[65], :born_country=>row[66], :born_state=>row[67], :born_city=>row[68], :deported=>row[69])
    end

    counter += 1
  end
end