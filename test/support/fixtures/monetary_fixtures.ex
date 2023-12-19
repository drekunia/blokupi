defmodule Blokupi.MonetaryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blokupi.Monetary` context.
  """

  @doc """
  Generate a user_balance.
  """
  def user_balance_fixture(attrs \\ %{}) do
    {:ok, user_balance} =
      attrs
      |> Enum.into(%{
        accrued_balance: 42,
        currency: "some currency",
        is_user_active: true,
        total_balance: 42,
        withdrawable_balance: 42
      })
      |> Blokupi.Monetary.create_user_balance()

    user_balance
  end
end
