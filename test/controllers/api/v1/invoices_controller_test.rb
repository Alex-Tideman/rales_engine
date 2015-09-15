require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json

    items = JSON.parse(response.body)
    item = items.last

    assert_response :success
    assert_equal 2, items.count
    assert_equal 'Jon Snow', item["name"]
  end
end