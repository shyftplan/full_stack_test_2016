require 'rails_helper'

RSpec.describe Event, type: :model do
  let!(:event1) { create :event, start_time: '2016-08-15 01:00:00' }
  let!(:event2) { create :event, start_time: '2016-08-17 01:00:00' }

  it 'includes events in Event.weekly' do
    week = WeekView.new('2016-08-15')
    expect(Event.weekly(week)[1][0]).to eq(event1)
    expect(Event.weekly(week)[3][0]).to eq(event2)
  end
end
