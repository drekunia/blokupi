defmodule Blokupi.Accounts.UserProfile do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blokupi.Accounts.User

  schema "user_profiles" do
    field :display_name, :string
    field :avatar, :string
    field :bio, :string
    field :urls, :string
    field :amount_buttons, :string
    field :user_id, :id

    timestamps(type: :utc_datetime)

    belongs_to(:user, User, define_field: false)
  end

  @doc false
  def changeset(user_profile, attrs) do
    user_profile
    |> cast(attrs, [:display_name, :avatar, :bio, :urls, :amount_buttons])
    |> validate_required([:display_name, :avatar, :bio, :urls, :amount_buttons])
  end
end
