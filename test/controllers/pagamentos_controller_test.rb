require 'test_helper'

class PagamentosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pagamentos_index_url
    assert_response :success
  end

end
