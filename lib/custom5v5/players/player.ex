defmodule Custom5v5.Players.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "player" do
    field :name, :string
    field :elo, :string
    field :post, :string

    timestamps()
  end

  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :elo, :post])
    |> validate_required([:name, :elo, :post])
  end
end
