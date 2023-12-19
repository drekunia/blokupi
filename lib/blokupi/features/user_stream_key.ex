defmodule Blokupi.Features.UserStreamKey do
  alias Blokupi.Features.AlertTemplate
  alias Blokupi.Accounts.User
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_stream_keys" do
    field :key_name, :string
    field :stream_key, :string
    field :is_active, :boolean, default: false
    field :user_id, :id

    timestamps(type: :utc_datetime)

    belongs_to(:user, User, define_field: false)
    has_many(:alert_template, AlertTemplate)
  end

  @doc false
  def changeset(user_stream_key, attrs) do
    user_stream_key
    |> cast(attrs, [:key_name, :stream_key, :is_active])
    |> validate_required([:key_name, :stream_key, :is_active])
  end
end
