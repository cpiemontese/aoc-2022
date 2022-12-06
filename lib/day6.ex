defmodule Aoc2022.Day6 do
  def first(input_path) do
    input_path
    |> File.read!()
    |> String.graphemes()
    |> get_first_marker_position()
  end

  def second(input_path) do
    input_path
  end

  defp get_first_marker_position(datastream), do: do_get_first_marker_position(datastream, 0)

  defp do_get_first_marker_position(datastream, index) when length(datastream) == index + 4 do
    -1
  end

  defp do_get_first_marker_position(datastream, index) do
    unique_letters =
      datastream
      |> Enum.slice(index, 4)
      |> Enum.reduce(%{}, fn element, acc ->
        prev = Map.get(acc, element, 0)
        Map.put(acc, element, prev + 1)
      end)
      |> Map.keys()
      |> Enum.count()

    if unique_letters == 4,
      do: index + 4,
      else: do_get_first_marker_position(datastream, index + 1)
  end
end
