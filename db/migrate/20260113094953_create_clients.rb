class CreateClients < ActiveRecord::Migration[8.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :contact_name
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
