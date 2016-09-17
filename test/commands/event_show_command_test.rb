require 'test_helper'

class EventShowCommandTest < ActiveSupport::TestCase
  test "show event command success" do
    # prepare
    name = Faker::Name.name
    started_at_timestamp = Faker::Number.number(10).to_i
    finished_at_timestamp = started_at_timestamp + 1
    started_at = Time.at(started_at_timestamp).utc.to_time
    finished_at = Time.at(finished_at_timestamp).utc.to_time
    params = {name: name, started_at: started_at, finished_at: finished_at}
    EventCreateCommand.new(params).execute
    params = {id: 1}
    command = EventShowCommand.new(params)

    # action
    result = command.execute

    # check results
    assert_equal result[:name], name
    assert_equal result[:started_at], started_at
    assert_equal result[:finished_at], finished_at
  end

  test "show not existing event command fail" do
    # prepare
    params = {id: 2}
    command = EventShowCommand.new(params)

    assert_raises Core::Errors::NotFoundError do
      command.execute
    end
  end
end
