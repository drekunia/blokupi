defmodule BlokupiWeb.UserWebhookLiveTest do
  use BlokupiWeb.ConnCase

  import Phoenix.LiveViewTest
  import Blokupi.FeaturesFixtures

  @create_attrs %{message: "some message", url: "some url", platform: "some platform", is_active: true, fail_count: 42}
  @update_attrs %{message: "some updated message", url: "some updated url", platform: "some updated platform", is_active: false, fail_count: 43}
  @invalid_attrs %{message: nil, url: nil, platform: nil, is_active: false, fail_count: nil}

  defp create_user_webhook(_) do
    user_webhook = user_webhook_fixture()
    %{user_webhook: user_webhook}
  end

  describe "Index" do
    setup [:create_user_webhook]

    test "lists all user_webhooks", %{conn: conn, user_webhook: user_webhook} do
      {:ok, _index_live, html} = live(conn, ~p"/user_webhooks")

      assert html =~ "Listing User webhooks"
      assert html =~ user_webhook.message
    end

    test "saves new user_webhook", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/user_webhooks")

      assert index_live |> element("a", "New User webhook") |> render_click() =~
               "New User webhook"

      assert_patch(index_live, ~p"/user_webhooks/new")

      assert index_live
             |> form("#user_webhook-form", user_webhook: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_webhook-form", user_webhook: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_webhooks")

      html = render(index_live)
      assert html =~ "User webhook created successfully"
      assert html =~ "some message"
    end

    test "updates user_webhook in listing", %{conn: conn, user_webhook: user_webhook} do
      {:ok, index_live, _html} = live(conn, ~p"/user_webhooks")

      assert index_live |> element("#user_webhooks-#{user_webhook.id} a", "Edit") |> render_click() =~
               "Edit User webhook"

      assert_patch(index_live, ~p"/user_webhooks/#{user_webhook}/edit")

      assert index_live
             |> form("#user_webhook-form", user_webhook: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_webhook-form", user_webhook: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_webhooks")

      html = render(index_live)
      assert html =~ "User webhook updated successfully"
      assert html =~ "some updated message"
    end

    test "deletes user_webhook in listing", %{conn: conn, user_webhook: user_webhook} do
      {:ok, index_live, _html} = live(conn, ~p"/user_webhooks")

      assert index_live |> element("#user_webhooks-#{user_webhook.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#user_webhooks-#{user_webhook.id}")
    end
  end

  describe "Show" do
    setup [:create_user_webhook]

    test "displays user_webhook", %{conn: conn, user_webhook: user_webhook} do
      {:ok, _show_live, html} = live(conn, ~p"/user_webhooks/#{user_webhook}")

      assert html =~ "Show User webhook"
      assert html =~ user_webhook.message
    end

    test "updates user_webhook within modal", %{conn: conn, user_webhook: user_webhook} do
      {:ok, show_live, _html} = live(conn, ~p"/user_webhooks/#{user_webhook}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User webhook"

      assert_patch(show_live, ~p"/user_webhooks/#{user_webhook}/show/edit")

      assert show_live
             |> form("#user_webhook-form", user_webhook: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#user_webhook-form", user_webhook: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/user_webhooks/#{user_webhook}")

      html = render(show_live)
      assert html =~ "User webhook updated successfully"
      assert html =~ "some updated message"
    end
  end
end
