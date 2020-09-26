defmodule FizzBuzz do
  def build(file_name) do
    file_name
    |> File.read()
    |> handle_file_read()
  end

  # defp -> função privada
  defp handle_file_read({:ok, result}) do
    result =
      result
      |> String.split(",")
      |> Enum.map(&convert_and_evaluate_numbers/1)

    # Tupla de sucesso
    {:ok, result}
  end

  # Tupla de erro
  defp handle_file_read({:error, reason}), do: {:error, "Error on file: #{reason}"}

  defp convert_and_evaluate_numbers(elem) do
    elem
    |> String.to_integer()
    |> evaluate_numbers()
  end

  # Guard
  defp evaluate_numbers(number) when rem(number, 3) == 0 and rem(number, 5) == 0, do: :fizzbuzz
  defp evaluate_numbers(number) when rem(number, 3) == 0, do: :fizz
  defp evaluate_numbers(number) when rem(number, 5) == 0, do: :buzz
  # Se o número não 'casar' com nenhum caso acima, retorna o próprio número
  defp evaluate_numbers(number), do: number
end
