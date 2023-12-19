defmodule Blokupi.Features.AlertTemplate do
  alias Blokupi.Features.UserStreamKey
  alias Blokupi.Accounts.User
  use Ecto.Schema
  import Ecto.Changeset

  schema "alert_templates" do
    field :is_active, :boolean, default: false
    field :is_content_active, :boolean, default: false
    field :is_speech_active, :boolean, default: false
    field :alert_threshold, :integer
    field :content_threshold, :integer
    field :speech_threshold, :integer
    field :alert_sound, :string
    field :filtered_words, :string
    field :user_id, :id
    field :user_stream_key_id, :id

    timestamps(type: :utc_datetime)

    belongs_to(:user, User, define_field: false)
    belongs_to(:user_stream_key, UserStreamKey, define_field: false)
  end

  @doc false
  def changeset(alert_template, attrs) do
    alert_template
    |> cast(attrs, [:is_active, :is_content_active, :is_speech_active, :alert_threshold, :content_threshold, :speech_threshold, :alert_sound, :filtered_words])
    |> validate_required([:is_active, :is_content_active, :is_speech_active, :alert_threshold, :content_threshold, :speech_threshold, :alert_sound, :filtered_words])
  end
end
