require 'rails_helper'

RSpec.describe 'Api::V1::PotatoSharePrices', type: :request do
  let!(:potato_share_price1) { PotatoSharePrice.create!(time: DateTime.new(2023, 12, 13, 10, 0, 0), price_in_cents: 100_00) }
  let!(:potato_share_price2) { PotatoSharePrice.create!(time: DateTime.new(2023, 12, 13, 9, 0, 0),  price_in_cents: 200_00) }
  let!(:potato_share_price3) { PotatoSharePrice.create!(time: DateTime.new(2023, 12, 13, 11, 0, 0), price_in_cents: 300_00) }
  let!(:potato_share_price4) { PotatoSharePrice.create!(time: DateTime.new(2023, 12, 14, 0, 0, 0),  price_in_cents: 100_00) }

  describe 'GET /api/v1/potato_share_prices?date=<date>' do
    it 'returns a success response when date is valid' do
      get api_v1_potato_share_prices_path, params: { date: '2023-12-13' }
      expect(response).to be_successful
    end

    it 'returns the correct potato share prices on the specified date' do
      get api_v1_potato_share_prices_path, params: { date: '2023-12-13' }
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response.length).to eq(3)
      expect(parsed_response).to eq(
        [
          { time: potato_share_price2.time.as_json, value: 200.0 },
          { time: potato_share_price1.time.as_json, value: 100.0 },
          { time: potato_share_price3.time.as_json, value: 300.0 }
        ]
      )
    end

    it 'returns an error when date is invalid' do
      get api_v1_potato_share_prices_path, params: { date: 'invalid-date' }
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'GET /api/v1/potato_share_prices/max_potential_gain?date=<date>' do
    it 'returns a success response when date is valid and max potential gain can be calculated' do
      get max_potential_gain_api_v1_potato_share_prices_path, params: { date: '2023-12-13' }
      expect(response).to be_successful
    end

    it 'returns the correct max potential gain on the specified date' do
      stub_const('PotatoSharePrice::DAILY_TRADE_LIMIT', 100)
      get max_potential_gain_api_v1_potato_share_prices_path, params: { date: '2023-12-13' }
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response).to eq({ max_potential_gain: 20_000 }) # (300 - 100) * 100
    end

    it 'returns an error when data is missing on the specified date' do
      get max_potential_gain_api_v1_potato_share_prices_path, params: { date: '2023-12-10' }
      expect(response).to have_http_status(:bad_request)
    end

    it 'returns an error when date is invalid' do
      get max_potential_gain_api_v1_potato_share_prices_path, params: { date: 'invalid-date' }
      expect(response).to have_http_status(:bad_request)
    end
  end
end
