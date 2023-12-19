defmodule Blokupi.Monetary.Transaction do
  alias Blokupi.Accounts.User
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :message, :string
    field :currency, :string
    field :amount, :integer
    field :recipient_user_id, :integer
    field :sender_user_id, :integer
    field :sender_name, :string
    field :sender_email, :string
    field :content, :string
    field :payment_method, :string
    field :request_details, :string
    field :response_details, :string

    timestamps(type: :utc_datetime)

    belongs_to(:sender, User, foreign_key: :sender_user_id, define_field: false)
    belongs_to(:recipient, User, foreign_key: :recipient_user_id, define_field: false)
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:amount, :currency, :recipient_user_id, :sender_user_id, :sender_name, :sender_email, :message, :content, :payment_method, :request_details, :response_details])
    |> validate_required([:amount, :currency, :recipient_user_id, :sender_user_id, :sender_name, :sender_email, :message, :content, :payment_method, :request_details, :response_details])
  end
end
