class TalksController < ApplicationController
  before_filter :find_meeting
  before_filter :require_admin, :except => [:index,:show]
  
  def index
    @talks = Talk.all
  end
  
  def show
    @talk = Talk.find(params[:id])
  end
  
  def new
    @talk = Talk.new
  end
  
  def create
    @talk = Talk.new(params[:talk])
    p @talk
    
    if @talk.save
      redirect_to meeting_talk_path(@meeting,@talk)
    else
      render :action => :new
    end
  end
  
  def edit
    @talk = Talk.find(params[:id])
  end
  
  def update
    @talk = Talk.find(params[:id])
    @talk.update_attributes(params[:talk])
    redirect_to meeting_talk_path(@meeting,@talk)
  end
  
  def destroy
    @talk = Talk.find(params[:id])
    @talk.destroy
    redirect_to meeting_talks_path(@meeting)
  end
  
  def find_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end
end
