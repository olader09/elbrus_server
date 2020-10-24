class SuperusersController < APIBaseController
  before_action :load_superuser
  authorize_resource
  before_action :auth_user

  def show
    render json: @superuser.to_json(except: [:password_digest])
  end

  def update
    @superuser.update(update_superuser_params)
    if @superuser.errors.blank?
      render json: @superuser, except: [:password_digest], status: :ok
    else
      render json: @superuser.errors, status: :bad_request
    end
  end


  def show_user
    user = User.find(params[:id])
    if user.errors.blank?
      render json: user.to_json(except: [:password_digest])
    else
      render status: :bad_request
    end
  end

  def index_users
    users = User.all
    if users.empty?
      render status: 204
    else
      render json: users.to_json(except: %i[password_digest])
    end
  end

  def update_user
    user = User.find(params[:id])
    if user.errors.blank?
      user.update(update_user_params)
      render json: user.to_json(except: [:password_digest])
    else
      render status: :bad_request
    end
  end

  
  protected

  def load_superuser
    @superuser = current_superuser
  end

  def default_user_fields
    %i[name surname second_name phone_number description avatar birthday location education role email password]
  end

  def update_user_params
    params.required(:user).permit(
      *default_user_fields
    )
  end

  def default_superuser_fields
    %i[login]
  end

  def update_superuser_params
    params.required(:superuser).permit(
      *default_superuser_fields
    )
  end

  def create_superuser_params
    params.required(:superuser).permit(
      *default_superuser_fields, :password
    )
  end
  
end
