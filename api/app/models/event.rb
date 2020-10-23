class Event < ApplicationRecord
  has_and_belongs_to_many :users

  mount_uploader :picture, EventImageUploader
  mount_base64_uploader :picture, EventImageUploader
end
