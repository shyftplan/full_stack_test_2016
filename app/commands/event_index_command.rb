# Index of events command
class EventIndexCommand < Core::Command
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
    events = @event_repository.find_all_not_deleted
    @event_presenter.events_to_hash(events)
  end
end
