class AvantData < ActiveRecord::Base
  scope :age, -> (start, finish) {where(:baseline_age=>(start..finish))}
  scope :gender, -> (gender) {where(:gender=>gender)}
end
