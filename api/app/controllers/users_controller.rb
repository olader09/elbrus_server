class UsersController < APIBaseController
  before_action :load_user, except: %i[create]
  authorize_resource except: %i[create]
  before_action :auth_user, except: %i[create]

  def show
    render json: @user.to_json(except: %i[password_digest])
  end

  def update
    @user.update(update_user_params)
    if @user.errors.blank?
      render status: :ok
    else
      render json: @user.errors, status: :bad_request
    end
  end

  def create
    @user = User.create(create_user_params)
    if @user.errors.blank?
      render json: @user.to_json(except: :password_digest)
    else
      render json: @user.errors, status: :bad_request
    end
  end

  def join_to_event
    event = Event.find(params[:id])
    if event.errors.blank?
      if event.users.include? @user
        return render status: 208
      end
      if event.status == 2
        return render status: 403
      end
      event.users << @user
      render status: :ok
    else
      render json: event.errors, status: :bad_request
    end
  end

  def close_event
    if @user.id == @user.event.user_id
      @user.event.update(status: 2)
      @user.event.users.each {|user| user.achivments[@user.event.tag] += rand(1..10); user.save}
      render status: :ok
    else
      render status: :forbidden
    end
  end


  protected

  def load_user
    @user = current_user
  end

  def default_user_fields
    %i[name surname second_name phone_number description avatar birthday location education]
  end

  def update_user_params
    params.required(:user).permit(
      *default_user_fields
    )
  end

  def create_user_params
    params.required(:user).permit(
      *default_user_fields, :email, :password
    )
  end
end
