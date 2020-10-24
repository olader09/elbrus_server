class EventsController < APIBaseController
  authorize_resource except: %i[index show]
  before_action :auth_user, except: %i[index show]

  def index
    events = Event.all
    if events.empty?
      render status: 204
    else
      render json: events
    end
  end

  def show
    @event = Event.find(params[:id])
    if @event.errors.blank?
      render json: @event.to_json(include: {
                                    users:{
                                      only: %i[id name surname second_name avatar]
                                    }
                                  }
                                )
    else
      render json: @event.errors, status: :bad_request
    end
  end

  def update
    @event = Event.find(params[:id])
    @event.update(update_event_params)
    if @event.errors.blank?
      render json: @event
    else
      render json: @event.errors, status: :bad_request
    end
  end

  def create
    @event = Event.create(create_event_params)
    if @event.errors.blank?
      render json: @event
    else
      render json: @event.errors, status: :bad_request
    end
  end


  protected

  def default_event_fields
    %i[tag name description picture time date user_id]
  end

  def update_event_params
    params.required(:event).permit(
      *default_event_fields
    )
  end

  def create_event_params
    params.required(:event).permit(
      *default_event_fields
    )
  end
end
