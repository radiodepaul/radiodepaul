class SlotSerializer < ApplicationSerializer
  attributes :id, :quarter, :start_time, :end_time, :days

  has_one :show
end
