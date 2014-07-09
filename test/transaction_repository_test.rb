require_relative 'test_helper'

class TransactionRepositoryTest < Minitest::Test
  include RepositoryAccessors

  def test_should_create_new_records
    transaction_repository.load('./test/fixtures/transactions.csv', Transaction)

    transaction_count = transaction_repository.all.count
    time = Time.now.to_s

    transaction_repository.create(invoid_id: 1, credit_card_number: '0000000000000000', 
                                            credit_card_expiration: '05/16',
                                                            result: 'success')

    assert_equal (transaction_count + 1), transaction_repository.all.count
  end
end
