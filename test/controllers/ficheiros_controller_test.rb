require 'test_helper'

class FicheirosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ficheiros_index_url
    assert_response :success
  end

end
