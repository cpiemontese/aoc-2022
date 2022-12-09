defmodule Aoc2022.Day8 do
  def first(input_path) do
    input =
      input_path
      |> File.read!()
      |> String.split("\n")

    cols = Enum.count(input)
    rows = input |> Enum.at(0) |> String.length()

    flat_input =
      input
      |> Enum.flat_map(&String.graphemes(&1))
      |> Enum.map(&String.to_integer(&1))

    outer_visible_trees = 2 * rows + 2 * (cols - 2)

    inner_visible_trees =
      Stream.flat_map(1..(rows - 2), fn row ->
        Stream.map(1..(cols - 2), fn col -> {row, col} end)
      end)
      |> Stream.filter(fn {row, col} ->
        left_trees = get_trees_in_direction(flat_input, row, col, rows, cols, :left)
        right_trees = get_trees_in_direction(flat_input, row, col, rows, cols, :right)
        up_trees = get_trees_in_direction(flat_input, row, col, rows, cols, :up)
        down_trees = get_trees_in_direction(flat_input, row, col, rows, cols, :down)

        tree_height = Enum.at(flat_input, get_idx(row, col, cols))

        Enum.all?(left_trees, fn tree -> tree < tree_height end) or
          Enum.all?(right_trees, fn tree -> tree < tree_height end) or
          Enum.all?(up_trees, fn tree -> tree < tree_height end) or
          Enum.all?(down_trees, fn tree -> tree < tree_height end)
      end)
      |> Enum.count()

    outer_visible_trees + inner_visible_trees
  end

  def second(input_path) do
    input_path
  end

  defp get_idx(row, col, cols), do: col + cols * row

  defp get_trees_in_direction(trees_array, row, col, rows, cols, direction) do
    idxs = get_direction_idxs(row, col, rows, cols, direction)
    Stream.map(idxs, fn {row, col} -> Enum.at(trees_array, get_idx(row, col, cols)) end)
  end

  defp get_direction_idxs(row, col, rows, cols, direction)
  defp get_direction_idxs(row, col, _, _, :up), do: Stream.map(0..(row - 1), &{&1, col})

  defp get_direction_idxs(row, col, rows, _, :down),
    do: Stream.map((row + 1)..(rows - 1), &{&1, col})

  defp get_direction_idxs(row, col, _, _, :left),
    do: Stream.map(0..(col - 1), &{row, &1})

  defp get_direction_idxs(row, col, _, cols, :right),
    do: Stream.map((col + 1)..(cols - 1), &{row, &1})
end
