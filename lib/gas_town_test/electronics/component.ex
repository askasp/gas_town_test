defmodule GasTownTest.Electronics.Component do
  use Ecto.Schema
  import Ecto.Changeset

  @component_types ~w(microcontroller passive active connector)

  schema "components" do
    field :name, :string
    field :type, :string
    field :description, :string
    field :package_type, :string
    field :datasheet_url, :string

    has_many :pins, GasTownTest.Electronics.Pin
    has_many :specs, GasTownTest.Electronics.ComponentSpec

    timestamps(type: :utc_datetime)
  end

  def changeset(component, attrs) do
    component
    |> cast(attrs, [:name, :type, :description, :package_type, :datasheet_url])
    |> validate_required([:name, :type])
    |> validate_inclusion(:type, @component_types)
    |> unique_constraint(:name)
  end
end
