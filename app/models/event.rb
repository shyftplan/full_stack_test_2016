class Event < ActiveRecord::Base
  include RankedModel

  ranks :order

  scope :within, -> (date) { where(start_time: (date.to_datetime..(date.to_datetime+1.day-1.second)))}

  def self.weekly(week)
    week.between.inject([]) do |events, date|
       events << Event.within(date)
    end
  end
end
