class AvantDataController < ApplicationController
  def index
    @data = AvantData.all

    render json: @data
  end
end
