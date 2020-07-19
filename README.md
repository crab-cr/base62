# base62

Base62 is used to display large integers or UUIDs as shorter strings of only 0-9,a-z,A-Z.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     base62:
       github: iomcr/base62
   ```

2. Run `shards install`

## Usage

```crystal
require "base62"

# normally you might use auto incrementing IDs for objects:
# /books/1
# /books/2
# /books/3

# but large amounts of DB objects can get unruly
# /books/1000
# /books/100000
# /books/10000000

# but what if those large numbers could be represented in less characters?
puts "/books/#{1000_i64.to_base62}"
# "/books/g8"
puts "/books/#{100000_i64.to_base62}"
# "/books/q0U"
puts "/books/#{10000000_i64.to_base62}"
# "/books/FXsk"
puts "/books/#{1000000000_i64.to_base62}"
# "/books/15FTGg"

puts Iom::Base62.decode("15FTGg")
# 1000000000_u128

puts uuid = UUID.random
# UUID(77110d51-6b7f-4599-a194-990128d5d0a0)
# therefor, your URL would be something like:
# /books/77110d51-6b7f-4599-a194-990128d5d0a0

puts uuid.to_base62
# 4TscXMPnRR5wsTVsiHKUWb
# now your URL can be
# /books/4TscXMPnRR5wsTVsiHKUWb

puts UUID.from_base62 "4TscXMPnRR5wsTVsiHKUWb"
# UUID(77110d51-6b7f-4599-a194-990128d5d0a0)

Now you can have shorter URLs and still use non-strings for

bc = Iom::Base62::Converter.new("01234567")
puts bc.base
# 8

# decimal 10 is octal 12
puts bc.encode(10_i64)
# "12"
puts bc.decode("12")
# 10_u128
```

## Development

This library will likely assume you are using Int64 and UInt128, and optionally UUID. PRs to help generalize this are welcome. No additional dependancies should be considered.

## Contributing

1. Fork it (<https://github.com/iomcr/base62/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [IOM](https://github.com/iomcr) - creator and maintainer
