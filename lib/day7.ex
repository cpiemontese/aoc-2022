defmodule Aoc2022.Day7 do
  def first(input_path, _max_size) do
    input_path
    |> File.read!()
    |> String.split("\n")
    |> IO.inspect()
    |> traverse()
  end

  def second(input_path) do
    input_path
  end

  defp traverse(terminal_output), do: do_traverse(terminal_output, %{}, [])

  defp do_traverse(terminal_output, file_system, current_path)

  defp do_traverse([], file_system, _current_path), do: file_system

  defp do_traverse(["$" <> " " <> "cd" <> " " <> arg | rest], file_system, current_path) do
    current_path = current_path ++ [arg]
    file_system = put_in(file_system, nested_key(current_path), %{})
    do_traverse(rest, file_system, current_path)
  end

  defp do_traverse(["$" <> " " <> "ls" | rest], file_system, current_path),
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

  defp nested_key(keys), do: keys |> Enum.map(&Access.key(&1, %{}))
end
