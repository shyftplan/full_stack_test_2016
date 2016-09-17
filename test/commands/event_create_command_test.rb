require 'test_helper'

class EventCreateCommandTest < ActiveSupport::TestCase
  test "create event command success" do
    # prepare
    name = Faker::Name.name
    started_at_timestamp = Faker::Number.number(10).to_i
    finished_at_timestamp = started_at_timestamp + 1
    started_at = Time.at(started_at_timestamp).utc.to_time
    finished_at = Time.at(finished_at_timestamp).utc.to_time
    params = {name: name, started_at: started_at, finished_at: finished_at}
    command = EventCreateCommand.new(params)

    # action
    result = command.execute

    # check results
    assert_not_nil result[:id]
    assert_equal result[:name], name
    assert_equal result[:started_at], started_at
    assert_equal result[:finished_at], finished_at
  end
end
