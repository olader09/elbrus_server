class User < ApplicationRecord
  extend Enumerize

  validates :email, presence: true, uniqueness: { case_sensitive: true }
  has_secure_password
  has_and_belongs_to_many :events

  mount_uploader :avatar, UserAvatarUploader
  mount_base64_uploader :avatar, UserAvatarUploader

  enumerize :role, in: %i[user], default: :user, predicates: true, scope: :shallow

  def to_token_payload
    {
      sub: id,
      class: self.class.to_s
    }
  end

  def self.from_token_request(request)
    email = request.params&.[]('auth')&.[]('email')
    find_by email: email
  end

  def self.from_token_payload(payload)
    find(payload['sub']) if payload['sub'] && payload['class'] && payload['class'] == to_s
  end

  def superuser?
    false
  end
end
