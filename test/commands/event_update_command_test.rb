require 'test_helper'

class EventUpdateCommandTest < ActiveSupport::TestCase
  def setup
    name = Faker::Name.name
    started_at_timestamp = Faker::Number.number(10).to_i
    finished_at_timestamp = started_at_timestamp + 1
    started_at = Time.at(started_at_timestamp).utc.to_time
    finished_at = Time.at(finished_at_timestamp).utc.to_time
    params = {name: name, started_at: started_at, finished_at: finished_at}
    EventCreateCommand.new(params).execute
  end

  test "update event command success" do
    # prepare
    id = 1
    name = Faker::Name.name
    started_at_timestamp = Faker::Number.number(10).to_i
    finished_at_timestamp = started_at_timestamp + 1
    started_at = Time.at(started_at_timestamp).utc.to_time
    finished_at = Time.at(finished_at_timestamp).utc.to_time
    params = {id: id, name: name, started_at: started_at, finished_at: finished_at}
    command = EventUpdateCommand.new(params)

    # action
    result = command.execute

    # check results
    assert_equal result[:name], name
    assert_equal result[:started_at], started_at
    assert_equal result[:finished_at], finished_at
  end

  test "update not existing event command fail" do
    # prepare
    id = 2
    name = Faker::Name.name
    started_at_timestamp = Faker::Number.number(10).to_i
    finished_at_timestamp = started_at_timestamp + 1
    started_at = Time.at(started_at_timestamp).utc.to_time
    finished_at = Time.at(finished_at_timestamp).utc.to_time
    params = {id: id, name: name, started_at: started_at, finished_at: finished_at}
    command = EventUpdateCommand.new(params)

    assert_raises Core::Errors::NotFoundError do
      command.execute
    end
  end
end
