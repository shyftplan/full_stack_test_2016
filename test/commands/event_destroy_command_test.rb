require 'test_helper'

class EventDestroyCommandTest < ActiveSupport::TestCase
  def setup
    name = Faker::Name.name
    started_at_timestamp = Faker::Number.number(10).to_i
    finished_at_timestamp = started_at_timestamp + 1
    started_at = Time.at(started_at_timestamp).utc.to_time
    finished_at = Time.at(finished_at_timestamp).utc.to_time
    params = {name: name, started_at: started_at, finished_at: finished_at}
    EventCreateCommand.new(params).execute
  end

  test "destroy event command success" do
    # prepare
    params = {id: 1}
    command = EventDestroyCommand.new(params)

    # action
    command.execute

    # check results
    event = Event.find_by_id(1)
    assert_not_nil event.deleted_at
  end

  test "destroy not existing event command fail" do
    # prepare
    params = {id: 2}
    command = EventDestroyCommand.new(params)

    assert_raises Core::Errors::NotFoundError do
      command.execute
    end
  end
end
