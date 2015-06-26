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
    |> Enum.with_index
    |> Enum.reduce(0, &double/2)
    |> rem 10
  end

  defp double({number, index}, acc) when Integer.is_odd(index), do: acc + sum(number * 2)
  defp double({number, index}, acc) when Integer.is_even(index), do: acc + number

  defp sum(number) when number >= 10, do: number - 9
  defp sum(number), do: number
end
