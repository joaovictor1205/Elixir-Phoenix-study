defmodule ExMon.Trainer.CreateTest do
  use ExMon.DataCase

  alias ExMon.{Trainer, Repo}
  alias Trainer.Create

  describe "call/1" do
    test "when all params are valid, creates a trainer" do
      params = %{name: "João Victor", password: "joao123"}

      count_before = Repo.aggregate(Trainer, :count)

      response = Create.call(params)

      count_after = Repo.aggregate(Trainer, :count)

      assert {:ok, %Trainer{name: "João Victor"}} = response
      assert count_after > count_before
    end


    test "when there are invalid params, returns an error" do
      params = %{name: "João Victor", password: "joao"}

      response = Create.call(params)

      assert {:error, changeset} = response
      assert errors_on(changeset) == %{password: ["should be at least 6 character(s)"]}
    end

  end
end
