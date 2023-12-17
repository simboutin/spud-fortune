require 'rails_helper'

RSpec.describe PotatoSharePrice, type: :model do
  let!(:date)                { Date.new(2023, 12, 16) }
  let!(:potato_share_price1) { PotatoSharePrice.create!(time: DateTime.new(2023, 12, 16, 15, 0, 0), price_in_cents: 400_00) }
  let!(:potato_share_price2) { PotatoSharePrice.create!(time: DateTime.new(2023, 12, 16, 12, 0, 0), price_in_cents: 200_00) }
  let!(:potato_share_price3) { PotatoSharePrice.create!(time: DateTime.new(2023, 12, 15, 10, 0, 0), price_in_cents: 300_00) }

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

  describe 'class methods' do
    let!(:potato_share_price4) { PotatoSharePrice.create!(time: DateTime.new(2023, 12, 16, 16, 0, 0), price_in_cents: 100_00) }

    describe '::max_potential_gain_on_date' do
      before do
        stub_const('PotatoSharePrice::DAILY_TRADE_LIMIT', 100)
      end

      it 'returns the maximum potential gain in euros for the given date' do
        max_potential_gain = PotatoSharePrice.max_potential_gain_on_date(date)
        expected_gain      = ConversionService.cents_to_euros(100 * 200_00) # 400_00 - 200_00 = 200_00
        expect(max_potential_gain).to eq(expected_gain)
      end

      it 'returns nil when no potato share prices can be found on the specified date' do
        max_potential_gain = PotatoSharePrice.max_potential_gain_on_date(Date.new(2023, 12, 15))
        expect(max_potential_gain).to be_nil
      end

      it 'returns nil when max_diff_smaller_element_first returns 0' do
        allow(PotatoSharePrice).to receive(:max_diff_with_smaller_element_first).and_return(0)
        max_potential_gain = PotatoSharePrice.max_potential_gain_on_date(Date.new(2023, 12, 16))
        expect(max_potential_gain).to be_nil
      end
    end

    describe '::max_diff_with_smaller_element_first' do
      it 'returns the maximum difference between two elements where the smaller element comes first' do
        expect(PotatoSharePrice.send(:max_diff_with_smaller_element_first, [4, 2, 3, 5, 6, 1])).to eq(4)
        expect(PotatoSharePrice.send(:max_diff_with_smaller_element_first, [1, 2, 3, 4, 5, 6])).to eq(5)
      end

      it 'returns 0 if the array is in descending order' do
        expect(PotatoSharePrice.send(:max_diff_with_smaller_element_first, [6, 5, 4, 3, 2, 1])).to eq(0)
      end
    end
  end
end
