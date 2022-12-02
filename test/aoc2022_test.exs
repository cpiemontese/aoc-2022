defmodule Aoc2022Test do
  use ExUnit.Case

  @calories "1000
2000
3000

4000

5000
6000

7000
8000
9000

10000"

  describe "day1" do
    test "first part is able to compute the most calories carried by an elf" do
      result = @calories |> mk_tmp_file() |> Aoc2022.Day1.first()
      assert result == 24_000
    end

    test "second part is able to compute the most calories carried by the top three elves" do
      result = @calories |> mk_tmp_file() |> Aoc2022.Day1.second()
      assert result == 45_000
    end
  end

  def mk_tmp_file(input) do
    tmp_file_path = "./test/tmp_file#{Enum.random(0..10000)}.txt"

    File.write!(tmp_file_path, input)
    on_exit(fn -> File.rm!(tmp_file_path) end)

    tmp_file_path
  end
end
