puts 'Destroying potato share prices'
PotatoSharePrice.delete_all

puts 'Create potato share prices'
start_time        = DateTime.new(2023, 12, 11, 0, 0, 0)
seconds_in_7_days = 7 * 24 * 60 * 60
price             = 205_00
records           = []

puts 'Creating fake PotatoSharePrice instances over the last 7 days...'

seconds_in_7_days.times do |i|
  # Gradually increase the range of the random fluctuation over time
  fluctuation = rand((-1 - (i / seconds_in_7_days))..(1 + (i / seconds_in_7_days)))
  price += fluctuation

  # Constrain price to a range of 20000 to 21000 cents
  price = price.clamp(200_00, 210_00)

  records << { time: start_time + i.seconds, price_in_cents: price }
end

PotatoSharePrice.insert_all(records)

puts "Finished: #{PotatoSharePrice.count} potato share prices have been successfully created"
