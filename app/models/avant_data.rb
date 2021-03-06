class AvantData < ActiveRecord::Base
  scope :age, -> (start, finish) {where(:baseline_age=>(start..finish))}
  scope :gender, -> (gender) {where(:gender=>gender)}
  scope :country, -> (country) {where(:residence_country=>country) if country.present?}
  scope :marital_status, -> (status) {where(:marital_status=>status) if status.present?}
  scope :sexual_orientation, -> (orientations) {where(:sexual_orientation=>orientations) if orientations.present?}
  scope :primary_study, -> (studies) {where(:primary_study=>studies) if studies.present?}
  scope :enrollment_date, -> (date) {where("enrollment_time >= ?", "#{date}-01-01") if date.present?}
  
  def gender
    gender_hash = {0=>"Male", 1=>"Female", 2=>"Tg", nil=>"Unknown"}
    return gender_hash[self.read_attribute(:gender)]
  end

  def marital_status
    marital_status = {"Single"=>0, "Married"=>1, "Seperated"=> 2, "Divorced"=> 3, "CommonLaw"=> 4, "Widowed"=> 5}
    return marital_status.invert[self.read_attribute(:marital_status)]
  end

  def sex_orientation
    sex_orientation = {"MSM"=> 0, "Bi"=>1, "Het"=> 2}
    return sex_orientation.invert[self.read_attribute(:sexual_orientation)]
  end

  def drug_usage
    return "Heroin & Meth & Alcohol" if self.heroin.to_i > 0 && self.meth.to_i > 0 && self.alcohol_consumption.to_i > 0
    return "Heroin & Meth" if self.heroin.to_i > 0 && self.meth.to_i > 0
    return "Heroin & Alcohol" if self.heroin.to_i > 0 && self.alcohol_consumption.to_i > 0
    return "Meth & Alcohol" if self.meth.to_i > 0 && self.alcohol_consumption.to_i > 0
    return "Heroin" if self.heroin.to_i > 0
    return "Meth" if self.meth.to_i > 0
    return "Alcohol" if self.alcohol_consumption.to_i > 0
    return "None"
  end


  def as_json(options={})
    options[:methods] = :drug_usage

    super(options)
  end
end
