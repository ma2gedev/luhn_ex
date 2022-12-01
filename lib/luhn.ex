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

  @doc false
  @spec double([integer, ...], integer, integer) :: integer
  def double([], _, acc), do: acc
  def double([x], _, acc), do: x + acc
  def double([x,y|tail], base, acc), do: double(tail, base, acc + x + sum(y * 2, base))

  @spec sum(integer, integer) :: integer
  defp sum(number, base) when number >= base, do: number - base + 1
  defp sum(number, _), do: number

end
