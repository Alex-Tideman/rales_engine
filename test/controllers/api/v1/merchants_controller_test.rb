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
    merchants = JSON.parse(response.body, symbolize_names: true)[:merchants]
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
    items = JSON.parse(response.body, symbolize_names: true)[:merchants]
    item = items.first

    assert_response :success
    assert_equal 1, items.count
    assert_equal "Lambo", item[:name]
    assert_equal "Vroom vrooom", item[:description]

  end

  test "#invoices" do

    get :invoices, format: :json, merchant_id: Merchant.last.id
    invoices = JSON.parse(response.body, symbolize_names: true)[:merchants]
    invoice = invoices.first

    assert_response :success
    assert_equal 1, invoices.count
    assert_equal "shipped", invoice[:status]

  end

  test "#most_revenue" do

    get :most_revenue, format: :json, quantity: "2"
    merchants = JSON.parse(response.body, symbolize_names: true)[:merchants]
    merchant = merchants.first

    assert_response :success
    assert_equal 2, merchants.count
    assert_equal "Google", merchant[:name]
  end

  test "#most_items" do

    get :most_items, format: :json, quantity: "1"
    merchants = JSON.parse(response.body, symbolize_names: true)[:merchants]
    merchant = merchants.first

    assert_response :success
    assert_equal 1, merchants.count
    assert_equal "Yahoo", merchant[:name]
  end

  test "#revenue" do
    skip

    get :most_revenue, format: :json, date: 'a date'
    merchants = JSON.parse(response.body, symbolize_names: true)
    merchant = merchants.first

    assert_response :success
    assert_equal 1, merchants.count
    assert_equal "Yahoo", merchant[:name]
  end


end
