defmodule BlokupiWeb.UserStreamKeyLiveTest do
  use BlokupiWeb.ConnCase

  import Phoenix.LiveViewTest
  import Blokupi.FeaturesFixtures

  @create_attrs %{key_name: "some key_name", stream_key: "some stream_key", is_active: true}
  @update_attrs %{key_name: "some updated key_name", stream_key: "some updated stream_key", is_active: false}
  @invalid_attrs %{key_name: nil, stream_key: nil, is_active: false}

  defp create_user_stream_key(_) do
    user_stream_key = user_stream_key_fixture()
    %{user_stream_key: user_stream_key}
  end

  describe "Index" do
    setup [:create_user_stream_key]

    test "lists all user_stream_keys", %{conn: conn, user_stream_key: user_stream_key} do
      {:ok, _index_live, html} = live(conn, ~p"/user_stream_keys")

      assert html =~ "Listing User stream keys"
      assert html =~ user_stream_key.key_name
    end

    test "saves new user_stream_key", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/user_stream_keys")

      assert index_live |> element("a", "New User stream key") |> render_click() =~
               "New User stream key"

      assert_patch(index_live, ~p"/user_stream_keys/new")

      assert index_live
             |> form("#user_stream_key-form", user_stream_key: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_stream_key-form", user_stream_key: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_stream_keys")

      html = render(index_live)
      assert html =~ "User stream key created successfully"
      assert html =~ "some key_name"
    end

    test "updates user_stream_key in listing", %{conn: conn, user_stream_key: user_stream_key} do
      {:ok, index_live, _html} = live(conn, ~p"/user_stream_keys")

      assert index_live |> element("#user_stream_keys-#{user_stream_key.id} a", "Edit") |> render_click() =~
               "Edit User stream key"

      assert_patch(index_live, ~p"/user_stream_keys/#{user_stream_key}/edit")

      assert index_live
             |> form("#user_stream_key-form", user_stream_key: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_stream_key-form", user_stream_key: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_stream_keys")

      html = render(index_live)
      assert html =~ "User stream key updated successfully"
      assert html =~ "some updated key_name"
    end

    test "deletes user_stream_key in listing", %{conn: conn, user_stream_key: user_stream_key} do
      {:ok, index_live, _html} = live(conn, ~p"/user_stream_keys")

      assert index_live |> element("#user_stream_keys-#{user_stream_key.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#user_stream_keys-#{user_stream_key.id}")
    end
  end

  describe "Show" do
    setup [:create_user_stream_key]

    test "displays user_stream_key", %{conn: conn, user_stream_key: user_stream_key} do
      {:ok, _show_live, html} = live(conn, ~p"/user_stream_keys/#{user_stream_key}")

      assert html =~ "Show User stream key"
      assert html =~ user_stream_key.key_name
    end

    test "updates user_stream_key within modal", %{conn: conn, user_stream_key: user_stream_key} do
      {:ok, show_live, _html} = live(conn, ~p"/user_stream_keys/#{user_stream_key}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User stream key"

      assert_patch(show_live, ~p"/user_stream_keys/#{user_stream_key}/show/edit")

      assert show_live
             |> form("#user_stream_key-form", user_stream_key: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#user_stream_key-form", user_stream_key: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/user_stream_keys/#{user_stream_key}")

      html = render(show_live)
      assert html =~ "User stream key updated successfully"
      assert html =~ "some updated key_name"
    end
  end
end
