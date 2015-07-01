defmodule BasicBench do
  use Benchfella

  @valid_number "378282246310005"

  bench "luhn" do
    Luhn.valid? @valid_number
  end
end
