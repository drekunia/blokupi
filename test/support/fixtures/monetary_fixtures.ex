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

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        amount: 42,
        content: "some content",
        currency: "some currency",
        message: "some message",
        payment_method: "some payment_method",
        recipient_user_id: 42,
        request_details: "some request_details",
        response_details: "some response_details",
        sender_email: "some sender_email",
        sender_name: "some sender_name",
        sender_user_id: 42
      })
      |> Blokupi.Monetary.create_transaction()

    transaction
  end
end
