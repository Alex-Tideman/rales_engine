require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test "#show" do
    get :show, format: :json, id: Item.last.id

    item = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "Tennis Raquet", item[:name]
    assert_equal "Fun on the hardcourts", item[:description]
    assert_equal "5500.0", item[:unit_price]
    assert_equal 113629430, item[:merchant_id]
  end

  test "#find" do

    get :find, format: :json, name: "running Shoes"

    item = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "Running Shoes", item[:name]
    assert_equal "Go fast!", item[:description]
    assert_equal "3250.0", item[:unit_price]
    assert_equal 113629430, item[:merchant_id]
  end

  test "#find_all" do

    get :find_all, format: :json, description: "Vroom vrooom"
    items = JSON.parse(response.body, symbolize_names: true)[:items]
    item = items.first

    assert_response :success
    assert_equal "Lambo", item[:name]
    assert_equal "Vroom vrooom", item[:description]
    assert_equal "587600.0", item[:unit_price]
    assert_equal 980190962, item[:merchant_id]
  end

  test "#random" do
    get :random, format: :json
    item = JSON.parse(response.body, symbolize_names: true)[:items]

    assert_response :success
    assert_equal 1, item.count
  end

  test "#invoice_items" do

    get :invoice_items, format: :json, item_id: Item.first.id
    invoice_items = JSON.parse(response.body, symbolize_names: true)[:items]
    invoice_item = invoice_items.first

    assert_response :success
    assert_equal 298486374, invoice_item[:id]

  end
end