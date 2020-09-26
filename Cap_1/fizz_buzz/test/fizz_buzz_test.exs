defmodule FizzBuzzTest do
  use ExUnit.Case

  describe "build/1" do
    # SUCCESS CASE
    test "when a valid file is provided, returns FizzBuzz list" do
      expected_response =
        {:ok,
         [
           1,
           2,
           :fizz,
           4,
           :buzz,
           :fizz,
           7,
           8,
           :fizz,
           :buzz,
           11,
           :fizz,
           13,
           14,
           :fizzbuzz,
           16,
           17,
           :fizz,
           19,
           :buzz
         ]}

      assert FizzBuzz.build("numbers.txt") == expected_response
    end

    # FAILED CASE
    test "when a invalid file is provided, returns error" do
      expected_response = {:error, "Error on file: enoent"}
      assert FizzBuzz.build("invalid.txt") == expected_response
    end
  end
end
