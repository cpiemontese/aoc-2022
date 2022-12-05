defmodule Aoc2022.Day1 do
  def first(input_file) do
    {_, max} =
      input_file
      |> File.stream!()
      |> Enum.reduce({0, -1}, fn element, {sum, current_max} ->
        case element do
          "\n" ->
            {0, max(sum, current_max)}

          _ ->
            {sum + parse_calorie(element), current_max}
        end
      end)

    max
  end

  def second(input_file) do
    input_file
    |> File.stream!()
    |> parse_elves_calories()
    |> Enum.map(fn elf_calories ->
      Enum.sum(elf_calories)
    end)
    |> Enum.reduce({0, 0, 0}, fn element, {first, second, third} = acc ->
      cond do
        element > first -> {element, first, second}
        element > second -> {first, element, second}
        element > third -> {first, second, element}
        true -> acc
      end
    end)
    |> Tuple.to_list()
    |> Enum.sum()
  end

  def parse_calorie(calorie),
    do: calorie |> String.split("\n") |> List.first() |> String.to_integer()

  def parse_elves_calories(calories) do
    Enum.reduce(calories, [], fn element, acc ->
      case element do
        "\n" ->
          [[] | acc]

        _ ->
          last_elf = List.first(acc, [])
          last_elf = [parse_calorie(element) | last_elf]
          {_, rest} = List.pop_at(acc, 0)
          [last_elf | rest]
      end
    end)
  end
end
