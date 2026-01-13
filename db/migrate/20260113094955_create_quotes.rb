class CreateQuotes < ActiveRecord::Migration[8.1]
  def change
    create_table :quotes do |t|
      t.string :quote_no
      t.integer :status
      t.integer :subtotal
      t.integer :tax
      t.integer :total
      t.date :issued_on
      t.text :note
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
