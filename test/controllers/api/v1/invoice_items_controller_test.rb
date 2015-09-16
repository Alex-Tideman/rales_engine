require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
  test "#show" do
    get :show, format: :json, id: InvoiceItem.last.id

    invoice_item = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 5, invoice_item[:quantity]
    assert_equal "56.25", invoice_item[:unit_price]
    assert_equal 980190962, invoice_item[:item_id]
    assert_equal 980190962, invoice_item[:invoice_id]
  end

  test "#find" do

    get :find, format: :json, quantity: "2"

    invoice_item = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 2, invoice_item[:quantity]
    assert_equal "5876.0", invoice_item[:unit_price]
    assert_equal 113629430, invoice_item[:item_id]
    assert_equal 113629430, invoice_item[:invoice_id]
  end

  test "#find_all" do

    get :find_all, format: :json, unit_price: "5876.0"
    invoice_items = JSON.parse(response.body, symbolize_names: true)
    invoice_item = invoice_items.first

    assert_response :success
    assert_equal 2, invoice_item[:quantity]
    assert_equal "5876.0", invoice_item[:unit_price]
    assert_equal 113629430, invoice_item[:item_id]
    assert_equal 113629430, invoice_item[:invoice_id]
  end

  test "#random" do
    get :random, format: :json
    invoice_item = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 1, invoice_item.count
  end

  test "#invoice" do

    get :invoice, format: :json, invoice_item_id: InvoiceItem.last.id
    invoice = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 298486374, invoice[:customer_id]
  end

  test "#item" do

    get :item, format: :json, invoice_item_id: InvoiceItem.first.id
    item = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "Lambo", item[:name]
  end
end