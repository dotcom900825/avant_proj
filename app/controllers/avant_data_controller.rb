class AvantDataController < ApplicationController
  before_action :validate_login, :only=>[:index]

  def index

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
        format.json {render json: @data}
      end

    when "pie_chart"
      @count_data = SdtjDemo.select(params[:column]).group(params[:column]).count
      @count_data = SdtjDemo.select(params[:column]).where(params[:filters].first.to_sym=>params[:filter_values].first).group(params[:column]).count if params[:filter_values] && params[:filter_values].first.present? && params[:filter_values].first != "undefined"
      respond_to do |format|
        format.json {render template: "avant_data/pie_chart"}
      end

    when "scatter_chart"
      @group_by = params[:group_by]
      @data = SdtjDemo.all
      @data = @data.where(params[:filters].first.to_sym=>params[:filter_values].first) if params[:filter_values] && params[:filter_values].first.present? && params[:filter_values].first != "undefined"
      @grouped_data = @data.pluck(params[:group_by]).uniq.reject {|c| c.blank? || c.empty?}

      @x_param = params[:x]
      @y_param = params[:y]
      @size_param = params[:size]
      respond_to do |format|
        format.json {render template: "avant_data/scatter_chart"}
      end

    when "motion_chart"
      @data = SdtjDemo.where.not(params[:group_by]=>nil)
      @data = @data.where.not(params[:time_column]=>nil)
      @data = @data.where(params[:filters].first.to_sym=>params[:filter_values].first) if params[:filter_values] && params[:filter_values].first.present? && params[:filter_values].first != "undefined"

      @x_param = params[:x]
      @y_param = params[:y]
      @size_param = params[:size]
      @time_column = params[:time_column]
      @group_by = params[:group_by]
      respond_to do |format|
        format.json {render template: "avant_data/motion_chart"}
      end

    when "graph"
      @data = SdtjDemo.where.not(:cluster_id=>nil).order("cluster_id DESC")
      @data = @data.where(params[:filters].first.to_sym=>params[:filter_values].first) if params[:filter_values] && params[:filter_values].first.present? && params[:filter_values].first != "undefined"
      respond_to do |format|
        format.json {render template: "avant_data/graph"}
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


  private
  

  def validate_login
    if current_user.nil?
      flash[:notice] = "You don't have access to this page"
      redirect_to root_path and return
    end
  end
end
