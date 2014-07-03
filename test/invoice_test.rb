require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/transaction'
require_relative '../lib/invoice_item'
require_relative '../lib/customer'
require_relative '../lib/merchant'

class InvoiceTest < MiniTest::Test
  def data
    data = { id: '1',
             customer_id: '1',
             merchant_id: '1',
             status: 'shipped',
             created_at: Time.now.to_s,
             updated_at: Time.now.to_s
             }
  end

  def test_can_create_an_invoice
    i = Invoice.new(data)

    assert_equal '1', i.id
    assert_equal '1', i.customer_id
    assert_equal '1', i.merchant_id
    assert_equal 'shipped', i.status
    assert i.created_at
    assert i.updated_at
  end

  def test_can_find_related_transactions
    TransactionRepository.load('test/fixtures/transactions.csv', Transaction)
    invoice = Invoice.new(data)
    transactions = invoice.transactions

    assert_equal 2, transactions.count

    trans1, trans2 = transactions
    assert_equal '1', trans1.id
    assert_equal '4654405418249632', trans1.credit_card_number
    assert_equal '2', trans2.id
    assert_equal '4580251236515201', trans2.credit_card_number
  end

  def test_can_find_invoice_items
    InvoiceItemRepository.load('test/fixtures/invoice_items.csv', InvoiceItem)
    invoice = Invoice.new(data)
    items = invoice.invoice_items

    assert_equal 8, items.count

    item1, item2, item3 = items

    assert_equal '1', item1.id
    assert_equal '1', item1.item_id
    assert_equal '5', item1.quantity
    assert_equal '13635', item1.unit_price

    assert_equal '2', item2.id
    assert_equal '2', item2.item_id
    assert_equal '9', item2.quantity
    assert_equal '23324', item2.unit_price

    assert_equal '3', item3.id
    assert_equal '3', item3.item_id
    assert_equal '8', item3.quantity
    assert_equal '34873', item3.unit_price
  end

  def test_can_find_items_in_invoice_item
    InvoiceItemRepository.load('test/fixtures/invoice_items.csv',InvoiceItem)
    invoice = Invoice.new(data)
    item = invoice.items
    item1, item2, item3 = item

    assert_equal '13635', item1.unit_price
    assert_equal '5', item1.quantity

    assert_equal '29973', item2.unit_price
    assert_equal '6', item2.quantity

    refute item3

  end

  def test_can_find_the_customer
    CustomerRepository.load('test/fixtures/customers.csv', Customer)
    invoice = Invoice.new(data)
    customer = invoice.customer

    assert_equal '1', customer.id
    assert_equal 'Joey', customer.first_name
    assert_equal 'Ondricka', customer.last_name
  end

  def test_can_find_merchant
    MerchantRepository.load('test/fixtures/merchants.csv', Merchant)
    invoice = Invoice.new(data)
    merchant = invoice.merchant

    assert_equal '1', merchant.id
    assert_equal 'Schroeder-Jerde', merchant.name
  end
end
