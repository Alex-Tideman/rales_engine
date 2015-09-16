require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase

  test "#index" do
    get :index, format: :json

    items = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 3, items.count
  end

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

    get :find, format: :json, name: "Running Shoes"

    item = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "Running Shoes", item[:name]
    assert_equal "Go fast!", item[:description]
    assert_equal "3250.0", item[:unit_price]
    assert_equal 113629430, item[:merchant_id]
  end

  test "#find_all" do

    get :find_all, format: :json, description: "Vroom vrooom"
    items = JSON.parse(response.body, symbolize_names: true)
    item = items.first

    assert_response :success
    assert_equal "Lambo", item[:name]
    assert_equal "Vroom vrooom", item[:description]
    assert_equal "587600.0", item[:unit_price]
    assert_equal 980190962, item[:merchant_id]
  end

  test "#random" do
    get :random, format: :json
    item = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 1, item.count
  end

  test "#invoice_items" do

    get :invoice_items, format: :json, item_id: Item.first.id
    invoice_items = JSON.parse(response.body, symbolize_names: true)
    invoice_item = invoice_items.first

    assert_response :success
    assert_equal 298486374, invoice_item[:id]

  end

  test "#merchant" do

    get :merchant, format: :json, item_id: Item.last.id
    merchant = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "Yahoo", merchant[:name]

  end

  test "#most_revenue" do

    get :most_revenue, format: :json, quantity: "2"
    items = JSON.parse(response.body, symbolize_names: true)
    item = items.first

    assert_response :success
    assert_equal 2, items.count
    assert_equal "Lambo", item[:name]
  end

  test "#most_items" do

    get :most_items, format: :json, quantity: "1"
    items = JSON.parse(response.body, symbolize_names: true)
    item = items.first

    assert_response :success
    assert_equal "Tennis Raquet", item[:name]
    assert_equal "Fun on the hardcourts", item[:description]
  end

  test "#best_day" do

    get :best_day, format: :json, item_id: Item.last.id
    item = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "2012-03-13T06:54:11.000Z", item[:best_day]
  end
end