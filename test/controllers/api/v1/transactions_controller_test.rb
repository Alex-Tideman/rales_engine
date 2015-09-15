require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase
  test "#show" do
    get :show, format: :json, id: Transaction.first.id

    transaction = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "234092342093", transaction[:credit_card_number]
    assert_equal "success", transaction[:result]
    assert_equal 113629430, transaction[:invoice_id]
  end

  test "#find" do

    get :find, format: :json, invoice_id: "113629430"

    transaction = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "234092342093", transaction[:credit_card_number]
    assert_equal "success", transaction[:result]
    assert_equal 113629430, transaction[:invoice_id]
  end

  test "#find_all" do

    get :find_all, format: :json, result: "success"
    transactions = JSON.parse(response.body, symbolize_names: true)[:transactions]
    transaction = transactions.first

    assert_response :success
    assert_equal 3, transactions.count
    assert_equal "523423425235", transaction[:credit_card_number]
    assert_equal "success", transaction[:result]
    assert_equal 980190962, transaction[:invoice_id]
  end

  test "#find_all with lowercase" do

    get :find_all, format: :json, result: "suCCess"
    transactions = JSON.parse(response.body, symbolize_names: true)[:transactions]
    transaction = transactions.first

    assert_response :success
    assert_equal 3, transactions.count
    assert_equal "523423425235", transaction[:credit_card_number]
    assert_equal "success", transaction[:result]
    assert_equal 980190962, transaction[:invoice_id]
  end

  test "#random" do
    get :random, format: :json
    transaction = JSON.parse(response.body, symbolize_names: true)[:transactions]

    assert_response :success
    assert_equal 1, transaction.count
  end

  test "#invoice" do

    get :invoice, format: :json, transaction_id: Transaction.last.id
    invoice = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 980190962, invoice[:id]

  end
end