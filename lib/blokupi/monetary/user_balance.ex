defmodule Blokupi.Monetary.UserBalance do
  alias Blokupi.Accounts.User
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_balances" do
    field :currency, :string
    field :total_balance, :integer
    field :withdrawable_balance, :integer
    field :accrued_balance, :integer
    field :is_user_active, :boolean, default: false
    field :user_id, :id

    timestamps(type: :utc_datetime)

    belongs_to(:user, User, define_field: false)
  end

  @doc false
  def changeset(user_balance, attrs) do
    user_balance
    |> cast(attrs, [:total_balance, :withdrawable_balance, :accrued_balance, :currency, :is_user_active])
    |> validate_required([:total_balance, :withdrawable_balance, :accrued_balance, :currency, :is_user_active])
  end
end
