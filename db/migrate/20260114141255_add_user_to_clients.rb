class AddUserToClients < ActiveRecord::Migration[8.1]
  def change
    unless column_exists?(:clients, :user_id)
      add_reference :clients, :user, null: true, foreign_key: false
    end
  end
end
