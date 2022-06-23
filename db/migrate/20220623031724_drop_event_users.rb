class DropEventUsers < ActiveRecord::Migration[7.0]
  def change
    drop_table :event_users, if_exists: true
  end
end
