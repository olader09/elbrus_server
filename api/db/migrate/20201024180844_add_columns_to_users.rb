class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :birthday, :string
    add_column :users, :location, :string
    add_column :users, :education, :string
    
  end
end
