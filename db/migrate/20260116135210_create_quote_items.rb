class CreateQuoteItems < ActiveRecord::Migration[8.1]
  def change
    create_table :quote_items do |t|
      t.references :quote, null: false, foreign_key: true
      t.string :description
      t.integer :quantity
      t.integer :unit_price

      t.timestamps
    end
  end
end
