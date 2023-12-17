module Api
  module V1
    class PotatoSharePricesController < ApplicationController
      before_action :validate_date

      def index
        date = Date.parse(params[:date])
        @potato_share_prices = PotatoSharePrice.on_date(date)
                                               .ordered_by_time

        @serialized_potato_share_prices = @potato_share_prices.map { |psp| PotatoSharePriceSerializer.new(psp).as_json }
        render json: @serialized_potato_share_prices, status: :ok
      end

      private

      def validate_date
        @date = Date.parse(params[:date])
      rescue ArgumentError, TypeError
        render json: { error: 'Invalid date or parameter missing' }, status: :bad_request
      end
    end
  end
end
