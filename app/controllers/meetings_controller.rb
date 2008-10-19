class MeetingsController < ApplicationController
  def index
    @meetings = Meeting.all
  end
  
  def show
    @meeting = Meeting.find(params[:id])
  end
  
  def new
    @meeting = Meeting.new
  end
  
  def create
    @meeting = Meeting.new(params[:meeting])
    if @meeting.save
      redirect_to @meeting
    else
      render :action => :new
    end
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end
  
  def update
    @meeting = Meeting.find(params[:id])
    @meeting.update_attributes(params[:meeting])
    @meeting.save!
    redirect_to @meeting
  end
end
