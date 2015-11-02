defmodule Luhn do
  require Integer

  @spec valid?(integer, 2..36) :: boolean
  def valid?(number, base \\ 10) do
    checksum(number, base)
    |> Kernel.== 0
  end

  def checksum(number, base \\ 10)

  @spec checksum(integer, 2..36) :: integer
  def checksum(number, base) when is_integer(number) do
    number
    |> Integer.to_string(base)
    |> checksum(base)
  end

  @spec checksum(String.t, 2..36) :: integer
  def checksum(number, base) do
    number
    |> String.split("", trim: true)
    |> Enum.reduce([], fn(n, acc) -> [String.to_integer(n, base)|acc] end)
    |> double(base)
    |> rem base
  end

  defp double([], _), do: 0
  defp double([x], _), do: x
  defp double([x,y|tail], base), do: x + sum(y * 2, base) + double(tail, base)

  defp sum(number, base) when number >= base, do: number - base + 1
  defp sum(number, _), do: number
end
