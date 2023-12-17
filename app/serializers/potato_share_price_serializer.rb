class PotatoSharePriceSerializer
  def initialize(potato_share_price)
    @potato_share_price = potato_share_price
  end

  def as_json(*)
    {
      'time' => @potato_share_price.time,
      'value' => @potato_share_price.price_in_cents_to_euros
    }
  end
end
