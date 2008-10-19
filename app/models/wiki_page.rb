class WikiPage < ActiveRecord::Base
  validates_uniqueness_of :slug
  wiki_column :body
end
