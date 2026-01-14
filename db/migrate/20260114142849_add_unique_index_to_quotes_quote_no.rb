class AddUniqueIndexToQuotesQuoteNo < ActiveRecord::Migration[8.1]
  def change
    add_index :quotes, :quote_no, unique: true
  end
end
