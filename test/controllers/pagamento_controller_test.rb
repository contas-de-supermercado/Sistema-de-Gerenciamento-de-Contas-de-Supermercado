require 'test_helper'

class PagamentoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pagamento_index_url
    assert_response :success
  end

end
