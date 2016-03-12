# Luhn algorithm in Elixir

[![hex.pm version](https://img.shields.io/hexpm/v/luhn.svg)](https://hex.pm/packages/luhn)
[![hex.pm daily downloads](https://img.shields.io/hexpm/dd/luhn.svg)](https://hex.pm/packages/luhn)
[![hex.pm weekly downloads](https://img.shields.io/hexpm/dw/luhn.svg)](https://hex.pm/packages/luhn) 
[![hex.pm downloads](https://img.shields.io/hexpm/dt/luhn.svg)](https://hex.pm/packages/luhn)
[![Build Status](https://travis-ci.org/ma2gedev/luhn_ex.svg?branch=master)](https://travis-ci.org/ma2gedev/luhn_ex)

Validate Luhn number.

## Installation

```
# mix.exs
defp deps do
  [
    {:luhn, "~> 0.3.0"}
  ]
end

# and fetch
$ mix deps.get
```

## How to use

```
# validate number
Luhn.valid? "378282246310005"
# => true

# Integer type number
Luhn.valid? 378282246310005
# => true
```

## Benchmarking

```
$ MIX_ENV=bench mix deps.get
$ MIX_ENV=bench mix compile
$ mix bench
```

## Author

Takayuki Matsubara (@ma2ge on twitter)

## LICENSE

MIT
