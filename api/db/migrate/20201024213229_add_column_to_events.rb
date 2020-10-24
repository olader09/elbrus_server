class AddColumnToEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :user, class_name: 'user', foreign_key: 'user_id'
  end
end
