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
end
