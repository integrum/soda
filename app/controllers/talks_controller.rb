class TalksController < ApplicationController
  before_filter :find_meeting
  before_filter :require_admin, :except => [:index,:show]
  
  def index
    @talks = @meeting.talks
  end
  
  def show
    @talk = @meeting.talks.find(params[:id])
  end
  
  def new
    @talk = Talk.new
  end
  
  def create
    params[:talk].delete(:uploaded_data) if params[:talk][:uploaded_data].blank?
    @talk = Talk.new(params[:talk])
    @talk.meeting = @meeting
    
    if @talk.save
      redirect_to meeting_talk_path(@meeting,@talk)
    else
      render :action => :new
    end
  end
  
  def edit
    @talk = @meeting.talks.find(params[:id])
  end
  
  def update
    params[:talk].delete(:uploaded_data) if params[:talk][:uploaded_data].blank?
    @talk = @meeting.talks.find(params[:id])
    @talk.update_attributes(params[:talk])
    redirect_to meeting_talk_path(@meeting,@talk)
  end
  
  def destroy
    @talk = @meeting.talks.find(params[:id])
    @talk.destroy
    redirect_to meeting_talks_path(@meeting)
  end
  
  def find_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end
end
