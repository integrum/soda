class Upload < ActiveRecord::Base
  has_attachment :storage => :file_system, 
                 :path_prefix => 'public/uploads'
end
