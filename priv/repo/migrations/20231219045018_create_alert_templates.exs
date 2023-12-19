defmodule Blokupi.Repo.Migrations.CreateAlertTemplates do
  use Ecto.Migration

  def change do
    create table(:alert_templates) do
      add :user_id, references(:users, on_delete: :nothing)
      add :user_stream_key_id, references(:user_stream_keys, on_delete: :nothing)
      add :is_active, :boolean, default: false, null: false
      add :is_content_active, :boolean, default: false, null: false
      add :is_speech_active, :boolean, default: false, null: false
      add :alert_threshold, :integer
      add :content_threshold, :integer
      add :speech_threshold, :integer
      add :alert_sound, :string
      add :filtered_words, :string

      timestamps(type: :utc_datetime)
    end

    create index(:alert_templates, [:user_id])
    create index(:alert_templates, [:user_stream_key_id])
  end
end
