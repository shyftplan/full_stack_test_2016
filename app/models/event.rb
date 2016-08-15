class Event < ActiveRecord::Base
  include RankedModel
  ranks :order

  scope :within, -> (date) { where(start_time: (date.to_datetime..(date.to_datetime+1.day-1.second)))}

  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  def self.weekly(week)
    week.between.inject([]) do |events, date|
       events << Event.within(date).rank(:order)
    end
  end

  def drag_update(params)
    self.start_time += (params[:wday].to_i - self.start_time.wday).days
    self.end_time += (params[:wday].to_i - self.end_time.wday ).days
    self.update({order_position: params[:order_position]})
  end
end
