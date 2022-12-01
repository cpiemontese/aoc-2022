defmodule Aoc2022.Day1 do
  def run(input_file) do
    stream = File.stream!(input_file)

    {_, max} =
      Enum.reduce(stream, {0, -1}, fn element, {sum, current_max} ->
        case element do
          "\n" ->
            {0, max(sum, current_max)}

          _ ->
            number = element |> String.slice(0..-2) |> String.to_integer()
            {sum + number, current_max}
        end
      end)

    max
  end
end
