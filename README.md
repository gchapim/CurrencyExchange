# Currency Exchanger

A simple rails app that gets Australian Dollars, Brazilian Reais and US
Dollars quotations for the last working days from Europe Central Bank API and put them in a nice and simple
chart based on Brazilian Real rates.

## Installation

You can clone and run it as a rails app.

## Usage

The class responsible for getting the quotes is Exchanger.

You can get all rates for the last working days calling as __get_quotes__

```ruby
exchanger = Exchanger.new
exchanger.get_quotes # will return a hash of quotes for each currency
```

...or you can call __get_quote__ for a specific currency:

```ruby
exchanger.get_quote('USD')
```

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Check 'LICENSE' file for more details.
