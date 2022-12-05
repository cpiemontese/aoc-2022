defmodule Aoc2022.Day4 do
  def first(input_file) do
    input_file
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn pair ->
      [l, r] = parse_pair(pair)

      [a, b] = l
      [x, y] = r

      if (a <= x && y <= b) || (x <= a && b <= y) do
        1
      else
        0
      end
    end)
    |> Enum.sum()
  end

  def second(input_file) do
    input_file
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn pair ->
      [l, r] = parse_pair(pair)

      [a, b] = l
      [x, y] = r

      if (a <= x && x <= b) || (a <= y && y <= b) || (x <= a && b <= y) do
        1
      else
        0
      end
    end)
    |> Enum.sum()
  end

  defp parse_pair(pair),
    do:
      pair
      |> String.split(",")
      |> Enum.map(fn range ->
        range |> String.split("-") |> Enum.map(&String.to_integer(&1))
      end)
end
