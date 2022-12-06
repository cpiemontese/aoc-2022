defmodule Aoc2022Test do
  use ExUnit.Case

  describe "day1" do
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

    test "first part is able to compute the most calories carried by an elf" do
      result = @calories |> mk_tmp_file() |> Aoc2022.Day1.first()
      assert result == 24_000
    end

    test "second part is able to compute the most calories carried by the top three elves" do
      result = @calories |> mk_tmp_file() |> Aoc2022.Day1.second()
      assert result == 45_000
    end
  end

  describe "day2" do
    @strategy_guide "A Y
B X
C Z"

    test "first part is able to compute total score of strategy guide" do
      result = @strategy_guide |> mk_tmp_file() |> Aoc2022.Day2.first()
      assert result == 15
    end

    test "second part is able to compute correct total score of strategy guide" do
      result = @strategy_guide |> mk_tmp_file() |> Aoc2022.Day2.second()
      assert result == 12
    end
  end

  describe "day3" do
    @items "vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw"

    test "first part is able to compute total priority of items" do
      result = @items |> mk_tmp_file() |> Aoc2022.Day3.first()
      assert result == 157
    end

    test "second part is able to compute correct total priority of groups" do
      result = @items |> mk_tmp_file() |> Aoc2022.Day3.second()
      assert result == 70
    end
  end

  describe "day4" do
    @items "2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8"

    test "first part is able to compute containing assignments" do
      result = @items |> mk_tmp_file() |> Aoc2022.Day4.first()
      assert result == 2
    end

    test "second part is able to compute overlapping assignments" do
      result = @items |> mk_tmp_file() |> Aoc2022.Day4.second()
      assert result == 4
    end
  end

  describe "day5" do
    @moves "move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2"

    @input_state %{
      1 => ["N", "Z"],
      2 => ["D", "C", "M"],
      3 => ["P"]
    }

    test "first part is able to compute the top crates of example" do
      result = @moves |> mk_tmp_file() |> Aoc2022.Day5.first(@input_state)
      assert result == "CMZ"
    end

    test "first part is able to compute top crates of input" do
      result =
        Aoc2022.Day5.first("inputs/day5.txt", %{
          1 => ["F", "T", "N", "Z", "M", "G", "H", "J"],
          2 => ["J", "W", "V"],
          3 => ["H", "T", "B", "J", "L", "V", "G"],
          4 => ["L", "V", "D", "C", "N", "J", "P", "B"],
          5 => ["G", "R", "P", "M", "S", "W", "F"],
          6 => ["M", "V", "N", "B", "F", "C", "H", "G"],
          7 => ["R", "M", "G", "H", "D"],
          8 => ["D", "Z", "V", "M", "N", "H"],
          9 => ["H", "F", "N", "G"]
        })

      assert result == "TDCHVHJTG"
    end

    test "second part is able to compute the top crates of example" do
      result = @moves |> mk_tmp_file() |> Aoc2022.Day5.second(@input_state)
      assert result == "MCD"
    end

    test "second part is able to compute top crates of input" do
      result =
        Aoc2022.Day5.second("inputs/day5.txt", %{
          1 => ["F", "T", "N", "Z", "M", "G", "H", "J"],
          2 => ["J", "W", "V"],
          3 => ["H", "T", "B", "J", "L", "V", "G"],
          4 => ["L", "V", "D", "C", "N", "J", "P", "B"],
          5 => ["G", "R", "P", "M", "S", "W", "F"],
          6 => ["M", "V", "N", "B", "F", "C", "H", "G"],
          7 => ["R", "M", "G", "H", "D"],
          8 => ["D", "Z", "V", "M", "N", "H"],
          9 => ["H", "F", "N", "G"]
        })

      assert result == "NGCMPJLHV"
    end
  end

  describe "day6" do
    test "first part is able to compute position of first packet marker from examples" do
      data = [
        {"mjqjpqmgbljsphdztnvjfqwrcgsmlb", 7},
        {"bvwbjplbgvbhsrlpgdmjqwftvncz", 5},
        {"nppdvjthqldpwncqszvftbrmjlhg", 6},
        {"nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 10},
        {"zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 11}
      ]

      Enum.each(data, fn {input, expected_result} ->
        result = input |> mk_tmp_file() |> Aoc2022.Day6.first()
        assert expected_result == result
      end)
    end

    test "first part is able to compute position of first packet marker from input" do
      result = Aoc2022.Day6.first("inputs/day6.txt")
      assert result == 0
    end
  end

  def mk_tmp_file(input) do
    tmp_file_path = "./test/tmp_file#{Enum.random(0..10000)}.txt"

    File.write!(tmp_file_path, input)
    on_exit(fn -> File.rm!(tmp_file_path) end)

    tmp_file_path
  end
end
