class PotatoSharePrice < ApplicationRecord
  DAILY_TRADE_LIMIT = 100

  validates :time,           presence: true
  validates :price_in_cents, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :on_date,         ->(date) { where(time: date.all_day) }
  scope :ordered_by_time, -> { order(time: :asc) }

  def self.max_potential_gain_on_date(date)
    share_prices = PotatoSharePrice.on_date(date)
                                   .ordered_by_time
                                   .pluck(:price_in_cents)
    return unless share_prices.count > 1

    # Calculate the maximum profit possible from buying and selling the selected potato share prices,
    # ensuring that the purchase (lowest price) occurs before the sale (highest price).
    max_diff_in_cents = max_diff_with_smaller_element_first(share_prices)

    ConversionService.cents_to_euros(DAILY_TRADE_LIMIT * max_diff_in_cents)
  end

  # 👇 Private class methods

  def self.max_diff_with_smaller_element_first(array)
    max_diff = array[1] - array[0]
    max_diff = 0 if max_diff.negative?
    min      = array.first

    array[1..].each do |num|
      diff     = num - min
      max_diff = diff if diff > max_diff
      min      = num  if num < min
    end

    max_diff
  end

  private_class_method :max_diff_with_smaller_element_first
end
