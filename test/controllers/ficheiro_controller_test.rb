require 'test_helper'

class FicheiroControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ficheiro_index_url
    assert_response :success
  end

end
