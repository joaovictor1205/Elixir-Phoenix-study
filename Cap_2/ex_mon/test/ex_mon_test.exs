defmodule ExMonTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{life: 100, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "João"}

      assert ExMon.create_player("João", :chute, :soco, :cura) == expected_response
    end
  end

  describe "start_game/1" do
    test "when the game is started, returns a message" do
      player = Player.build("João", :chute, :soco, :cura)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "The game is started!"

    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("João", :chute, :soco, :cura)
      capture_io(fn ->
        ExMon.start_game(player)
      end)
      :ok
    end

    test "when the move is valid, do the move, and the computer makes a move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:chute)
        end)

      assert messages =~ "The Player has attacked"
    end

    test "when the move is invalid, returns an error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:err)
        end)

      assert messages =~ "Invalid move"
    end
  end

end
