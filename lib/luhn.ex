defmodule Luhn do
  require Integer

  @spec valid?(integer, 2..36, 2..36 | nil) :: boolean
  def valid?(number, base \\ 10, mod \\ nil) do
    checksum(number, base, mod)
    |> Kernel.== 0
  end

  def checksum(number, base \\ 10, mod \\ nil)

  @spec checksum(integer, 2..36, 2..36 | nil) :: integer
  def checksum(number, base, mod) when is_integer(number) do
    number
    |> Integer.to_string(base)
    |> checksum(base, mod)
  end

  @spec checksum(String.t, 2..36, 2..36 | nil) :: integer
  def checksum(number, base, mod) do
    mod = mod || base

    number
    |> String.split("", trim: true)
    |> Enum.reduce([], fn(n, acc) -> [String.to_integer(n, base)|acc] end)
    |> double(mod)
    |> rem mod
  end

  defp double([], _), do: 0
  defp double([x], _), do: x
  defp double([x,y|tail], mod), do: x + sum(y * 2, mod) + double(tail, mod)

  defp sum(number, mod) when number >= mod, do: sum(number - mod + 1, mod)
  defp sum(number, _), do: number
end
