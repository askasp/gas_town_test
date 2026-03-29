defmodule GasTownTest.Electronics.ComponentSpec do
  use Ecto.Schema
  import Ecto.Changeset

  schema "component_specs" do
    field :key, :string
    field :value, :string
    field :unit, :string

    belongs_to :component, GasTownTest.Electronics.Component

    timestamps(type: :utc_datetime)
  end

  def changeset(spec, attrs) do
    spec
    |> cast(attrs, [:key, :value, :unit, :component_id])
    |> validate_required([:key, :value, :component_id])
    |> foreign_key_constraint(:component_id)
    |> unique_constraint([:component_id, :key])
  end
end
