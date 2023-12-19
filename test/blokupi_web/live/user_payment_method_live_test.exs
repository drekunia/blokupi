defmodule BlokupiWeb.UserPaymentMethodLiveTest do
  use BlokupiWeb.ConnCase

  import Phoenix.LiveViewTest
  import Blokupi.AccountsFixtures

  @create_attrs %{type: "some type", bank_name: "some bank_name", is_active: true, account_number: "some account_number", account_name: "some account_name"}
  @update_attrs %{type: "some updated type", bank_name: "some updated bank_name", is_active: false, account_number: "some updated account_number", account_name: "some updated account_name"}
  @invalid_attrs %{type: nil, bank_name: nil, is_active: false, account_number: nil, account_name: nil}

  defp create_user_payment_method(_) do
    user_payment_method = user_payment_method_fixture()
    %{user_payment_method: user_payment_method}
  end

  describe "Index" do
    setup [:create_user_payment_method]

    test "lists all user_payment_methods", %{conn: conn, user_payment_method: user_payment_method} do
      {:ok, _index_live, html} = live(conn, ~p"/user_payment_methods")

      assert html =~ "Listing User payment methods"
      assert html =~ user_payment_method.type
    end

    test "saves new user_payment_method", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/user_payment_methods")

      assert index_live |> element("a", "New User payment method") |> render_click() =~
               "New User payment method"

      assert_patch(index_live, ~p"/user_payment_methods/new")

      assert index_live
             |> form("#user_payment_method-form", user_payment_method: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_payment_method-form", user_payment_method: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_payment_methods")

      html = render(index_live)
      assert html =~ "User payment method created successfully"
      assert html =~ "some type"
    end

    test "updates user_payment_method in listing", %{conn: conn, user_payment_method: user_payment_method} do
      {:ok, index_live, _html} = live(conn, ~p"/user_payment_methods")

      assert index_live |> element("#user_payment_methods-#{user_payment_method.id} a", "Edit") |> render_click() =~
               "Edit User payment method"

      assert_patch(index_live, ~p"/user_payment_methods/#{user_payment_method}/edit")

      assert index_live
             |> form("#user_payment_method-form", user_payment_method: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_payment_method-form", user_payment_method: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_payment_methods")

      html = render(index_live)
      assert html =~ "User payment method updated successfully"
      assert html =~ "some updated type"
    end

    test "deletes user_payment_method in listing", %{conn: conn, user_payment_method: user_payment_method} do
      {:ok, index_live, _html} = live(conn, ~p"/user_payment_methods")

      assert index_live |> element("#user_payment_methods-#{user_payment_method.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#user_payment_methods-#{user_payment_method.id}")
    end
  end

  describe "Show" do
    setup [:create_user_payment_method]

    test "displays user_payment_method", %{conn: conn, user_payment_method: user_payment_method} do
      {:ok, _show_live, html} = live(conn, ~p"/user_payment_methods/#{user_payment_method}")

      assert html =~ "Show User payment method"
      assert html =~ user_payment_method.type
    end

    test "updates user_payment_method within modal", %{conn: conn, user_payment_method: user_payment_method} do
      {:ok, show_live, _html} = live(conn, ~p"/user_payment_methods/#{user_payment_method}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User payment method"

      assert_patch(show_live, ~p"/user_payment_methods/#{user_payment_method}/show/edit")

      assert show_live
             |> form("#user_payment_method-form", user_payment_method: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#user_payment_method-form", user_payment_method: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/user_payment_methods/#{user_payment_method}")

      html = render(show_live)
      assert html =~ "User payment method updated successfully"
      assert html =~ "some updated type"
    end
  end
end
