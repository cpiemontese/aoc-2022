defmodule Aoc2022.Day2 do
  def first(input_file) do
    stream = File.stream!(input_file)

    stream
    |> Enum.map(fn round ->
      round
      |> String.trim()
      |> String.split(" ")
      |> parse_round()
      |> then(fn [elf, me] ->
        round_points(elf, me) + choice_points(me)
      end)
    end)
    |> Enum.sum()
  end

  def second(input_file) do
    File.stream!(input_file)
  end

  def choice_points(:rock), do: 1
  def choice_points(:paper), do: 2
  def choice_points(:scissors), do: 3

  def is_beat_by(:rock), do: :paper
  def is_beat_by(:paper), do: :scissors
  def is_beat_by(:scissors), do: :rock

  def parse_round([elf, me]), do: [parse_choice(elf), parse_choice(me)]

  def parse_choice("A"), do: :rock
  def parse_choice("B"), do: :paper
  def parse_choice("C"), do: :scissors
  def parse_choice("X"), do: :rock
  def parse_choice("Y"), do: :paper
  def parse_choice("Z"), do: :scissors

  def round_points(elf, me) do
    result =
      cond do
        elf == me -> 3
        is_beat_by(elf) == me -> 6
        true -> 0
      end

    IO.inspect({elf, me, result})
    result
  end
end
