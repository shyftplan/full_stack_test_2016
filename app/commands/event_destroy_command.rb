# Destroy an event command
class EventDestroyCommand < Core::Command
  attr_accessor :id, :name, :started_at, :finished_at

  # Sets all variables
  # @param [Object] params
  # @see EventRepository
  def initialize(params)
    super(params)
    @event_repository = EventRepository.get
  end

  # Runs command
  # @return [Hash]
  def execute
    event = @event_repository.find_not_deleted_by_id!(id)
    @event_repository.delete(event)
    nil
  end
end
