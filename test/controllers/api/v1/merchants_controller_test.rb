require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  test "#show" do
    get :show, format: :json, id: Merchant.first.id

    merchant = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 'Yahoo', merchant[:name]
  end

  test "#find" do

    name_params = { name: "Yahoo" }

    get :find, format: :json, name: name_params.values
    merchant = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 'Yahoo', merchant[:name]
  end

  test "#find with lowercase" do

    name_params = { name: "yaHoo" }

    get :find, format: :json, name: name_params.values
    merchant = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 'Yahoo', merchant[:name]
  end

  test "#find_all" do

    name_params = { name: "Yahoo" }

    get :find_all, format: :json, name: name_params.values
    merchants = JSON.parse(response.body, symbolize_names: true)
    merchant = merchants[:merchants].first

    assert_response :success
    assert_equal 'Yahoo', merchant[:name]
    assert_equal 2, merchants[:merchants].count
  end

  test "#find_all with lowercase" do

    name_params = { name: "yahoo" }

    get :find_all, format: :json, name: name_params.values
    merchants = JSON.parse(response.body, symbolize_names: true)
    merchant = merchants[:merchants].first

    assert_response :success
    assert_equal 'Yahoo', merchant[:name]
    assert_equal 2, merchants[:merchants].count
  end

  test "#random" do

    get :random, format: :json
    merchant = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 1, merchant.count
  end

  test "#items" do

    get :items, format: :json, id: Merchant.first.id
    items = JSON.parse(response.body, symbolize_names: true)
    item = items.first

    assert_response :success
    assert_equal 2, items.count
    assert_equal "Tennis Raquet", item[:name]

  end

  test "#invoices" do

    get :invoices, format: :json, id: Merchant.first.id
    invoices = JSON.parse(response.body, symbolize_names: true)
    invoice = invoices.first

    assert_response :success
    assert_equal 2, invoices.count
    assert_equal "shipped", invoice[:status]

  end

  test "#most_revenue" do
    skip

    params = { quantity: "1" }

    get :find_all, format: :json
    get :most_revenue, format: :json
    merchant = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 1, merchant.count
    assert_equal "Yahoo", merchant[:name]
  end

  test "#most_items" do
    skip
    params = { quantity: "1" }

    get :most_revenue, format: :json
    merchant = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 1, merchant.count
    assert_equal "Yahoo", merchant[:name]
  end

  test "#revenue" do
    skip

    get :most_revenue, format: :json
    merchant = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 1, merchant.count
    assert_equal "Yahoo", merchant[:name]
  end


end
