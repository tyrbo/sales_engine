require_relative 'repository'
require_relative 'transaction'

class TransactionRepository < Repository
  def self.create(args)
    transaction_id = all.max_by(&:id).id + 1
    time = Time.now.to_s
    transaction = Transaction.new(id: transaction_id,
                          invoice_id: args[:invoice_id],
                  credit_card_number: args[:credit_card_number],
         credit_card_expiration_date: args[:credit_card_expiration],
                              result: args[:result],
                          created_at: time,
                          updated_at: time)
    all << transaction
    transaction
  end
end
