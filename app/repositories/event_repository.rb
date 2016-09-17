# Contains methods to work with events
class EventRepository < Core::Repository
  include Core::Deletable
  # Sets all variables
  # @see Event
  def initialize
    @model = Event
  end

  # Finds all not deleted events
  # @return [Array]
  def find_all_not_deleted
    @model.not_deleted
  end
end
