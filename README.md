# Luhn Algorithm

Validate a variety of numbers such as credit cards and national identification numbers with the [Luhn alogrithm][luhn] published in 1960 by [Hans Peter Luhn][hpl].

[![hex.pm version](https://img.shields.io/hexpm/v/luhn.svg)](https://hex.pm/packages/luhn)
[![hex.pm daily downloads](https://img.shields.io/hexpm/dd/luhn.svg)](https://hex.pm/packages/luhn)
[![hex.pm weekly downloads](https://img.shields.io/hexpm/dw/luhn.svg)](https://hex.pm/packages/luhn) 
[![hex.pm downloads](https://img.shields.io/hexpm/dt/luhn.svg)](https://hex.pm/packages/luhn)
[![Build Status](https://github.com/ma2gedev/luhn_ex/workflows/Elixir%20CI/badge.svg?branch=master)](https://github.com/ma2gedev/luhn_ex/actions?query=workflow%3A%22Elixir+CI%22)

The original [v0.3.3][fork] by [Takayuki Matsubara][ma2gedev] only validated numbers and is available at `{:luhn, "~> 0.3.3"}`.

This fork is available at `{:luhn60, "~> 1.3"}` and has these enhancements:

- &#9745; CI for latest Elixir
- &#9745; Property tests
- &#9745; Compute check digit
- &#9744; Append check digit
- &#9744; Hexadecimal support

[![hex.pm version](https://img.shields.io/hexpm/v/luhn60.svg)](https://hex.pm/packages/luhn60)
[![Elixir CI](https://github.com/devstopfix/luhn_ex/actions/workflows/elixir.yml/badge.svg)](https://github.com/devstopfix/luhn_ex/actions/workflows/elixir.yml)

## Installation

This fork:

    {:luhn60, "~> 1.3"}

Original:

    {:luhn, "~> 0.3"}

## How to use

```elixir
# validate number
Luhn.valid? "378282246310005"
# => true

# Integer type number
Luhn.valid? 378282246310005
# => true

# Compute check digit
Luhn.compute_check_digit("37828224631000")
# => 5
```

## Benchmarking

```bash
$ MIX_ENV=bench mix deps.get
$ MIX_ENV=bench mix compile
$ mix bench
```

## Author

Takayuki Matsubara (@ma2ge on twitter)

## LICENSE

MIT

[fork]: https://github.com/ma2gedev/luhn_ex/tree/0.3.3
[luhn]: https://en.wikipedia.org/wiki/Luhn_algorithm
[hpl]: https://en.wikipedia.org/wiki/Hans_Peter_Luhn
[ma2gedev]: https://github.com/ma2gedev