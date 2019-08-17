defmodule Luhn do
  @moduledoc """
  Functions for validating Credit Card numbers using Luhn checksums.

  Credit card numbers may be of arbitrary length and in arbitrary base.
  """

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
  @spec valid?(number :: integer | String.t, base :: 2..36) :: boolean
  def valid?(number, base \\ 10) when base >= 2 do
    checksum(number, base)
    |> Kernel.==(0)
  end

  def checksum(number, base \\ 10)

  @spec checksum(binary, 2..36) :: integer
  def checksum(number, base) when is_binary(number) do
    number
    |> String.to_integer(base)
    |> checksum(base)
  end

  @spec checksum(integer, 2..36) :: integer
  def checksum(number, base) do
    number
    |> Integer.digits(base)
    |> Enum.reverse
    |> double(base, 0)
    |> rem(base)
  end

  @spec double([integer, ...], integer, integer) :: integer
  def double([], _, acc), do: acc
  def double([x], _, acc), do: x + acc
  def double([x,y|tail], base, acc), do: double(tail, base, acc + x + sum(y * 2, base))

  @spec sum(integer, integer) :: integer
  defp sum(number, base) when number >= base, do: number - base + 1
  defp sum(number, _), do: number
end
