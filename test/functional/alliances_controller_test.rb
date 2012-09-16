require 'test_helper'

class AlliancesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Alliance.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Alliance.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to alliance_url(assigns(:alliance))
  end

  def test_show
    get :show, :id => Alliance.first
    assert_template 'show'
  end

  def test_edit
    get :edit, :id => Alliance.first
    assert_template 'edit'
  end

  def test_update_invalid
    Alliance.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Alliance.first
    assert_template 'edit'
  end

  def test_update_valid
    Alliance.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Alliance.first
    assert_redirected_to alliance_url(assigns(:alliance))
  end

  def test_destroy
    alliance = Alliance.first
    delete :destroy, :id => alliance
    assert_redirected_to alliances_url
    assert !Alliance.exists?(alliance.id)
  end
end
