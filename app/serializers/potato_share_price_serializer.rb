class PotatoSharePriceSerializer
  def initialize(potato_share_price)
    @potato_share_price = potato_share_price
  end

  def as_json(*)
    {
      'time'  => @potato_share_price.time,
      'value' => ConversionService.cents_to_euros(@potato_share_price.price_in_cents)
    }
  end
end
