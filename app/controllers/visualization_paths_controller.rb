class VisualizationPathsController < ApplicationController
  protect_from_forgery except: :create

  def create
    current_user.visualization_paths.create(:name=>params[:pathName], :filter=>params[:filters].to_json, :path=>params[:paths].to_json)
    render json: {"status"=> "success"}
  end

end