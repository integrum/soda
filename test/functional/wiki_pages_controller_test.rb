require 'test_helper'

class WikiPagesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:wiki_pages)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_wiki_page
    assert_difference('WikiPage.count') do
      post :create, :wiki_page => { }
    end

    assert_redirected_to wiki_page_path(assigns(:wiki_page))
  end

  def test_should_show_wiki_page
    get :show, :id => wiki_pages(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => wiki_pages(:one).id
    assert_response :success
  end

  def test_should_update_wiki_page
    put :update, :id => wiki_pages(:one).id, :wiki_page => { }
    assert_redirected_to wiki_page_path(assigns(:wiki_page))
  end

  def test_should_destroy_wiki_page
    assert_difference('WikiPage.count', -1) do
      delete :destroy, :id => wiki_pages(:one).id
    end

    assert_redirected_to wiki_pages_path
  end
end
