# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def is_admin?
    return false if @current_user.blank?
    @current_user.admin?
  end
  
  def admin_only_content
    return false if @current_user.blank?
    yield if @current_user.admin?
  end
  
  def user_drop_down_options
    User.all.collect do |user|
      [user.email, user.id]
    end
  end
  
  
  def gravatar (email, options = {})
  	email.downcase!
  	if options[:size].nil?
  		options[:size] = 80
  	end
  	if options[:r].nil?
  		options[:r] = 'pg' #gravatar site default is g
  	end
  	# Generate Gravatar - reference implementation tweaked slightly.
	#require 'MD5' #include MD5 gem, should be part of standard ruby install
	#hash = MD5::md5(email)
	hash = 'notarealhash'
	#Ready to use in <img />:
	gravatar_image_src = "http://www.gravatar.com/avatar/#{hash}"
  	h(gravatar_image_src+"?r="+options[:r]+"&s="+Integer(options[:size]).to_s+"&d=wavatar")
  end
end
