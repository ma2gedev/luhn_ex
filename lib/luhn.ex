defmodule Luhn do
  @moduledoc """
  Functions for validating Credit Card numbers using Luhn checksums.

  Credit card numbers may be of arbitrary length and in arbitrary base.
  """

  alias __MODULE__.Algorithm

  @type check_digit :: non_neg_integer
  @type input :: binary | integer

  defguardp valid_base(base) when base >= 2

  @doc """
  Evaluates a given credit card number for its validity, with an optionally provided base.

  # Examples
      # Accepts a string
      iex(1)> Luhn.valid?("378282246310005")
      true

      # Or an integer
      iex(2)> Luhn.valid?(378282246310005)
      true

  """
  @spec valid?(number :: integer | String.t, base :: integer) :: boolean
  def valid?(number, base \\ 10) when valid_base(base) do
    checksum(number, base)
    |> Kernel.==(0)
  end

  @doc """
  Calculate the checksum of a number.

  This is known as the "mod 10" algorithm and the result will be zero if the
  check digit suffix is valid for the number.

      iex> Luhn.checksum("79927398713")
      0
  """
  def checksum(number, base \\ 10)

  @spec checksum(binary, integer) :: integer
  def checksum(number, base) when is_binary(number) and valid_base(base) do
    number
    |> String.to_integer(base)
    |> checksum(base)
  end

  @spec checksum(integer, integer) :: integer
  def checksum(number, base) when valid_base(base) do
    number
    |> Integer.digits(base)
    |> Enum.reverse
    |> double(base, 0)
    |> rem(base)
  end

  @doc """
  Compute the check digit of a number.

      iex> Luhn.compute_check_digit("7992739871")
      3

      iex> Luhn.compute_check_digit(7992739871)
      3
  """
  @spec compute_check_digit(input) :: check_digit
  def compute_check_digit(n), do: Algorithm.compute_check_digit(n)

  @doc """
  Compute and append the check digit for a given number.

      iex> Luhn.append_check_digit("7992739871")
      "79927398713"
  """
  @spec append_check_digit(binary) :: binary
  def append_check_digit(n) do
    check_digit = Algorithm.compute_check_digit(n)
    n <> to_string(check_digit)
  end

  @doc false
  @spec double([integer, ...], integer, integer) :: integer
  def double([], _, acc), do: acc
  def double([x], _, acc), do: x + acc
  def double([x,y|tail], base, acc), do: double(tail, base, acc + x + sum(y * 2, base))

  @spec sum(integer, integer) :: integer
  defp sum(number, base) when number >= base, do: number - base + 1
  defp sum(number, _), do: number

  defmodule Algorithm do
    @moduledoc false

    def compute_check_digit(n) do
      sum = sum_digits(n)
      rem(10 - (rem(sum, 10)), 10)
    end

    def sum_digits(n) when is_binary(n) do
      rev_digits = n
      |> String.graphemes()
      |> List.foldl([], fn x, acc -> [String.to_integer(x) | acc] end)

      sum_digits(rev_digits, 2)
    end

    def sum_digits(n) when is_integer(n) do
      rev_digits = n |> Integer.digits() |> Enum.reverse()
      sum_digits(rev_digits, 2)
    end

    def sum_digits([], _multiplier), do: 0

    def sum_digits([x | xs], multiplier) do
      case multiplier do
        1 ->
          x + sum_digits(xs, 2)
        2 ->
          sum = (x * multiplier) |> Integer.digits() |> Enum.sum()
          sum + sum_digits(xs, 1)
      end
    end
  end
end
