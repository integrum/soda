require "RedCloth"
require "active_support"

# WikiColumn
module WikiColumn

  def self.wiki_model_name=(value)
    @@wiki_model_name = value
  end
  def self.wiki_model_name
    @@wiki_model_name ||= "WikiPage"
  end

  def self.wiki_title_name=(value)
    @@wiki_title_name = value
  end
  def self.wiki_title_name
    @@wiki_title_name ||= "slug"
  end

  def self.wiki_base_uri=(value)
    @@wiki_base_uri = value
  end
  def self.wiki_base_uri
    @@wiki_base_uri ||= "/wiki"
  end

  def self.included( recipient )
    recipient.extend( ClassMethods )
  end

  module ClassMethods
    def wiki_column(*columns)
      code = "module WikiColumn::InstanceMethods\n"
      columns.each do |column|
        code += <<CODE
        def wiki_#{column}
          output = #{column}.gsub(\/\\[[\\w_-]*?\\](?![:\\(\\[])\/) do |element| 
            page = #{WikiColumn.wiki_model_name}.find_or_initialize_by_#{WikiColumn.wiki_title_name}(element.gsub(\/[\\[\\]]\/, '')) 
            if page.id 
              url = "#{WikiColumn.wiki_base_uri}/\#{page.id}"
            else 
              title = element.delete("]")
              title.delete!("[")
              element = element.gsub("]", "?]")
              url = "#{WikiColumn.wiki_base_uri}/new?#{WikiColumn.wiki_model_name.tableize.singularize}[#{WikiColumn.wiki_title_name}]=\#{title}"
            end
            "\\"\#{element}\\":\#{url}"
          end
          RedCloth.new( output ).to_html
        end
CODE
      end
      code += "end\n"
      eval(code)
      include WikiColumn::InstanceMethods
    end
  end
end

