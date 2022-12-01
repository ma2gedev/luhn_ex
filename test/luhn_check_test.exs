defmodule Luhn.CheckTest do
  use ExUnit.Case
  use PropCheck, default_opts: [{:numtests, 1_000}]

  import Luhn.Generators

  describe "Luhn.valid?1" do
    property "for known good numbers" do
      forall n <- good_number() do
        assert Luhn.valid?(n)
      end
    end

    property "for any positive integer" do
      forall n <- pos_integer() do
        case Luhn.valid?(n) do
          true -> collect(true, :valid)
          false -> collect(true, :invalid)
        end
      end
    end

    property "for any numeric string" do
      forall n <- numeric_10() do
        case Luhn.valid?(n) do
          true -> collect(true, :valid)
          false -> collect(true, :invalid)
        end
      end
    end

    property "detects single digit errors" do
      forall {n, n_corrupt} <- single_digit_error(good_number()) do
        assert n != n_corrupt
        assert Luhn.valid?(n)
        assert !Luhn.valid?(n_corrupt), String.myers_difference(n, n_corrupt)
      end
    end

    # property "Luhn.valid?/1 for any UTF-8 string" do
    #   forall b <- non_empty(utf8()) do
    #     case Luhn.valid?(b) do
    #       true -> collect(true, :valid)
    #       false -> collect(true, :invalid)
    #     end
    #   end
    # end
  end

  describe "Generators" do
    property "single_digit_error/1 differ" do
      forall {a, b} <- single_digit_error(numeric_10()) do
        assert a != b
      end
    end

    property "single_digit_error/1 have same length" do
      forall {a, b} <- single_digit_error(numeric_10()) do
        assert String.length(a) == String.length(b)
      end
    end
  end
end
