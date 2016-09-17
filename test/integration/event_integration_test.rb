require 'test_helper'

class EventIntegrationTest < ActionDispatch::IntegrationTest
  test 'events live cycle success' do
    # Creating test
    events = []
    3.times do
      name = Faker::Name.name
      started_at_timestamp = Faker::Number.number(10).to_i
      finished_at_timestamp = started_at_timestamp + 1
      started_at = Time.at(started_at_timestamp).utc.to_time
      finished_at = Time.at(finished_at_timestamp).utc.to_time
      params = {name: name, started_at: started_at, finished_at: finished_at}
      post '/api/v1/events', params: params

      assert_response 200
      json = JSON.parse(response.body)
      id = json['id']
      params[:id] = id
      events.push params
    end

    # Showing test
    id = events[0][:id]
    get "/api/v1/events/#{id}"
    assert_response 200

    event = JSON.parse(response.body)
    assert_equal event['id'], events[0][:id]
    assert_equal event['name'], events[0][:name]
    assert_equal Time.parse(event['started_at']), events[0][:started_at]
    assert_equal Time.parse(event['finished_at']), events[0][:finished_at]

    # Updating test
    name = Faker::Name.name
    started_at_timestamp = Faker::Number.number(10).to_i
    finished_at_timestamp = started_at_timestamp + 1
    started_at = Time.at(started_at_timestamp).utc.to_time
    finished_at = Time.at(finished_at_timestamp).utc.to_time
    params = { name: name, started_at: started_at, finished_at: finished_at}
    put "/api/v1/events/#{id}", params: params

    assert_response 200
    event = JSON.parse(response.body)
    assert_equal event['name'], name
    assert_equal Time.parse(event['started_at']), started_at
    assert_equal Time.parse(event['finished_at']), finished_at

    # Destroying test
    delete "/api/v1/events/#{id}"

    assert_response 204
    event = Event.find_by_id(id)
    assert_not_nil event.deleted_at

    # Indexing test
    get '/api/v1/events'

    assert_response 200
    json = JSON.parse(response.body)
    assert_equal json.size, 2
    2.times do |i|
      assert_equal json[i]['id'], events[i+1][:id]
      assert_equal json[i]['name'], events[i+1][:name]
      assert_equal Time.parse(json[i]['started_at']), events[i+1][:started_at]
      assert_equal Time.parse(json[i]['finished_at']), events[i+1][:finished_at]
    end
  end

  test 'events not found errors fail' do
    # Showing test
    id = Faker::Number.number(9)
    get "/api/v1/events/#{id}"
    assert_response 404

    # Updating test
    put "/api/v1/events/#{id}"
    assert_response 404

    # Destoying test
    delete "/api/v1/events/#{id}"
    assert_response 404
  end

  test 'events create validation fail' do
    # action
    post '/api/v1/events'

    # check results
    assert_response 422
    json = JSON.parse(response.body)
    assert_includes json['started_at'], "can't be blank"
    assert_includes json['finished_at'], "can't be blank"
  end

  test 'events update validation fail' do
    # prepare
    name = Faker::Name.name
    started_at_timestamp = Faker::Number.number(10).to_i
    finished_at_timestamp = started_at_timestamp + 1
    started_at = Time.at(started_at_timestamp).utc.to_time
    finished_at = Time.at(finished_at_timestamp).utc.to_time
    params = {name: name, started_at: started_at, finished_at: finished_at}
    post '/api/v1/events', params: params

    # action
    put '/api/v1/events/1'

    # check results
    assert_response 422
    json = JSON.parse(response.body)
    assert_includes json['started_at'], "can't be blank"
    assert_includes json['finished_at'], "can't be blank"
  end
end