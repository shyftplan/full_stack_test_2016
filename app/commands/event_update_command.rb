# Update an event command
class EventUpdateCommand < Core::Command
  attr_accessor :id, :name, :started_at, :finished_at

  # Sets all variables
  # @param [Object] params
  # @see EventRepository
  # @see EventPresenter
  def initialize(params)
    super(params)
    @event_repository = EventRepository.get
    @event_presenter = EventPresenter.get
  end

  # Runs command
  # @return [Hash]
  def execute
    event = @event_repository.find_not_deleted_by_id!(id)
    event.name = name
    event.started_at = started_at
    event.finished_at = finished_at
    event = @event_repository.save!(event)
    @event_presenter.event_to_hash(event)
  end
end
