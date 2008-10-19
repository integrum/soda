class Meeting < ActiveRecord::Base
  has_many :rsvps
  has_many :users, :through => :rsvps
  has_many :talks, :dependent => :destroy
  
  acts_as_taggable_on :meeting_keywords
  
  def user_rsvped?(user)
    return false if user.blank?
    ! self.rsvps.find_by_user_id(user.id).blank?
  end
end
