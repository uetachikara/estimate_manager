class AddForeignKeyToClientsUserId < ActiveRecord::Migration[8.1]
  def change
    # add foreign key only if it's missing
    unless foreign_key_exists?(:clients, :users)
      add_foreign_key :clients, :users
    end

    # add index if missing (optional but recommended)
    unless index_exists?(:clients, :user_id)
      add_index :clients, :user_id
    end
  end
end
