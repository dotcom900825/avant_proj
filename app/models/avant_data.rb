class AvantData < ActiveRecord::Base
  scope :age, -> (start, finish) {where(:baseline_age=>(start..finish))}
  scope :gender, -> (gender) {where(:gender=>gender)}

  def gender
    gender_hash = {0=>"male", 1=>"female", 2=>"tg", nil=>"unknown"}
    return gender_hash[self.read_attribute(:gender)]
  end
end
