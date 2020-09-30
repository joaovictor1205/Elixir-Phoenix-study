defmodule ExMon.GameTest do
  use ExUnit.Case
  alias ExMon.Player
  alias ExMon.Game

  describe "start/2" do
    test "start the game" do
      player = Player.build("João", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("João", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{computer: %Player{life: 100, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "Robotinik"}, player: %Player{life: 100, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "João"}, status: :started, turn: :player}
      assert Game.info() == expected_response
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("João", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{computer: %Player{life: 100, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "Robotinik"}, player: %Player{life: 100, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "João"}, status: :started, turn: :player}
      assert Game.info() == expected_response

      new_info = %{computer: %Player{life: 50, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "Robotinik"}, player: %Player{life: 85, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "João"}, status: :started, turn: :player}
      Game.update(new_info)

      expected_new_response = %{new_info | turn: :computer, status: :continue}

      assert Game.info() == expected_new_response

    end
  end

end
