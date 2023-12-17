class PotatoSharePrice < ApplicationRecord
  validates :time, presence: true
  validates :price_in_cents, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :on_date,         ->(date) { where(time: date.all_day) }
  scope :ordered_by_time, -> { order(time: :asc) }
end
