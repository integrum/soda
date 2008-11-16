# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  
  helper :all # include all helpers, all the time
  before_filter :logged_in?
  before_filter :set_current_user

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '2fbc1a365df10f68dec85e6de7d1470d'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  def set_current_user
    if logged_in?
    @current_user = current_user
    end
  end
  
  def require_login
    unless logged_in?
      flash[:notice] = "You must be logged in to perform this action."
      redirect_to '/'
    end
    
    true
  end
  
  def require_admin
    self.require_login
    unless @current_user.blank? or @current_user.admin?
      flash[:notice] = "You must be an admin to perform this action."
      redirect_to '/'
    end
  end
 end
