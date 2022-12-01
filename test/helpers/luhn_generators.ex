defmodule Luhn.Generators do
  use PropCheck

  @doc "Good number from the Wikipedia article"
  def wikipedia_number, do: exactly("79927398713")

  @doc "Known good number with check digit"
  def good_number, do: elements(read_numbers())

  @doc "Base 10 digit"
  def digit_10, do: elements(~c[0123456789])

  @doc "Numeric string (base 10)"
  def numeric_10 do
    let n <- choose(8, 19) do
      let digits <- vector(n, digit_10()) do
        to_string(digits)
      end
    end
  end

  @doc "Generate a pair of a valid number and a copy with a single digit error"
  def single_digit_error(gen) do
    let n <- gen do
      max = String.length(n)

      let i <- choose(0, max - 1) do
        {xs, [y | ys]} = Enum.split(to_charlist(n), i)

        let d <- such_that(d <- digit_10(), when: d != y) do
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
