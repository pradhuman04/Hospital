require 'test_helper'

class DoctorSpecificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get doctor_specifications_index_url
    assert_response :success
  end

end
