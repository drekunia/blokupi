defmodule Blokupi.Repo.Migrations.CreateUserBalances do
  use Ecto.Migration

  def change do
    create table(:user_balances) do
      add :user_id, references(:users, on_delete: :nothing)
      add :total_balance, :integer
      add :withdrawable_balance, :integer
      add :accrued_balance, :integer
      add :currency, :string
      add :is_user_active, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end

    create index(:user_balances, [:user_id])
  end
end
