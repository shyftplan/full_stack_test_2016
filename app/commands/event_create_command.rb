# Create an event command
class EventCreateCommand < Core::Command
  attr_accessor :name, :started_at, :finished_at

  # Sets all variables
  # @param [Object] params
  # @see Event
  # @see EventRepository
  # @see EventPresenter
  def initialize(params)
    super(params)
    @event_model = Event
    @event_repository = EventRepository.get
    @event_presenter = EventPresenter.get
  end


  # Runs command
  # @return [Hash]
  def execute
    event = @event_model.new(name, started_at, finished_at)
    event = @event_repository.save!(event)
    @event_presenter.event_to_hash(event)
  end
end
