class User < ApplicationRecord
  extend Enumerize

  validates :email, presence: true, uniqueness: { case_sensitive: true }
  has_secure_password
  has_and_belongs_to_many :events
  has_one :event

  mount_uploader :avatar, UserAvatarUploader
  mount_base64_uploader :avatar, UserAvatarUploader

  enumerize :role, in: %i[user speaker], default: :user, predicates: true, scope: :shallow

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

  def rand_achivments!
    self.achivments['fin'] = rand(0..1000)
    self.achivments['family'] = rand(0..1000)
    self.achivments['lead'] = rand(0..1000)
    self.achivments['projactiv'] = rand(0..1000)
    self.achivments['networking'] = rand(0..1000)
    self.achivments['proforient'] = rand(0..1000)
    self.save
  end

  def superuser?
    false
  end
end
