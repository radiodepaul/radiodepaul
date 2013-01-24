class SlotSerializer < ApplicationSerializer
  attributes :id, :quarter, :start_time, :end_time

  has_one :show, serializer: ShortShowSerializer
end
