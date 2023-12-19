defmodule Blokupi.Accounts.UserPaymentMethod do
  alias Blokupi.Accounts.User
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_payment_methods" do
    field :type, :string
    field :bank_name, :string
    field :is_active, :boolean, default: false
    field :account_number, :string
    field :account_name, :string
    field :user_id, :id

    timestamps(type: :utc_datetime)

    belongs_to(:user, User, define_field: false)
  end

  @doc false
  def changeset(user_payment_method, attrs) do
    user_payment_method
    |> cast(attrs, [:bank_name, :is_active, :type, :account_number, :account_name])
    |> validate_required([:bank_name, :is_active, :type, :account_number, :account_name])
  end
end
