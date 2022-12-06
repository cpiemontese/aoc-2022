defmodule Aoc2022.Day6 do
  @start_of_packet_marker_size 4
  @start_of_message_marker_size 14

  def first(input_path) do
    input_path
    |> File.read!()
    |> String.graphemes()
    |> get_first_marker_position(@start_of_packet_marker_size)
  end

  def second(input_path) do
    input_path
    |> File.read!()
    |> String.graphemes()
    |> get_first_marker_position(@start_of_message_marker_size)
  end

  defp get_first_marker_position(datastream, marker_size),
    do: do_get_first_marker_position(datastream, marker_size, 0)

  defp do_get_first_marker_position(datastream, marker_size, index)
       when length(datastream) == index + marker_size do
    -1
  end

  defp do_get_first_marker_position(datastream, marker_size, index) do
    unique_letters =
      datastream
      |> Enum.slice(index, marker_size)
      |> Enum.reduce(%{}, fn element, acc ->
        prev = Map.get(acc, element, 0)
        Map.put(acc, element, prev + 1)
      end)
      |> Map.keys()
      |> Enum.count()

    if unique_letters == marker_size,
      do: index + marker_size,
      else: do_get_first_marker_position(datastream, marker_size, index + 1)
  end
end
