defmodule GasTownTest.Repo.Migrations.CreateComponents do
  use Ecto.Migration

  def change do
    create table(:components) do
      add :name, :string, null: false
      add :type, :string, null: false
      add :description, :text
      add :package_type, :string
      add :datasheet_url, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:components, [:name])

    create table(:pins) do
      add :name, :string, null: false
      add :number, :integer, null: false
      add :type, :string, null: false
      add :voltage_min, :float
      add :voltage_max, :float
      add :component_id, references(:components, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:pins, [:component_id])
    create unique_index(:pins, [:component_id, :number])

    create table(:component_specs) do
      add :key, :string, null: false
      add :value, :string, null: false
      add :unit, :string
      add :component_id, references(:components, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:component_specs, [:component_id])
    create unique_index(:component_specs, [:component_id, :key])
  end
end
