require "CSV"

task :load_ticino_data => :environment do
  counter = 0

  CSV.foreach(File.expand_path('../ticino_data.csv', __FILE__)).each do |row|
    if counter == 0
      puts row
    else
      TicinoData.create(:subject_id=>row[1], :site_subject=>row[2], :site_name=>row[3], :interview_date=>row[4], :age=>row[5], :question_duration=>row[6], :gender=>row[7], :marital_status=>row[8], :sexual_orientation=>row[9],
                        :country_of_residence=>row[10], :city_of_residence=>row[11], :country_of_birth=>row[12], :city_of_birth=>row[13], :citizenship=>row[14], :education_in_years=>row[15], :ethnicity=>row[16], :previously_deported=>row[17],
                        :monthly_income=>row[18], :languages=>row[19], :height=>row[20], :gonorrhea_diagnosis=>row[21], :chlamydia_diagnosis=>row[22], :syphilis_diagnosis=>row[23], :hepatitis_c_diagnosis=>row[24], :human_papillomavirus_diagnosis=>row[25],
                        :heroin_usage=>row[26], :methamphetamine_usage=>row[27], :alcohol_consumption=>row[28], :sharing_needles=>row[29], :transactional_sex=>row[30], :number_of_sexual_partners=>row[31], :first_hiv_pos_date=>row[32], :currently_on_art=>row[33],
                        :art_begin_date=>row[34], :hivvl_curr=>row[35], :cd4_curr=>row[36], :edi_date=>row[37], :edi_cat=>row[38], :temperature=>row[39], :oral_ulceration=>row[40], :pharyngitis=>row[41], :thrush=>row[42], :inguinal=>row[43], :hepatomegaly=>row[44], :rash=>row[45])
    end

    counter += 1
  end
end