defmodule ExMon.TrainerTest do
  use ExMon.DataCase
  alias ExMon.Trainer

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "João Victor", password: "joao123"}
      response = Trainer.changeset(params)

      assert %Ecto.Changeset{changes: %{name: "João Victor", password: "joao123"}, errors: [], data: %ExMon.Trainer{}, valid?: true} = response
    end

    test "when there are invalid params, returns an invalid changeset" do
      params = %{name: "João Victor", password: "joao"}
      response = Trainer.changeset(params)

      assert %Ecto.Changeset{changes: %{name: "João Victor", password: "joao"}, data: %ExMon.Trainer{}, valid?: false} = response
      assert errors_on(response) == %{password: ["should be at least 6 character(s)"]}
    end

  end

  describe "build/1" do
    test "when all params are valid, returns a trainer struct" do
      params = %{name: "João Victor", password: "joao123"}
      response = Trainer.build(params)

      assert {:ok, %Trainer{name: "João Victor"}} = response
    end

    test "when there are invalid params, returns an error" do
      params = %{name: "João Victor", password: "joao"}
      {:error, response} = Trainer.build(params)

      assert %Ecto.Changeset{valid?: false} = response
      assert errors_on(response) == %{password: ["should be at least 6 character(s)"]}
    end
  end
end
