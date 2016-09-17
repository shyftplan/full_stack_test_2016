# Contains methods to show events
class EventPresenter < Core::Presenter
  # Gets hash from an event
  # @param [Event] event
  # @return [Hash]
  def event_to_hash(event)
    {
      id: event.id,
      name: event.name,
      started_at: event.started_at,
      finished_at: event.finished_at
    }
  end

  # Gets hash from an events
  # @param [Array] events
  # @return [Hash]
  def events_to_hash(events)
    events.map do |event|
      event_to_hash(event)
    end
  end
end
