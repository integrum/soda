class UsersController < ApplicationController
  before_filter :require_admin, :except => [:index, :show, :create, :new, :email, :edit, :update, :destroy]
  before_filter :require_login, :except => [:index, :show, :create, :new]
  
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  def show
    @user = User.find(params[:id])
  end

  # render new.rhtml
  def new
    @user = User.new
  end
  
  def edit
  	if current_user.blank? or (Integer(params[:id]) != Integer(current_user.id) and !current_user.admin?)
	  	redirect_to '/'
  	end
    @user = User.find(params[:id])
  end
  
  def update
  	if current_user.blank? or (Integer(params[:id]) != Integer(current_user.id) and !current_user.admin?)
	  	redirect_to '/'
  	end
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    y @user.skills
    @user.save!
    redirect_to @user
  end
  
  def email
    @user = User.find(params[:id])
    UserMailer.deliver_message(@user, params[:message])
    flash[:notice] = "Email sent"
    redirect_to @user
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    if @user && @user.name.empty?
    	@user.name = @user.login.gsub(/[-_.]+/,' ').strip.titlecase
    end
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  def destroy
  	 if current_user.blank? or (Integer(params[:id]) != Integer(current_user.id) and !current_user.admin?)
	  	redirect_to '/'
  	end
  	@user = User.find(params[:id])
  	@user.destroy
  	redirect_to users_path
  end
end
