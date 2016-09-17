# Show an event command
class EventShowCommand < Core::Command
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
    @event_presenter.event_to_hash(event)
  end
end
