# Luhn algorithm in Elixir

[![hex.pm version](https://img.shields.io/hexpm/v/luhn.svg)](https://hex.pm/packages/luhn) [![hex.pm downloads](https://img.shields.io/hexpm/dt/luhn.svg)](https://hex.pm/packages/luhn) [![Build Status](https://travis-ci.org/ma2gedev/luhn_ex.svg?branch=master)](https://travis-ci.org/ma2gedev/luhn_ex)

Validate Luhn number.

## Installation

```
# mix.exs
defp deps do
  [
    {:luhn, "~> 1.0.0"}
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

## LICENSE

MIT
