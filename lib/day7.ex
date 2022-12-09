defmodule Aoc2022.Day7 do
  @size_limit 100_000

  def first(input_path) do
    input_path
    |> File.read!()
    |> String.split("\n")
    |> traverse()
    |> compute_size_of_directories()
    |> Enum.filter(fn {_, size} -> size <= @size_limit end)
    |> Enum.map(fn {_, size} -> size end)
    |> Enum.sum()
  end

  @max_space 70_000_000
  @unused_space_needed 30_000_000

  def second(input_path) do
    size_of_directories =
      input_path
      |> File.read!()
      |> String.split("\n")
      |> traverse()
      |> compute_size_of_directories()

    {_, root_dir_size} = Enum.find(size_of_directories, fn {dir, _} -> dir == "/" end)
    available_space = @max_space - root_dir_size
    space_to_free = @unused_space_needed - available_space

    {dir, _} =
      size_of_directories
      |> Enum.filter(fn {_, size} -> size >= space_to_free end)
      |> Enum.min_by(fn {_, size} -> size end)

    dir
  end

  defp traverse(terminal_output), do: do_traverse(terminal_output, %{"/" => %{}}, [])

  defp do_traverse(terminal_output, file_system, current_path)

  defp do_traverse([], file_system, _current_path), do: file_system

  defp do_traverse(["$ cd .." | rest], file_system, [_ | current_path]) do
    do_traverse(rest, file_system, current_path)
  end

  defp do_traverse(["$ cd " <> arg | rest], file_system, current_path) do
    do_traverse(rest, file_system, [arg | current_path])
  end

  defp do_traverse(["$ ls" | rest], file_system, current_path),
    do: do_traverse(rest, file_system, current_path)

  defp do_traverse(["dir " <> dir | rest], file_system, current_path) do
    file_system = put_in(file_system, Enum.reverse([dir | current_path]), %{})
    do_traverse(rest, file_system, current_path)
  end

  defp do_traverse([ls_result | rest], file_system, current_path) do
    [ls1, ls2] = String.split(ls_result, " ")

    parsed = String.to_integer(ls1)
    file_system = put_in(file_system, Enum.reverse([ls2 | current_path]), parsed)

    do_traverse(rest, file_system, current_path)
  end

  defp compute_size_of_directories(file_system),
    do: do_compute_size_of_directories(file_system["/"], "/")

  defp do_compute_size_of_directories(file_system, curr_dir) do
    keys = Map.keys(file_system)

    file_sizes =
      keys
      |> Enum.filter(&(not is_map(file_system[&1])))
      |> Enum.map(&file_system[&1])
      |> Enum.sum()

    directories =
      keys
      |> Enum.filter(&is_map(file_system[&1]))
      |> Enum.flat_map(&do_compute_size_of_directories(file_system[&1], &1))

    sum_of_directories =
      directories
      |> Enum.map(fn {_dir, size} -> size end)
      |> Enum.sum()

    [{curr_dir, sum_of_directories + file_sizes} | directories]
  end
end
