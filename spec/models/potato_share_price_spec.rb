require 'rails_helper'

RSpec.describe PotatoSharePrice, type: :model do
  describe 'validations' do
    let!(:potato_share_price1) { PotatoSharePrice.create!(time: DateTime.new(2023, 12, 16, 12, 0, 0), price_in_cents: 100) }

    it 'is valid with valid time and price_in_cents' do
      expect(potato_share_price1).to be_valid
    end

    it 'is not valid without time' do
      potato_share_price1.time = nil
      expect(potato_share_price1).not_to be_valid
    end

    it 'is not valid without price_in_cents' do
      potato_share_price1.price_in_cents = nil
      expect(potato_share_price1).not_to be_valid
    end

    it 'is not valid if price_in_cents is negative' do
      potato_share_price1.price_in_cents = -1_00
      expect(potato_share_price1).not_to be_valid
    end

    it 'is not valid if price_in_cents is not an integer' do
      potato_share_price1.price_in_cents = 10.0
      expect(potato_share_price1).not_to be_valid
    end
  end
end
