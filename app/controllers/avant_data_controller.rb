require "net/http"

class AvantDataController < ApplicationController
  protect_from_forgery except: :map_polylines
  before_action :set_headers

  def index
    @column_names = AvantData.column_names.reject {|name| ["subject_identification", "name", "interview_time", "question_duration"].include? name.to_s}
    @data = AvantData.all.marital_status(params[:selectMarital]).sexual_orientation(params[:selectSex]).primary_study(params[:selectSite]).enroment_date(params[:selectYear])

    respond_to do |format|
      format.html { @data.page(params[:page]).per(20) }
      format.json
    end
  end

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
    @query1 = params[:query1]
    @query2 = params[:query2]

    respond_to do |format|
      format.html
      format.json
    end
  end

  def address
    @data = AvantData.pluck(:address).compact

    respond_to do |format|
      format.html
      format.json
    end
  end

  def bar_hierarchy
    
  end

  def zip
    
  end

  def three_digit_zip
    
  end

  def parallel
    @data = AvantData.select("gender", "SDTJ_01", "SDTJ_01_DEG", "SDTJ_015", "SDTJ_015_DEG", "LANL_01", "LANL_01_DEG", "LANL_015", "LANL_015_DEG")

    respond_to do |format|
      format.html
      format.csv
    end

  end

  def cluster
    @data = AvantData.all.country(params[:country])

    respond_to do |format|
      format.html
      format.json { render json: @data}
    end

  end

  def map_polylines
    url = URI.parse("http://maps.huge.info/zip3.pl")
    response = Net::HTTP.post_form(url, {"ZIP3"=>params["ZIP3"]})
    puts response.body
    render text: response.body
  end

  private
  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
