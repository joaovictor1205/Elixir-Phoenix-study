defmodule ExMon.Trainer.Delete do
  alias Ecto.UUID
  alias ExMon.{Trainer, Repo}

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID!"}
      {:ok, uuid} -> delete(uuid)
    end
  end

  defp delete(uuid) do
    case fetch_trainer(uuid) do
      nil -> {:error, "Trainer not found!"}
      trainer -> Repo.delete(trainer)
    end
  end

  defp fetch_trainer(uuid), do: Repo.get(Trainer, uuid)
end
