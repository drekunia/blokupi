defmodule Blokupi.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :amount, :integer
      add :currency, :string
      add :recipient_user_id, :integer
      add :sender_user_id, :integer
      add :sender_name, :string
      add :sender_email, :string
      add :message, :string
      add :content, :string
      add :payment_method, :string
      add :request_details, :string
      add :response_details, :string

      timestamps(type: :utc_datetime)
    end
  end
end
