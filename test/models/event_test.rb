require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "event create success" do
    # prepare
    name = Faker::Name.name
    started_at_timestamp = Faker::Number.number(10).to_i
    finished_at_timestamp = started_at_timestamp + 1
    started_at = Time.at(started_at_timestamp).utc.to_time
    finished_at = Time.at(finished_at_timestamp).utc.to_time

    # action
    event  = Event.new(name, started_at, finished_at)

    # check results
    assert event.valid?
    assert_equal event.name, name
    assert_equal event.started_at, started_at
    assert_equal event.finished_at, finished_at
  end

  test "event create without params fail" do
    # action
    event  = Event.new(nil, nil, nil)
    event.save

    # check results
    assert event.invalid?
    assert_equal event.errors[:started_at], ["can't be blank"]
    assert_equal event.errors[:finished_at], ["can't be blank"]
  end

  test "event create with wrong params fail" do
    # prepare
    name = Faker::Lorem.characters(51)
    started_at = 'abcd'
    finished_at = 'abcd'

    # action
    event  = Event.new(name, started_at, finished_at)
    event.save

    # check results
    assert event.invalid?
    assert_equal event.errors[:name], ['is too long (maximum is 50 characters)']
    assert_equal event.errors[:started_at], ["can't be blank"]
    assert_equal event.errors[:finished_at], ["can't be blank"]
  end

  test "event create with wrong time fail" do
    # prepare
    name = Faker::Lorem.characters(10)
    started_at_timestamp = Faker::Number.number(10).to_i
    finished_at_timestamp = started_at_timestamp - 1
    started_at = Time.at(started_at_timestamp).utc.to_time
    finished_at = Time.at(finished_at_timestamp).utc.to_time

    # action
    event  = Event.new(name, started_at, finished_at)
    event.save

    # check results
    assert event.invalid?
    assert_equal event.errors[:finished_at], ["should be bigger than started_at"]
  end
end
