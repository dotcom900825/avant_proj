class TicinoData < ActiveRecord::Base
  def age
    return 0 if self.read_attribute(:age) == -99
    return self.read_attribute(:age)
  end

  def heroin_usage
    hash = {"No"=>50, "Yes"=>100, "Not Availiable"=>0}
    return hash[self.read_attribute(:heroin_usage)]
  end

  def alcohol_consumption
    hash = {"No"=>50, "Yes"=>100, "Not Availiable"=>0}
    return hash[self.read_attribute(:alcohol_consumption)]
  end

  def number_of_sexual_partners
    return 1 if ["numPartners", "Data Unavailable"].include? self.read_attribute(:number_of_sexual_partners)
    return self.read_attribute(:number_of_sexual_partners)
  end
end
