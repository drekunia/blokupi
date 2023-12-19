defmodule Blokupi.MonetaryTest do
  use Blokupi.DataCase

  alias Blokupi.Monetary

  describe "user_balances" do
    alias Blokupi.Monetary.UserBalance

    import Blokupi.MonetaryFixtures

    @invalid_attrs %{currency: nil, total_balance: nil, withdrawable_balance: nil, accrued_balance: nil, is_user_active: nil}

    test "list_user_balances/0 returns all user_balances" do
      user_balance = user_balance_fixture()
      assert Monetary.list_user_balances() == [user_balance]
    end

    test "get_user_balance!/1 returns the user_balance with given id" do
      user_balance = user_balance_fixture()
      assert Monetary.get_user_balance!(user_balance.id) == user_balance
    end

    test "create_user_balance/1 with valid data creates a user_balance" do
      valid_attrs = %{currency: "some currency", total_balance: 42, withdrawable_balance: 42, accrued_balance: 42, is_user_active: true}

      assert {:ok, %UserBalance{} = user_balance} = Monetary.create_user_balance(valid_attrs)
      assert user_balance.currency == "some currency"
      assert user_balance.total_balance == 42
      assert user_balance.withdrawable_balance == 42
      assert user_balance.accrued_balance == 42
      assert user_balance.is_user_active == true
    end

    test "create_user_balance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Monetary.create_user_balance(@invalid_attrs)
    end

    test "update_user_balance/2 with valid data updates the user_balance" do
      user_balance = user_balance_fixture()
      update_attrs = %{currency: "some updated currency", total_balance: 43, withdrawable_balance: 43, accrued_balance: 43, is_user_active: false}

      assert {:ok, %UserBalance{} = user_balance} = Monetary.update_user_balance(user_balance, update_attrs)
      assert user_balance.currency == "some updated currency"
      assert user_balance.total_balance == 43
      assert user_balance.withdrawable_balance == 43
      assert user_balance.accrued_balance == 43
      assert user_balance.is_user_active == false
    end

    test "update_user_balance/2 with invalid data returns error changeset" do
      user_balance = user_balance_fixture()
      assert {:error, %Ecto.Changeset{}} = Monetary.update_user_balance(user_balance, @invalid_attrs)
      assert user_balance == Monetary.get_user_balance!(user_balance.id)
    end

    test "delete_user_balance/1 deletes the user_balance" do
      user_balance = user_balance_fixture()
      assert {:ok, %UserBalance{}} = Monetary.delete_user_balance(user_balance)
      assert_raise Ecto.NoResultsError, fn -> Monetary.get_user_balance!(user_balance.id) end
    end

    test "change_user_balance/1 returns a user_balance changeset" do
      user_balance = user_balance_fixture()
      assert %Ecto.Changeset{} = Monetary.change_user_balance(user_balance)
    end
  end

  describe "transactions" do
    alias Blokupi.Monetary.Transaction

    import Blokupi.MonetaryFixtures

    @invalid_attrs %{message: nil, currency: nil, amount: nil, recipient_user_id: nil, sender_user_id: nil, sender_name: nil, sender_email: nil, content: nil, payment_method: nil, request_details: nil, response_details: nil}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Monetary.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Monetary.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      valid_attrs = %{message: "some message", currency: "some currency", amount: 42, recipient_user_id: 42, sender_user_id: 42, sender_name: "some sender_name", sender_email: "some sender_email", content: "some content", payment_method: "some payment_method", request_details: "some request_details", response_details: "some response_details"}

      assert {:ok, %Transaction{} = transaction} = Monetary.create_transaction(valid_attrs)
      assert transaction.message == "some message"
      assert transaction.currency == "some currency"
      assert transaction.amount == 42
      assert transaction.recipient_user_id == 42
      assert transaction.sender_user_id == 42
      assert transaction.sender_name == "some sender_name"
      assert transaction.sender_email == "some sender_email"
      assert transaction.content == "some content"
      assert transaction.payment_method == "some payment_method"
      assert transaction.request_details == "some request_details"
      assert transaction.response_details == "some response_details"
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Monetary.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      update_attrs = %{message: "some updated message", currency: "some updated currency", amount: 43, recipient_user_id: 43, sender_user_id: 43, sender_name: "some updated sender_name", sender_email: "some updated sender_email", content: "some updated content", payment_method: "some updated payment_method", request_details: "some updated request_details", response_details: "some updated response_details"}

      assert {:ok, %Transaction{} = transaction} = Monetary.update_transaction(transaction, update_attrs)
      assert transaction.message == "some updated message"
      assert transaction.currency == "some updated currency"
      assert transaction.amount == 43
      assert transaction.recipient_user_id == 43
      assert transaction.sender_user_id == 43
      assert transaction.sender_name == "some updated sender_name"
      assert transaction.sender_email == "some updated sender_email"
      assert transaction.content == "some updated content"
      assert transaction.payment_method == "some updated payment_method"
      assert transaction.request_details == "some updated request_details"
      assert transaction.response_details == "some updated response_details"
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Monetary.update_transaction(transaction, @invalid_attrs)
      assert transaction == Monetary.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Monetary.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Monetary.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Monetary.change_transaction(transaction)
    end
  end
end
