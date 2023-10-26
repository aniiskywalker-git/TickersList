
# iOS App using Clean Architecture and MVVM 👾🤖🧅

iOS Project implemented with Clean Layered Architecture and MVVM. This app uses Swift Package Manager.

## Features 📌
* Added information in regards [Market Stack API](https://api.marketstack.com/v1/)
* Added two simple views in order to show information retrieved from Market Stack API
* View number one is a list of Tickers where display (1):
  - Ticker symbol
  - Ticker name
  - End of day (EOD) closed deal (not in the API⚠️)
  - Stock name
  - Stock acronym
* View number two is a detail of Ticker selected where display (2, 3):
  - Ticker symbol
  - Ticker name
  - End of day (EOD) closed deal
  - Stock name
  - Stock name
  - Stock acronym
  - End of day (EOD) information
      - Open
      - Close
      - High
      - Low
      - Volume
      - Date
  - Button where can choose between metrics (EOD information based)
  - Chart that displays the first EOD values. Using [Charts Framework](https://github.com/danielgindi/Charts) to display.
 
| Ticker List | Ticker Detail | Ticker Detail |
| ----------- | ----------- | ----------- |
| <img src="https://github.com/aniiskywalker-git/TickersList/assets/68025622/64b07c79-e9f1-4e13-a010-15db6902fe19" width="300"/> | <img src="https://github.com/aniiskywalker-git/TickersList/assets/68025622/3035ee0b-db31-46ba-9c5d-e943f3373e22" width="300"/> | <img src="https://github.com/aniiskywalker-git/TickersList/assets/68025622/1c85b6ad-b18b-4435-a938-7375fd9c5c59" width="300"/> |
| Img 1       | Img 2       | Img 3       |

JSON RESPONSE example from `/tickers?`
```
"pagination": {
        "limit": 100,
        "offset": 0,
        "count": 100,
        "total": 287197
    },
"data": [ {
    "name": "Microsoft Corporation",
    "symbol": "MSFT",
    "has_intraday": false,
    "has_eod": true,
    "country": null,
    "stock_exchange": {
          "name": "NASDAQ Stock Exchange",
          "acronym": "NASDAQ",
          "mic": "XNAS",
          "country": "USA",
          "country_code": "US",
          "city": "New York",
          "website": "www.nasdaq.com"
        }
    }
]
```
JSON RESPONSE example from `/tickers/[symbol]/eod?`
```
{
    "pagination": {
        "limit": 100,
        "offset": 0,
        "count": 100,
        "total": 251
    },
    "data": {
        "name": "Amazon.com Inc",
        "symbol": "AMZN",
        "has_intraday": false,
        "has_eod": true,
        "country": null,
        "eod": [
            {
                "open": 126.04,
                "high": 126.3,
                "low": 120.79,
                "close": 121.39,
                "volume": 71616765.0,
                "adj_high": 126.34,
                "adj_low": 120.79,
                "adj_close": 121.39,
                "adj_open": 126.04,
                "adj_volume": 74577544.0,
                "split_factor": 1.0,
                "dividend": 0.0,
                "symbol": "AMZN",
                "exchange": "XNAS",
                "date": "2023-10-25T00:00:00+0000"
            },
            {
                "open": 127.74,
                "high": 128.8,
                "low": 126.34,
                "close": 128.56,
                "volume": 45681900.0,
                "adj_high": 128.8,
                "adj_low": 126.34,
                "adj_close": 128.56,
                "adj_open": 127.74,
                "adj_volume": 46477355.0,
                "split_factor": 1.0,
                "dividend": 0.0,
                "symbol": "AMZN",
                "exchange": "XNAS",
                "date": "2023-10-24T00:00:00+0000"
            }
        ]
    }
}
```

## How to run 🏃‍♀️
* Open `.xcproject` and click on ▶️ or cmd + shift + R
  - In some cases, you'd need to add a Team (Project > Signing & Capabilities), and the app won't complain. 
* To run Tests cmd + U
  
## Requirements 🛠️
* Xcode Version 11.2.1+  Swift 5.0+

