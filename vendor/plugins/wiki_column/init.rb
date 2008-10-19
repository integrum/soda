if not Object.constants.include? "WIKI_MODEL_NAME"
  WIKI_MODEL_NAME = "WikiPage"
end
if not Object.constants.include? "WIKI_TITLE_NAME"
  WIKI_TITLE_NAME = "slug"
end
if not Object.constants.include? "WIKI_BASE_URI"
  WIKI_BASE_URI = "/wiki"
end

path = File.expand_path(File.dirname(__FILE__) + '/lib/')
dir = Dir.new(path)
dir.entries.each do |file|
  next unless file.match(/\.rb$/)
  require path + "/" + file
end

ActiveRecord::Base.send( :include, 
  WikiColumn
)
