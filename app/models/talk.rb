class Talk < ActiveRecord::Base
  belongs_to :meeting
  belongs_to :user
  belongs_to :upload, :dependent => :destroy
  
  attr_accessor :user_id
  
  def user_id=(user_id)
    self.user = User.find(user_id)
  end
  
  def uploaded_data=(value)
    u = Upload.new
    u.uploaded_data = value
    self.upload = u
  end
end
