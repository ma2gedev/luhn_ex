defmodule Luhn do
  require Integer

  @spec valid?(integer, 2..36) :: boolean
  def valid?(number, base \\ 10) do
    case checksum(number, base) do
      {:ok, checksum} -> checksum == 0
      :error -> false
    end
  end

  @spec checksum(integer, 2..36) :: integer
  def checksum(number, base) when is_integer(number) do
    number
    |> Integer.to_string(base)
    |> checksum(base)
  end

  @spec checksum(String.t, 2..36) :: integer
  def checksum(number, base) when is_binary(number) do
    case number |> parse(base) do
      {:ok, parsed} -> {:ok, parsed |> double(base, 0) |> rem(base)}
      :error -> :error
    end
  end

  def double([], _, acc), do: acc
  def double([x], _, acc), do: x + acc
  def double([x, y | tail], base, acc), do: double(tail, base, acc + x + sum(y * 2, base))

  defp sum(number, base) when number >= base, do: number - base + 1
  defp sum(number, _), do: number

  defp parse(value, base), do: value |> String.split("", trim: true) |> do_parse(base, [])

  defp do_parse([char | tail], base, acc) do
    case char |> Integer.parse(base) do
      {parsed, ""} -> do_parse tail, base, [parsed | acc]
      _ -> :error
    end
  end
  defp do_parse([], _base, acc), do: {:ok, acc}
end
