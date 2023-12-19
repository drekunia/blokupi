defmodule BlokupiWeb.UserBalanceLiveTest do
  use BlokupiWeb.ConnCase

  import Phoenix.LiveViewTest
  import Blokupi.MonetaryFixtures

  @create_attrs %{currency: "some currency", total_balance: 42, withdrawable_balance: 42, accrued_balance: 42, is_user_active: true}
  @update_attrs %{currency: "some updated currency", total_balance: 43, withdrawable_balance: 43, accrued_balance: 43, is_user_active: false}
  @invalid_attrs %{currency: nil, total_balance: nil, withdrawable_balance: nil, accrued_balance: nil, is_user_active: false}

  defp create_user_balance(_) do
    user_balance = user_balance_fixture()
    %{user_balance: user_balance}
  end

  describe "Index" do
    setup [:create_user_balance]

    test "lists all user_balances", %{conn: conn, user_balance: user_balance} do
      {:ok, _index_live, html} = live(conn, ~p"/user_balances")

      assert html =~ "Listing User balances"
      assert html =~ user_balance.currency
    end

    test "saves new user_balance", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/user_balances")

      assert index_live |> element("a", "New User balance") |> render_click() =~
               "New User balance"

      assert_patch(index_live, ~p"/user_balances/new")

      assert index_live
             |> form("#user_balance-form", user_balance: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_balance-form", user_balance: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_balances")

      html = render(index_live)
      assert html =~ "User balance created successfully"
      assert html =~ "some currency"
    end

    test "updates user_balance in listing", %{conn: conn, user_balance: user_balance} do
      {:ok, index_live, _html} = live(conn, ~p"/user_balances")

      assert index_live |> element("#user_balances-#{user_balance.id} a", "Edit") |> render_click() =~
               "Edit User balance"

      assert_patch(index_live, ~p"/user_balances/#{user_balance}/edit")

      assert index_live
             |> form("#user_balance-form", user_balance: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_balance-form", user_balance: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_balances")

      html = render(index_live)
      assert html =~ "User balance updated successfully"
      assert html =~ "some updated currency"
    end

    test "deletes user_balance in listing", %{conn: conn, user_balance: user_balance} do
      {:ok, index_live, _html} = live(conn, ~p"/user_balances")

      assert index_live |> element("#user_balances-#{user_balance.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#user_balances-#{user_balance.id}")
    end
  end

  describe "Show" do
    setup [:create_user_balance]

    test "displays user_balance", %{conn: conn, user_balance: user_balance} do
      {:ok, _show_live, html} = live(conn, ~p"/user_balances/#{user_balance}")

      assert html =~ "Show User balance"
      assert html =~ user_balance.currency
    end

    test "updates user_balance within modal", %{conn: conn, user_balance: user_balance} do
      {:ok, show_live, _html} = live(conn, ~p"/user_balances/#{user_balance}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User balance"

      assert_patch(show_live, ~p"/user_balances/#{user_balance}/show/edit")

      assert show_live
             |> form("#user_balance-form", user_balance: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#user_balance-form", user_balance: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/user_balances/#{user_balance}")

      html = render(show_live)
      assert html =~ "User balance updated successfully"
      assert html =~ "some updated currency"
    end
  end
end
