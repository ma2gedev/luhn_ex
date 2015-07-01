defmodule Luhn do
  require Integer

  def valid?(number) do
    checksum(number)
    |> Kernel.== 0
  end

  def checksum(number) when is_integer(number) do
    Integer.to_string(number) |> checksum
  end

  def checksum(number) do
    String.split(number, "", trim: true)
    |> Enum.reduce([], fn(n, acc) -> [String.to_integer(n)|acc] end)
    |> double
    |> rem 10
  end

  defp double([]), do: 0
  defp double([x]), do: x
  defp double([x,y|tail]), do: x + sum(y * 2) + double(tail)

  defp sum(number) when number >= 10, do: number - 9
  defp sum(number), do: number
end
