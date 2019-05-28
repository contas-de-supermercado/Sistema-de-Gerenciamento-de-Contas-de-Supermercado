require 'test_helper'

class ContasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get contas_index_url
    assert_response :success
  end

end
