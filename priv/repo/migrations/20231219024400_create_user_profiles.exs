defmodule Blokupi.Repo.Migrations.CreateUserProfiles do
  use Ecto.Migration

  def change do
    create table(:user_profiles) do
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :display_name, :string
      add :avatar, :string
      add :bio, :string
      add :urls, :string
      add :amount_buttons, :string

      timestamps(type: :utc_datetime)
    end

    create index(:user_profiles, [:user_id])
  end
end
