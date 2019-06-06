require 'test_helper'

class Ujs::UploadControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get destroy_invoice" do
    get :destroy_invoice
    assert_response :success
  end

end
