require "net/http"

class AvantDataController < ApplicationController
  protect_from_forgery except: :map_polylines
  before_action :set_headers

  layout "empty", :only=>[:geojson_example]

  def index
    @column_names = AvantData.column_names.reject {|name| ["subject_identification", "name", "interview_time", "question_duration"].include? name.to_s}
    @data = AvantData.all.marital_status(params[:selectMarital]).sexual_orientation(params[:selectSex]).primary_study(params[:selectSite]).enrollment_date(params[:selectYear])

    respond_to do |format|
      format.html
      format.json
    end
  end

  def all_data

    case params[:type]
    when "columns"
      @data = SdtjDemo.column_names
      respond_to do |format|
        format.json { render json: @data}
      end 

    when "circle_packing"
      if params[:columns]
        @query1 = params[:columns][0]
        @query2 = params[:columns][1]
      end
      respond_to do |format|
        format.json { render template: "avant_data/circle_packing"}
      end

    when "parallel"
      @data = SdtjDemo.select(params[:columns]) if params[:columns]

      @data = @data.where(params[:filters].first.to_sym=>params[:filter_values].first) if params[:filter_values] && params[:filter_values].first.present? && params[:filter_values].first != "undefined"
      respond_to do |format|
        format.html
        format.json {render json: @data}
      end

    when "pie_chart"
      @count_data = SdtjDemo.select(params[:column]).group(params[:column]).count
      @count_data = SdtjDemo.select(params[:column]).where(params[:filters].first.to_sym=>params[:filter_values].first).group(params[:column]).count if params[:filter_values] && params[:filter_values].first.present? && params[:filter_values].first != "undefined"
      respond_to do |format|
        format.html
        format.json {render template: "avant_data/pie_chart"}
      end

    else
      @data = SdtjDemo.all
      @data = SdtjDemo.all.where(params[:filterBy].to_sym=>params[:value]) if params[:filterBy].present? && params[:value].present?
      respond_to do |format|
        format.html
        format.json {render json: @data}
      end

    end
  end

  def pie_chart
    @count_data = SdtjDemo.select(params[:column]).group(params[:column]).count
    respond_to do |format|
      format.html
      format.json
    end
  end

  def time_data
    @data = AvantData.all.marital_status(params[:selectMarital]).sexual_orientation(params[:selectSex]).primary_study(params[:selectSite]).enrollment_date(params[:selectYear])
    respond_to do |format|
      format.json
    end
  end

  def circle_packing
    if params[:columns]
      @query1 = params[:columns][0]
      @query2 = params[:columns][1]
    end
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
    @data = SdtjDemo.select(params[:columns]) if params[:columns]

    @data = @data.where(params[:hierOne].to_sym=>params[:value])
    respond_to do |format|
      format.html
      format.json {render json: @data}
    end

  end

  def cluster
    @data = AvantData.all.country(params[:country])

    respond_to do |format|
      format.html
      format.json { render json: @data}
    end

  end

  def flexible_cluster
    if params[:column]
      @data = TicinoData.select(params[:column]).group(params[:column]).count.except(nil, " ", 0, "Data Unavailable")
    end

    respond_to do |format|
      format.html
      format.json 
    end
  end



  def map_polylines
    url = URI.parse("http://maps.huge.info/zip3.pl")
    response = Net::HTTP.post_form(url, {"ZIP3"=>params["ZIP3"]})
    puts response.body
    render text: response.body
  end

  def scatter_chart
    @heroin_data = TicinoData.where(:heroin_usage=>"Yes").select(:age, :number_of_sexual_partners, :education_in_years)
    @meth_data = TicinoData.where(:methamphetamine_usage=>"Yes").select(:age, :number_of_sexual_partners, :education_in_years)
    @alcohol_data = TicinoData.where(:alcohol_consumption=>"Yes").select(:age, :number_of_sexual_partners, :education_in_years)
  end

  def demo_data
    @data = SdtjDemo.all.marital_status(params[:selectMarital]).sexual_orientation(params[:selectSex]).primary_study(params[:selectSite]).enrollment_date(params[:selectYear])
    
    respond_to do |format|
      format.json
    end

  end

  def geojson
    respond_to do |format|
      format.json
    end
  end

  def all
    respond_to do |format|
      format.json
    end
  end

  def geojson_example
    
  end


  private
  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
