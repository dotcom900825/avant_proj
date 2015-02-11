class SdtjDemo < ActiveRecord::Base
  scope :age, -> (start, finish) {where(:age=>(start..finish))}
  scope :sex, -> (sex) {where(:sex=>sex)}
  scope :country, -> (country) {where(:country=>country) if country.present?}
  
  scope :marital_status, -> (status) {where(:marital_status=>status) if status.present?}
  scope :sexual_orientation, -> (orientations) {where(:sexual_orientation=>orientations) if orientations.present?}
  scope :primary_study, -> (studies) {where(:primary_study=>studies) if studies.present?}
  scope :enrollment_date, -> (date) {where("enrollment_time >= ?", "#{date}-01-01") if date.present?}

end