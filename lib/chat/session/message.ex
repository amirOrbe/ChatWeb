defmodule Chat.Session.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :name, :string
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:name, :text])
    |> validate_required([:name, :text])
    |> validate_required([:text, :text])
  end
end
