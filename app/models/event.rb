# Adult class
# Fields:
#  [Integer]     id
#  [String]      name
#  [Time]        started_at
#  [Time]        finished_at
#  [Time]        created_at
#  [Time]        updated_at
#  [Time]        deleted_at
class Event < ApplicationRecord
  extend Core::Deletable

  validates :name, presence: true, allow_blank: true, length: { maximum: 50 }
  validates :started_at, presence: true
  validates :finished_at, presence: true
  validate :if_time_range_is_valid

  # Checks that finish time is bigger then start time
  def if_time_range_is_valid
    return unless started_at.is_a? Time and finished_at.is_a? Time
    errors.add(:finished_at, 'should be bigger than started_at') if started_at >= finished_at
  end

  # Creates an event
  # @param [String] name
  # @param [Time] started_at
  # @param [Time] finished_at
  def initialize(name, started_at, finished_at)
    super()
    self.name = name
    self.started_at = started_at
    self.finished_at = finished_at
  end
end
