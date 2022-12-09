defmodule Aoc2022.Day7 do
  @size_limit 100_000

  def first(input_path) do
    input_path
    |> File.read!()
    |> String.split("\n")
    |> traverse()
    |> Enum.filter(fn size -> size <= @size_limit end)
    |> Enum.map(fn size -> size end)
    |> Enum.sum()
  end

  @max_space 70_000_000
  @unused_space_needed 30_000_000

  def second(input_path) do
    dir_sizes =
      input_path
      |> File.read!()
      |> String.split("\n")
      |> traverse()

    root_dir_size = Enum.max(dir_sizes)

    dir_sizes
    |> Enum.filter(fn size ->
      size >= @unused_space_needed - (@max_space - root_dir_size)
    end)
    |> Enum.min()
  end

  defp traverse(terminal_output), do: do_traverse(terminal_output, [], [])

  defp do_traverse(terminal_output, dir_stack, dir_sizes)

  defp do_traverse([], dir_stack, dir_sizes), do: unwind_dir_stack(dir_stack, dir_sizes)

  defp do_traverse(["$ cd .." | rest], [curr_dir_size, parent_dir_size | rest_sizes], dir_sizes) do
    do_traverse(rest, [parent_dir_size + curr_dir_size | rest_sizes], [curr_dir_size | dir_sizes])
  end

  defp do_traverse(["$ cd " <> _ | rest], dir_stack, dir_sizes),
    do: do_traverse(rest, [0 | dir_stack], dir_sizes)

  defp do_traverse(["$ ls" | rest], dir_stack, dir_sizes),
    do: do_traverse(rest, dir_stack, dir_sizes)

  defp do_traverse(["dir " <> _ | rest], dir_stack, dir_sizes),
    do: do_traverse(rest, dir_stack, dir_sizes)

  defp do_traverse([file | rest], [curr_dir_size | rest_stack], dir_sizes) do
    [size, _] = String.split(file, " ")

    parsed_size = String.to_integer(size)

    do_traverse(rest, [curr_dir_size + parsed_size | rest_stack], dir_sizes)
  end

  defp unwind_dir_stack([last], dir_sizes), do: [last | dir_sizes]

  defp unwind_dir_stack([current, parent | rest], dir_sizes),
    do: unwind_dir_stack([current + parent | rest], [current | dir_sizes])
end
