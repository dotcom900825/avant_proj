class PircDataController < ApplicationController
  before_action :need_login

  def index
  end

  def all_data
    mod = EtRoster.joins("join Contact on SUBSTRING(Contact.pid, 3) = SUBSTRING(ET_Roster.RedCrossID, 4)").joins("join ET_RapidTest on Et_Roster.RedCrossID = ET_RapidTest.RedCrossID").joins("join ET_NAT on ET_NAT.RedCrossID = ET_Roster.RedCrossID").select("ET_Roster.RedCrossID, ET_RapidTest.*, ET_NAT.*, Contact.*")    
    # mod = EtRoster.joins("join Contact on SUBSTRING(Contact.pid, 3) = SUBSTRING(ET_Roster.RedCrossID, 4)").joins("join Bio on SUBSTRING(Bio.pid, 3) = SUBSTRING(ET_Roster.RedCrossID, 4)").joins("join ET_RapidTest on Et_Roster.RedCrossID = ET_RapidTest.RedCrossID").joins("join ET_NAT on ET_NAT.RedCrossID = ET_Roster.RedCrossID").select("ET_Roster.RedCrossID, ET_RapidTest.*, ET_NAT.*, Bio.*, Contact.*")    

    case params[:type]
    when "columns"
      @data = mod.column_names
      @data += [current_user.phi_role]
      respond_to do |format|
        format.json { render json: @data}
      end
      return 
      
    when "circle_packing"
      if params[:columns]
        @query1 = params[:columns][0]
        @query2 = params[:columns][1]
      end
      respond_to do |format|
        format.json { render template: "avant_data/circle_packing"}
      end

    else
      @data = mod.all.limit(1000)
      @data = mod.all.where(params[:filterBy].to_sym=>params[:value]) if params[:filterBy].present? && params[:value].present?
      respond_to do |format|
        format.html
        format.json {render json: @data}
      end

    end

  end

  private
  def need_login
    if current_user.nil?
      flash[:notice] = "You don't have access to this page"
      redirect_to root_path and return
    end
  
  end

end