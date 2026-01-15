class MigrateProjectStatusToInteger < ActiveRecord::Migration[8.1]
  def up
    unless column_exists?(:projects, :status_int)
      add_column :projects, :status_int, :integer, null: false, default: 0
    end

    # status が数値扱いでも文字列でも落ちない安全版
    execute <<~SQL
      UPDATE projects
      SET status_int =
        CASE
          WHEN status IN (0, 1, 2) THEN status
          WHEN status = 'lead' THEN 0
          WHEN status = 'active' THEN 1
          WHEN status = 'closed' THEN 2
          ELSE 0
        END
    SQL

    # すでに入れ替え済みなら何もしない
    if column_exists?(:projects, :status) && column_exists?(:projects, :status_int)
      remove_column :projects, :status
      rename_column :projects, :status_int, :status
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
