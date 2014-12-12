class AvantData < ActiveRecord::Base
  scope :age, -> (start, finish) {where(:baseline_age=>(start..finish))}
  scope :gender, -> (gender) {where(:gender=>gender)}
  scope :country, -> (country) {where(:residence_country=>country) if country.present?}

  def gender
    gender_hash = {0=>"male", 1=>"female", 2=>"tg", nil=>"unknown"}
    return gender_hash[self.read_attribute(:gender)]
  end

  def marital_status
    marital_status = {"Single"=>0, "Married"=>1, "Seperated"=> 2, "Divorced"=> 3, "CommonLaw"=> 4, "Widowed"=> 5}
    return marital_status.invert[self.read_attribute(:marital_status)]
  end

  def sex_orientation
    sex_orientation = {"MSM"=> 0, "Bi"=>1, "Het"=> 2}
    return sex_orientation.invert
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
