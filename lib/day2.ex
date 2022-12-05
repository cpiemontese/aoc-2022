defmodule Aoc2022.Day2 do
  def first(input_file) do
    input_file
    |> File.stream!()
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
    input_file
    |> File.stream!()
    |> Enum.map(fn round ->
      round
      |> String.trim()
      |> String.split(" ")
      |> parse_round_adjusted()
      |> then(fn [elf, result] ->
        me = compute_choice_from_result(elf, result)
        round_points(elf, me) + choice_points(me)
      end)
    end)
    |> Enum.sum()
  end

  def choice_points(:rock), do: 1
  def choice_points(:paper), do: 2
  def choice_points(:scissors), do: 3

  def is_beat_by(:rock), do: :paper
  def is_beat_by(:paper), do: :scissors
  def is_beat_by(:scissors), do: :rock

  def parse_round([elf, me]), do: [parse_choice(elf), parse_choice(me)]
  def parse_round_adjusted([elf, result]), do: [parse_choice(elf), parse_result(result)]

  def parse_choice("A"), do: :rock
  def parse_choice("B"), do: :paper
  def parse_choice("C"), do: :scissors
  def parse_choice("X"), do: :rock
  def parse_choice("Y"), do: :paper
  def parse_choice("Z"), do: :scissors

  def parse_result("X"), do: :lose
  def parse_result("Y"), do: :draw
  def parse_result("Z"), do: :win

  def compute_choice_from_result(elf, :lose), do: elf |> is_beat_by() |> is_beat_by()
  def compute_choice_from_result(elf, :draw), do: elf
  def compute_choice_from_result(elf, :win), do: elf |> is_beat_by()

  def round_points(elf, me) do
    cond do
      elf == me -> 3
      is_beat_by(elf) == me -> 6
      true -> 0
    end
  end
end
