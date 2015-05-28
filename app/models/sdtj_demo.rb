class SdtjDemo < ActiveRecord::Base
  scope :age, -> (start, finish) {where(:age=>(start..finish))}
  scope :sex, -> (sex) {where(:sex=>sex)}
  scope :country, -> (country) {where(:country=>country) if country.present?}
  
  scope :marital_status, -> (status) {where(:marital_status=>status) if status.present?}
  scope :sexual_orientation, -> (orientations) {where(:sexual_orientation=>orientations) if orientations.present?}
  scope :primary_study, -> (studies) {where(:primary_study=>studies) if studies.present?}
  scope :enrollment_date, -> (date) {where("date_of_enrollment >= ?", "#{date}-01-01") if date.present?}


  def cluster_id
    return read_attribute(:cluster_id).to_i
  end

  def inject_drug
    val = read_attribute(:inject_drug)
    if val == '1'
      return "Yes"
    end

    "NO"
  end

  # def date_of_enrollment
  #   return read_attribute(:date_of_enrollment).to_time.to_i if read_attribute(:date_of_enrollment)
  # end

end
