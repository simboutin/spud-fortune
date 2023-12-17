class CreatePotatoSharePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :potato_share_prices do |t|
      t.datetime :time
      t.integer :price_in_cents

      t.timestamps
    end
  end
end
