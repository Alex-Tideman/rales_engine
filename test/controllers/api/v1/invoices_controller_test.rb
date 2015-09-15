require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  test "#show" do
    get :show, format: :json, id: Invoice.last.id

    invoice = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "shipped", invoice[:status]
    assert_equal 113629430, invoice[:merchant_id]
    assert_equal 298486374, invoice[:customer_id]
  end

  test "#find" do

    get :find, format: :json, id: "113629430"

    invoice = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "shipped", invoice[:status]
    assert_equal 980190962, invoice[:merchant_id]
    assert_equal 980190962, invoice[:customer_id]
  end

  test "#find_all" do

    get :find_all, format: :json, status: "shipped"
    invoices = JSON.parse(response.body, symbolize_names: true)[:invoices]
    invoice = invoices.first

    assert_response :success
    assert_equal 3, invoices.count
    assert_equal "shipped", invoice[:status]
    assert_equal 113629430, invoice[:merchant_id]
    assert_equal 298486374, invoice[:customer_id]
  end

  test "#random" do
    get :random, format: :json
    invoice = JSON.parse(response.body, symbolize_names: true)[:invoices]

    assert_response :success
    assert_equal 1, invoice.count
  end

  test "#transactions" do

    get :transactions, format: :json, invoice_id: Invoice.first.id
    transactions = JSON.parse(response.body, symbolize_names: true)[:invoices]
    transaction = transactions.first

    assert_response :success
    assert_equal 113629430, transaction[:id]
  end

  test "#invoice_items" do

    get :transactions, format: :json, invoice_id: Invoice.first.id
    invoice_items = JSON.parse(response.body, symbolize_names: true)[:invoices]
    invoice_item = invoice_items.first

    assert_response :success
    assert_equal 113629430, invoice_item[:id]
  end
end