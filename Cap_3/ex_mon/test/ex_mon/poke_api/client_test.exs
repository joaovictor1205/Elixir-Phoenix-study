defmodule ExMon.PokeApi.ClientTest do
  use ExUnit.Case
  import Tesla.Mock
  alias ExMon.PokeApi.Client

  @base_url "https://pokeapi.co/api/v2/pokemon/"

  describe "get_pokemon/1" do
    test "when there is a pokemon with the given name, returns the pokemon" do
      body = %{"name" => "pikachu", "weight" => 60, "types" => ["eletric"]}

      mock(fn %{method: :get, url: @base_url <> "pikachu"} ->
        %Tesla.Env{status: 200, body: body}
      end)

      response = Client.get_pokemon("pikachu")

      assert response == {:ok, %{"name" => "pikachu", "types" => ["eletric"], "weight" => 60}}
    end

    test "when there is no pokemon with the given name, returns an error" do
      mock(fn %{method: :get, url: @base_url <> "error"} ->
        %Tesla.Env{status: 404}
      end)

      response = Client.get_pokemon("error")

      assert response == {:error, "Sorry :( This pokemon was not found!"}
    end

    test "when there is an unexpected error, returns an error" do
      mock(fn %{method: :get, url: @base_url <> "pikachu"} ->
        {:error, :timeout}
      end)

      response = Client.get_pokemon("pikachu")

      assert response == {:error, :timeout}
    end

  end
end
