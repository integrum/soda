class WikiPage < ActiveRecord::Base
  validates_uniqueness_of :slug
  wiki_column :body
  
  named_scope :random_set, :order => 'RAND()'
  named_scope :most_recent_10, :order => 'created_at DESC', :limit => 10
end
