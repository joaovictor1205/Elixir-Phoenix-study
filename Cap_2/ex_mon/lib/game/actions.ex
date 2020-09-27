defmodule ExMon.Game.Actions do
  alias ExMon.Game
  alias ExMon.Game.Actions.Attack

  def attack(move) do
    case Game.turn() do
      :player -> Attack.attack_opponent(:computer, move)
      :computador -> Attack.attack_opponent(:player, move)
    end
  end

  def fetch_move(move) do
    Game.player()
    |> Map.get(:moves)
    |> find_moves(move)
  end

  defp find_moves(moves, move) do
    Enum.find_value(moves, {:error, move}, fn {key, value} ->
      if value == move, do: {:ok, key}
    end)
  end
end
