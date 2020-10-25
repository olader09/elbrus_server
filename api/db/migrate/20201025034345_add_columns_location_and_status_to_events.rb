class AddColumnsLocationAndStatusToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :status, :integer, default: 0
    add_column :events, :location, :string, default: ''
  end
end
