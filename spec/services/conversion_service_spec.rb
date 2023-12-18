require 'rails_helper'

RSpec.describe ConversionService, type: :service do
  describe '::cents_to_euros' do
    it 'converts cents to euros' do
      expect(ConversionService.cents_to_euros(1234)).to eq(12.34)
    end
  end
end
