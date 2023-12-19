defmodule Blokupi.Features.UserWebhook do
  alias Blokupi.Accounts.User
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_webhooks" do
    field :message, :string
    field :url, :string
    field :platform, :string
    field :is_active, :boolean, default: false
    field :fail_count, :integer
    field :user_id, :id

    timestamps(type: :utc_datetime)

    belongs_to(:user, User, define_field: false)
  end

  @doc false
  def changeset(user_webhook, attrs) do
    user_webhook
    |> cast(attrs, [:platform, :is_active, :url, :message, :fail_count])
    |> validate_required([:platform, :is_active, :url, :message, :fail_count])
  end
end
