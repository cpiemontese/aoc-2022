defmodule Aoc2022.Day5 do
  def first(input_path, input_state) do
    input_path
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&(&1 |> String.split(" ") |> parse_move()))
    |> apply_moves(input_state)
    |> get_top_values()
  end

  def second(input_path) do
    input_path
  end

  defp parse_move(["move", moved, "from", from, "to", to]),
    do: {String.to_integer(moved), String.to_integer(from), String.to_integer(to)}

  defp apply_moves([], state), do: state

  defp apply_moves([{moved, from, to} | rest], state) do
    from_col = Map.get(state, from)
    to_col = Map.get(state, to)

    to_move =
      from_col
      |> Enum.take(moved)
      |> Enum.reverse()

    state =
      state
      |> Map.put(from, Enum.take(from_col, moved - length(from_col)))
      |> Map.put(to, to_move ++ to_col)

    apply_moves(rest, state)
  end

  defp get_top_values(state) do
    state
    |> Map.values()
    |> Enum.reduce([], fn curr, acc ->
      acc ++ [List.first(curr)]
    end)
  end
end
