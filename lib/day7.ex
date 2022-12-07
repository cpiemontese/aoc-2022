defmodule Aoc2022.Day7 do
  def first(input_path, total_size) do
    input_path
    |> File.read!()
    |> String.split("\n")
    |> traverse()
    |> compute_size_of_directories()
    |> Enum.filter(fn {_, size} -> size <= total_size end)
    |> Enum.map(fn {_, size} -> size end)
    |> Enum.sum()
  end

  def second(input_path) do
    input_path
  end

  defp traverse(terminal_output), do: do_traverse(terminal_output, %{}, [])

  defp do_traverse(terminal_output, file_system, current_path)

  defp do_traverse([], file_system, _current_path), do: file_system

  defp do_traverse(["$ cd .." | rest], file_system, current_path) do
    {_, current_path} = List.pop_at(current_path, -1)
    do_traverse(rest, file_system, current_path)
  end

  defp do_traverse(["$ cd " <> arg | rest], file_system, current_path) do
    current_path = current_path ++ [arg]
    do_traverse(rest, file_system, current_path)
  end

  defp do_traverse(["$ ls" | rest], file_system, current_path),
    do: do_traverse(rest, file_system, current_path)

  defp do_traverse([ls_result | rest], file_system, current_path) do
    [ls1, ls2] = String.split(ls_result, " ")

    file_system =
      case Integer.parse(ls1) do
        {parsed, _} -> put_in(file_system, nested_key(current_path ++ [ls2]), parsed)
        _ -> file_system
      end

    do_traverse(rest, file_system, current_path)
  end

  defp compute_size_of_directories(file_system),
    do: do_compute_size_of_directories(file_system["/"], "/")

  defp do_compute_size_of_directories(file_system, curr_dir) do
    keys = Map.keys(file_system)

    file_sizes =
      keys |> Enum.filter(&(!is_map(file_system[&1]))) |> Enum.map(&file_system[&1]) |> Enum.sum()

    directories =
      keys
      |> Enum.filter(&is_map(file_system[&1]))
      |> Enum.flat_map(&do_compute_size_of_directories(file_system[&1], &1))

    sum_of_directories =
      Enum.reduce(directories, 0, fn {_dir, size}, acc ->
        acc + size
      end)

    [{curr_dir, sum_of_directories + file_sizes} | directories]
  end

  defp nested_key(keys), do: keys |> Enum.map(&Access.key(&1, %{}))
end
