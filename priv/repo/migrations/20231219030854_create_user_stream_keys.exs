defmodule Blokupi.Repo.Migrations.CreateUserStreamKeys do
  use Ecto.Migration

  def change do
    create table(:user_stream_keys) do
      add :user_id, references(:users, on_delete: :nothing)
      add :key_name, :string
      add :stream_key, :string
      add :is_active, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end

    create index(:user_stream_keys, [:user_id])
  end
end
