require 'test_helper'

class EventIndexCommandTest < ActiveSupport::TestCase
  test "index event command success" do
    # prepare
    events = []
    5.times do |i|
      name = Faker::Name.name
      started_at_timestamp = Faker::Number.number(10).to_i
      finished_at_timestamp = started_at_timestamp + 1
      started_at = Time.at(started_at_timestamp).utc.to_time
      finished_at = Time.at(finished_at_timestamp).utc.to_time
      params = {id: i + 1, name: name, started_at: started_at, finished_at: finished_at}
      events.push params
      EventCreateCommand.new(params).execute
    end
    command = EventIndexCommand.new({})

    # action
    result = command.execute

    # check results
    assert_equal result.size, 5
    5.times do |i|
      assert_equal result[i][:id], events[i][:id]
      assert_equal result[i][:name], events[i][:name]
      assert_equal result[i][:started_at], events[i][:started_at]
      assert_equal result[i][:finished_at], events[i][:finished_at]
    end
  end

  test "index event command without events success" do
    # prepare
    command = EventIndexCommand.new({})

    # action
    result = command.execute

    # check results
    assert_equal result.size, 0
  end
end
