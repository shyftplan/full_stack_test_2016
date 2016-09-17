class EventsController < Core::Controller
  # Creates an event
  # @see EventCreateCommand
  def create
    command = EventCreateCommand.new(params)
    run(command)
  end

  # Updates an event
  # @see EventUpdateCommand
  def update
    command = EventUpdateCommand.new(params)
    run(command)
  end

  # Shows an event
  # @see EventShowCommand
  def show
    command = EventShowCommand.new(params)
    run(command)
  end

  # Show a list of events
  # @see EventIndexCommand
  def index
    command = EventIndexCommand.new(params)
    run(command)
  end

  # Destroys an event
  # @see EventDestroyCommand
  def destroy
    command = EventDestroyCommand.new(params)
    run(command)
  end
end