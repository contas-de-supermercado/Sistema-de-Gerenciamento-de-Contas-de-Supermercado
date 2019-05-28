require 'test_helper'

class FuncionariosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get funcionarios_index_url
    assert_response :success
  end

end
