require 'test/unit'

path = File.expand_path(File.dirname(__FILE__) + '/../lib')
require "#{path}/wiki_column"

WikiColumn.wiki_model_name = "TestSubject"
WikiColumn.wiki_title_name = "title"
WikiColumn.wiki_base_uri = "/wiki"

class TestSubject
  include WikiColumn

  def self.pages
    @pages ||= []
  end
  def self.pages=(value)
    @pages = value
  end

  attr_accessor :id
  attr_accessor :title
  attr_accessor :description
  wiki_column :description

  def self.find_or_initialize_by_title(title)
    result = pages.find do |page|
      page.title == title
    end
    unless result 
      result = TestSubject.new
      result.title = title
    end
    result
  end
end

class WikiColumnTest < Test::Unit::TestCase
  def test_subject_instantiation
    assert ts = TestSubject.new
  end

  def test_textile_replacement
    assert ts = TestSubject.new
    ts.description = "h1. This is a test of textile\n\nParagraph\n\nAnother paragraph\n\n* Bullets"
    assert_match "<h1>", ts.wiki_description
    assert_match "</ul>", ts.wiki_description
  end

  def test_url_replacement_for_new_page
    assert ts = TestSubject.new
    ts.description = "h1. This is a test of textile\n\n[NewPage]"
    assert_match "<a href=\"/wiki/new?test_subject[title]=NewPage\">[NewPage?]</a>", ts.wiki_description
  end

  def test_url_replacement_for_existing_page
    existing_page = TestSubject.new
    existing_page.title = "WikiPage"
    existing_page.id = 1
    TestSubject.pages << existing_page

    assert ts = TestSubject.new
    ts.description = "h1. This is a test of textile\n\n[WikiPage]"

    assert_match "<a href=\"/wiki/1\">[WikiPage]</a>", ts.wiki_description
  end
end
