defmodule ExMonWeb.Controllers.TrainersControllerTest do
  use ExMonWeb.ConnCase
  alias ExMon.Trainer
  import ExMonWeb.Auth.Guardian

  describe "show/2" do

    setup %{conn: conn} do
      params = %{name: "João Victor", password: "joao123"}
      {:ok, trainer} = ExMon.create_trainer(params)
      {:ok, token, _claims} = encode_and_sign(trainer)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")
      {:ok, conn: conn}
    end

    test "when there is a trainer with the given id, returns the trainer", %{conn: conn} do
      params = %{name: "João Victor", password: "joao123"}

      {:ok, %Trainer{id: id}} = ExMon.create_trainer(params)

      response =
        conn
        |> get(Routes.trainers_path(conn, :show, id))
        |> json_response(:ok)

      assert %{"id" => _id, "inserted_at" => _inserted_at, "name" => "João Victor"} = response
    end

    test "when there is a trainer with invalid id, returns an error", %{conn: conn} do
      response =
        conn
        |> get(Routes.trainers_path(conn, :show, "123"))
        |> json_response(:bad_request)

      assert %{"message" => "Invalid ID!"} == response
    end
  end
end
