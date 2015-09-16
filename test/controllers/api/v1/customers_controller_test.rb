require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase
  test "#show" do
    get :show, format: :json, id: Customer.last.id

    customer = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "Fred", customer[:first_name]
    assert_equal "Jones", customer[:last_name]
  end

  test "#find" do

    get :find, format: :json, last_name: "Bluebird"

    customer = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "Sue", customer[:first_name]
    assert_equal "Bluebird", customer[:last_name]
  end

  test "#find_all" do

    get :find_all, format: :json, first_name: "Fred"
    customers = JSON.parse(response.body, symbolize_names: true)[:customers]
    customer = customers.first

    assert_response :success
    assert_equal "Fred", customer[:first_name]
    assert_equal "Jones", customer[:last_name]
  end

  test "#random" do
    get :random, format: :json
    customer = JSON.parse(response.body, symbolize_names: true)[:customers]

    assert_response :success
    assert_equal 1, customer.count
  end

  test "#invoices" do

    get :invoices, format: :json, customer_id: Customer.last.id
    invoices = JSON.parse(response.body, symbolize_names: true)[:customers]
    invoice = invoices.first

    assert_response :success
    assert_equal 980190962, invoice[:customer_id]
  end

  test "#transactions" do

    get :transactions, format: :json, customer_id: Customer.first.id
    transactions = JSON.parse(response.body, symbolize_names: true)[:customers]
    transaction = transactions.first

    assert_response :success
    assert_equal "523423425235", transaction[:credit_card_number]
  end
end