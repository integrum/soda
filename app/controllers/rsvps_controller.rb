class RsvpsController < ApplicationController
  before_filter :login_required
  before_filter :find_meeting
  before_filter :find_rsvp, :only => [:update]
  
  def create
    @meeting.users << @current_user
    flash[:notice] = "You have been RSVPed."
    redirect_to @meeting
  end
  
  def update
    @rsvp.present = !@rsvp.present
    @rsvp.save!
    render :nothing => true
  end
  
  def find_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end
  
  def find_rsvp
    @rsvp = Rsvp.find(params[:id])
  end
end
