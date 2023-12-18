# SPUD FORTUNE

Spud Fortune is an API application that tracks the share prices of potatoes and calculates the maximum potential gain for a given date.

## Features

- Track potato share prices for a given date
- Calculate the maximum potential gain for a given date with a daily limit of 100 shares

## Data

Please be aware that the data within this application is simulated and strictly covers the period from December 11, 2023, to December 17, 2023.
Prices are in € / ton.

## Usage: API Endpoints

- `GET /potato_share_prices?date=<date>`: returns all potato share prices at the given date.
- `GET /potato_share_prices/max_potential_gain?date=<date>`: returns the maximum potential gain for the given date.

The date should be in the format: `YYYY-MM-DD`.

## Installation

1. Clone the repository: `git clone git@github.com:simboutin/spud-fortune.git`
2. Navigate to the project directory: `cd potato-fortune`
3. Install the dependencies: `bundle install`
4. Setup the database: `rails db:setup`
5. Start the server: `rails server`

## Testing

To run the tests, use the command: `rspec`
