require 'rails_helper'

RSpec.describe PotatoSharePrice, type: :model do
  let!(:date)                { Date.new(2023, 12, 16) }
  let!(:potato_share_price1) { PotatoSharePrice.create!(time: DateTime.new(2023, 12, 16, 15, 0, 0), price_in_cents: 100) }
  let!(:potato_share_price2) { PotatoSharePrice.create!(time: DateTime.new(2023, 12, 16, 12, 0, 0), price_in_cents: 200) }
  let!(:potato_share_price3) { PotatoSharePrice.create!(time: DateTime.new(2023, 12, 15, 10, 0, 0), price_in_cents: 300) }

  describe 'validations' do
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

  describe 'scopes' do
    describe '::on_date' do
      it 'returns the potato share prices on the specified date' do
        expect(PotatoSharePrice.on_date(date)).to eq([potato_share_price1, potato_share_price2])
      end

      it 'does not return the potato share prices on other dates' do
        expect(PotatoSharePrice.on_date(date)).not_to include(potato_share_price3)
      end
    end

    describe '::ordered_by_time' do
      it 'returns the potato share prices ordered by time ascending' do
        expect(PotatoSharePrice.ordered_by_time).to eq([potato_share_price3, potato_share_price2, potato_share_price1])
      end
    end
  end
end
