defmodule ExMon.Trainer.Get do
  alias Ecto.UUID
  alias ExMon.{Trainer, Repo}

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID!"}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(Trainer, uuid) do
      nil -> {:error, "Trainer not found!"}
      trainer -> {:ok, trainer}
    end
  end

end
