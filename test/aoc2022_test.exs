defmodule Aoc2022Test do
  use ExUnit.Case

  test "day1 is able to compute the most calories carried by an elf" do
    calories = "1000
2000
3000

4000

5000
6000

7000
8000
9000

10000"

    tmp_file_path = "./test/tmp_file.txt"
    file = File.open!(tmp_file_path, [:write])
    on_exit(fn -> File.rm!(tmp_file_path) end)

    File.write!(tmp_file_path, calories)

    result = Aoc2022.Day1.run(tmp_file_path)
    assert result == 24_000
  end
end
