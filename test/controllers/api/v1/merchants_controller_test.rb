require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  test "#show" do
    get :show, format: :json, id: Merchant.first.id

    merchant = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 'Yahoo', merchant[:name]
  end

  test "#find" do

    get :find, format: :json, name: "Yahoo"
    merchant = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 'Yahoo', merchant[:name]
  end

  test "#find_all" do

    get :find_all, format: :json, name: "Yahoo"
    merchants = JSON.parse(response.body, symbolize_names: true)
    merchant = merchants.first

    assert_response :success
    assert_equal 'Yahoo', merchant[:name]
    assert_equal 2, merchants.count
  end


  test "#random" do

    get :random, format: :json
    merchant = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 1, merchant.count
  end

  test "#items" do

    get :items, format: :json, merchant_id: Merchant.last.id
    items = JSON.parse(response.body, symbolize_names: true)
    item = items.first

    assert_response :success
    assert_equal 1, items.count
    assert_equal "Lambo", item[:name]
    assert_equal "Vroom vrooom", item[:description]

  end

  test "#invoices" do

    get :invoices, format: :json, merchant_id: Merchant.last.id
    invoices = JSON.parse(response.body, symbolize_names: true)
    invoice = invoices.first

    assert_response :success
    assert_equal 2, invoices.count
    assert_equal "shipped", invoice[:status]

  end

  test "#most_revenue" do

    get :most_revenue, format: :json, quantity: "2"
    merchants = JSON.parse(response.body, symbolize_names: true)
    merchant = merchants.first

    assert_response :success
    assert_equal 2, merchants.count
    assert_equal "Google", merchant[:name]
  end

  test "#most_items" do

    get :most_items, format: :json, quantity: "1"
    merchants = JSON.parse(response.body, symbolize_names: true)
    merchant = merchants.first

    assert_response :success
    assert_equal 1, merchants.count
    assert_equal "Yahoo", merchant[:name]
  end

  test "#total revenue" do

    get :revenue, format: :json
    revenue = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "17909.6", revenue[:total_revenue]
  end

  test "#total revenue with date" do

    get :revenue, format: :json, date: '2015-03-13T06:54:11.000Z'
    revenue = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "11752.0", revenue[:total_revenue]
  end

  test "#revenue for single merchant" do

    get :revenue, format: :json, merchant_id: Merchant.last.id
    revenue = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "11752.0", revenue[:revenue]
  end

  test "#revenue for single merchant with date" do

    get :revenue, format: :json, merchant_id: Merchant.first.id, date: "2012-03-13T06:54:11.000Z"
    revenue = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "281.25", revenue[:revenue]
  end

  test "#favorite_customer" do

    get :favorite_customer, format: :json, merchant_id: Merchant.last.id
    customer = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "Fred", customer[:first_name]
  end

  test "#customers_with_pending_invoices" do

  get :customers_with_pending_invoices, format: :json, merchant_id: Merchant.last.id
  customers = JSON.parse(response.body, symbolize_names: true)
  customer = customers.first

  assert_response :success
  assert_equal "Sue", customer[:first_name]
  end


end
