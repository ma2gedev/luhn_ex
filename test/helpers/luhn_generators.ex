defmodule Luhn.Generators do
  use PropCheck

  @min_base 2
  @max_base 36

  @doc "Good number from the Wikipedia article"
  def wikipedia_number, do: exactly("79927398713")

  @doc "Known good number with check digit"
  def good_number, do: elements(read_numbers())

  @doc "Char digit for given base"
  def digits(base) when base <= 10 do
    digits = for i <- 0..(base - 1), do: ?0 + i
    elements(digits)
  end

  def digits(base) when base <= @max_base do
    digits = for i <- 0..9, do: ?0 + i
    letters = for i <- 10..(base-1), do: ?A + i - 10
    elements(digits ++ letters)
  end

  @doc "Decimal digit (base 10)"
  def decimal_digit, do: digits(10)

  @doc "Octal digit (base 8)"
  def octal_digit, do: digits(8)

  @doc "Non-zero digit"
  def nz_digit(gen), do: such_that(d <- gen, when: d != ?0)

  @doc "Numeric string of given chars"
  def numeric(digit_gen) do
    let n <- choose(2, 19) do
      let {d, ds} <- {nz_digit(digit_gen), vector(n-1, digit_gen)} do
        to_string([d|ds])
      end
    end
  end

  @doc "Numeric string (base 10)"
  def numeric_10, do: numeric(decimal_digit())

  @doc "Supported base"
  def base, do: choose(@min_base, @max_base)

  @doc "Base and numeric in that base"
  def numeric_in_base do
    let base <- base() do
      let n <- numeric(digits(base)) do
        {n, base}
      end
    end
  end

  @doc "Generate a pair of a valid number and a copy with a single digit error"
  def single_digit_error(gen) do
    let n <- gen do
      max = String.length(n)

      let i <- choose(0, max - 1) do
        {xs, [y | ys]} = Enum.split(to_charlist(n), i)

        let d <- such_that(d <- decimal_digit(), when: d != y) do
          {n, to_string([xs | [d | ys]])}
        end
      end
    end
  end

  @doc "Predicate if string starts with zeros"
  def zero_padded?(s), do: String.match?(s, ~r/^0+/)

  @doc "Generate a pair of numbers that do not start with zeros"
  def single_digit_error_nz(gen) do
    let result <-
          such_that(
            {a, b} <- single_digit_error(gen),
            when: !(zero_padded?(a) or zero_padded?(b))
          ) do
      result
    end
  end

  @doc "AMEX predicate"
  def american_express?(s), do: Regex.match?(~r/^(37|34)\d{13}$/, s)

  @doc "Good AMEX number"
  def american_express_number, do: elements(filter_numbers(&american_express?/1))

  @doc "Mastercard predicate"
  def mastercard?(s), do: Regex.match?(~r/^[25]\d{15}$/, s)

  @doc "Good Mastercard number"
  def mastercard_number, do: elements(filter_numbers(&mastercard?/1))

  @doc "VISA predicate"
  def visa?(s), do: Regex.match?(~r/^4\d{15}$/, s)

  @doc "Good VISA number"
  def visa_number, do: elements(filter_numbers(&visa?/1))

  defp filter_numbers(filter), do: Enum.filter(read_numbers(), filter)

  @doc "Read numbers with good check digit"
  def read_numbers,
    do:
      "test/numbers"
      |> File.read!()
      |> String.split()
end
