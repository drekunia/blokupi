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
end
