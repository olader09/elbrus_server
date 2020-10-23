class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :description, default: ''
      t.string :picture
      t.string :tag
      t.string :time, null: false
      t.string :date, null: false
      t.timestamps
    end
  end
end
