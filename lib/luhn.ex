defmodule Luhn do
  @moduledoc """
  Functions for validating Credit Card numbers using Luhn checksums.

  Credit card numbers may be of arbitrary length and in arbitrary base.
  """

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

      # Works with Hexadecimal as well
      iex(3)> Luhn.valid?(0x1580BB2EA8875, 16)
      true
  """
  @spec valid?(number :: integer | String.t, base :: integer) :: boolean
  def valid?(number, base \\ 10) when valid_base(base) do
    checksum(number, base)
    |> Kernel.==(0)
  end

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

  defp distance_from_base(checksum, _base) when checksum == 0, do: 0
  defp distance_from_base(checksum,  base), do: base - checksum

  @doc """
  Calculates the check digit for a number prefix

  # Example
      # Accepts an integer
      iex> Luhn.check_digit(37828224631000)
      5

      # Accepts an integer
      iex> Luhn.check_digit(37828224631007)
      0
  """
  @spec check_digit(integer, integer) :: integer
  def check_digit(number, base \\ 10) when valid_base(base) do
    number
    |> Kernel.*(base)
    |> checksum(base)
    |> distance_from_base(base)
  end

  @doc """
  Appends the check digit to a number prefix

  # Example
      # Accepts an integer
      iex> Luhn.append_check_digit(37828224631000)
      378282246310005
  """
  @spec append_check_digit(integer, integer) :: integer
  def append_check_digit(number, base \\ 10) when valid_base(base) do
    number
    |> Integer.digits()
    |> Kernel.++([check_digit(number, base)])
    |> Integer.undigits()
  end

  @spec double([integer, ...], integer, integer) :: integer
  def double([], _, acc), do: acc
  def double([x], _, acc), do: x + acc
  def double([x,y|tail], base, acc), do: double(tail, base, acc + x + sum(y * 2, base))

  @spec sum(integer, integer) :: integer
  defp sum(number, base) when number >= base, do: number - base + 1
  defp sum(number, _), do: number

end
