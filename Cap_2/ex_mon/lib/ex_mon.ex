defmodule ExMon do

  alias ExMon.{Game, Player}
  alias ExMon.Game.Status
  alias ExMon.Game.Actions

  @computer_name "Robotinik"

  def create_player(move_avg, move_heal, move_rnd, name) do
    Player.build(move_avg, move_heal, move_rnd, name)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)
    Status.print_round_message()
  end

  def make_move(move) do
    move
    |> Actions.fetch_move()
    |> do_move()
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :move_heal -> "Cura realizada!"
      move -> Actions.attack(move)
    end
  end
end
