require_relative 'test_helper'

class InvoiceItemTest < MiniTest::Test
  include RepositoryAccessors

  def setup
    invoice_repository.load(CSVLoader.new('test/fixtures/invoices.csv'), Invoice)
    item_repository.load(CSVLoader.new('test/fixtures/items.csv'), Item)
  end

  def data
    { id: '1',
      item_id: '1',
      invoice_id: '1',
      quantity: '6',
      unit_price: '1000',
      created_at: Time.now,
      updated_at: Time.now
      }
  end

  def test_can_create_an_invoice_item
    i = InvoiceItem.new(data)
    assert_equal 1, i.id
    assert_equal 1, i.item_id
    assert_equal 1, i.invoice_id
    assert_equal 6, i.quantity
    assert_equal BigDecimal.new('10.00'), i.unit_price
    assert i.created_at
    assert i.updated_at
  end

  def test_invoice_returns_instance_of_invoice
    invoice_item = InvoiceItem.new(data)
    invoice = invoice_item.invoice

    assert_equal 1, invoice.id
    assert_equal 'shipped', invoice.status
    assert invoice.created_at
    assert invoice.updated_at
  end

  def test_item_returns_instance_of_item
    invoice_item = InvoiceItem.new(data)
    item = invoice_item.item

    assert_equal 'Item Qui Esse', item.name
    assert_equal 'Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.', item.description
    assert item.created_at
    assert item.updated_at
  end

end
