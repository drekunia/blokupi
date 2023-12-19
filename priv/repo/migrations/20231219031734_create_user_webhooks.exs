defmodule Blokupi.Repo.Migrations.CreateUserWebhooks do
  use Ecto.Migration

  def change do
    create table(:user_webhooks) do
      add :user_id, references(:users, on_delete: :nothing)
      add :platform, :string
      add :is_active, :boolean, default: false, null: false
      add :url, :string
      add :message, :string
      add :fail_count, :integer

      timestamps(type: :utc_datetime)
    end

    create index(:user_webhooks, [:user_id])
  end
end
