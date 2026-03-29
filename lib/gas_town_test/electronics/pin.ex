defmodule GasTownTest.Electronics.Pin do
  use Ecto.Schema
  import Ecto.Changeset

  @pin_types ~w(digital_io analog_in power ground pwm)

  schema "pins" do
    field :name, :string
    field :number, :integer
    field :type, :string
    field :voltage_min, :float
    field :voltage_max, :float

    belongs_to :component, GasTownTest.Electronics.Component

    timestamps(type: :utc_datetime)
  end

  def changeset(pin, attrs) do
    pin
    |> cast(attrs, [:name, :number, :type, :voltage_min, :voltage_max, :component_id])
    |> validate_required([:name, :number, :type, :component_id])
    |> validate_inclusion(:type, @pin_types)
    |> validate_number(:voltage_min, greater_than_or_equal_to: -50.0)
    |> validate_number(:voltage_max, greater_than_or_equal_to: -50.0)
    |> foreign_key_constraint(:component_id)
    |> unique_constraint([:component_id, :number])
  end
end
