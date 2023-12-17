# SPUD FORTUNE

This is an API application that tracks the share prices of potatoes and calculates the maximum potential gain for a given date.

## Features

- Track potato share prices for a given date
- Calculate the maximum potential gain for a given date

## Data

Please note that the data used in this application is fake and only includes data from 2023-12-11 to 2023-12-17.

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
