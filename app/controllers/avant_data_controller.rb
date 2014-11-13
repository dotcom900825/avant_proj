class AvantDataController < ApplicationController
  def gender
    @data = AvantData.all

    @male = [@data.gender(0).age(20, 30), @data.gender(0).age(30, 40), @data.gender(0).age(40, 50), @data.gender(0).age(50, 60), @data.gender(0).age(60, 70) ].map {|ele| ele.count}
    @female = [@data.gender(1).age(20, 30), @data.gender(1).age(30, 40), @data.gender(1).age(40, 50), @data.gender(1).age(50, 60), @data.gender(1).age(60, 70) ].map {|ele| ele.count}

    respond_to do |format|
      format.html
      format.json
    end
  end

  def time_data
    @data = AvantData.select(:enrollment_date, :first_pos_hiv, :date_curr, :sequence_id, :primary_study_id, :baseline_age, :gender, :marital_status, :sexual_orientation, :education, :zip, :primary_study)
    respond_to do |format|
      format.json
    end
  end

  def circle_packing
    @ethnicities = AvantData.pluck(:ethnicity).uniq.reject {|item| [nil].include? item}
    @race_types = AvantData.pluck(:race).uniq.reject {|item| [nil, " ", "   "].include? item}
    
    respond_to do |format|
      format.html
      format.json
    end

  end
end
