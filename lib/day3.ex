defmodule Aoc2022.Day3 do
  def first(input_file) do
    input_file
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn i ->
      len = String.length(i)
      mid = div(len, 2)
      first_part = String.slice(i, 0, mid)
      second_part = String.slice(i, mid, len)

      first_part
      |> String.graphemes()
      |> Enum.find(fn letter ->
        String.contains?(second_part, letter)
      end)
      |> :binary.first()
    end)
    |> Enum.reduce(0, &(get_priority(&1) + &2))
  end

  def second(input_file) do
    input_file
    |> File.read!()
    |> String.split("\n")
    |> Enum.chunk_every(3)
    |> Enum.map(fn group ->
      group
      |> List.first()
      |> String.graphemes()
      |> Enum.find(fn letter ->
        group |> Enum.at(1) |> String.contains?(letter) &&
          group |> Enum.at(2) |> String.contains?(letter)
      end)
      |> :binary.first()
    end)
    |> Enum.reduce(0, &(get_priority(&1) + &2))
  end

  def get_priority(item) when item in ?a..?z, do: item - 96
  def get_priority(item), do: item - 38
end
