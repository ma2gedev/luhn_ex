defmodule Luhn do
  require Integer

  def valid?(number) do
    checksum(number)
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
    |> double
    |> rem 10
  end

  defp double([]), do: 0
  defp double([x]), do: x
  defp double([x,y|tail]), do: x + sum(y * 2) + double(tail)

  defp sum(number) when number >= 10, do: sum(number - 9)
  defp sum(number), do: number
end
