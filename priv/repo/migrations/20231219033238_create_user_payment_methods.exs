defmodule Blokupi.Repo.Migrations.CreateUserPaymentMethods do
  use Ecto.Migration

  def change do
    create table(:user_payment_methods) do
      add :user_id, references(:users, on_delete: :nothing)
      add :is_active, :boolean, default: false, null: false
      add :bank_name, :string
      add :account_name, :string
      add :account_number, :string
      add :type, :string

      timestamps(type: :utc_datetime)
    end

    create index(:user_payment_methods, [:user_id])
  end
end
