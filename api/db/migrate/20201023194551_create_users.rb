class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :surname, defailt: ''
      t.string :second_name, default: ''
      t.string :password_digest
      t.string :email, null: false
      t.string :phone_number, default: ''
      t.string :description, default: ''
      t.string :avatar
      t.string :role, default: 'user'
      t.integer :rank, default: 0
      t.timestamps
    end
  end
end
