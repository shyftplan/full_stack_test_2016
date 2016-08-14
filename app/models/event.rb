class Event < ActiveRecord::Base
  include RankedModel

  ranks :order
end
