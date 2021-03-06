class APIBaseController < ActionController::API
  before_action :init_redis
  include Knock::Authenticable

  def current_ability
    @current_ability ||= if current_superuser.present?
                           Ability.new(current_superuser)
                         else
                           Ability.new(current_user)
                         end
  end

  protected

  def auth_user
    if current_superuser.present?
      authenticate_superuser
    else
      authenticate_user
    end
  end

  def init_redis
    @redis = Redis.new(host: 'redis', port: 6379, db: 15)
  end
end
