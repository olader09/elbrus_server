class Event < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  mount_uploader :picture, EventImageUploader
  mount_base64_uploader :picture, EventImageUploader
end
