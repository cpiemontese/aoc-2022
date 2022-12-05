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

  def mk_tmp_file(input) do
    tmp_file_path = "./test/tmp_file#{Enum.random(0..10000)}.txt"

    File.write!(tmp_file_path, input)
    on_exit(fn -> File.rm!(tmp_file_path) end)

    tmp_file_path
  end
end
