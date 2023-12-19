defmodule BlokupiWeb.UserProfileLiveTest do
  use BlokupiWeb.ConnCase

  import Phoenix.LiveViewTest
  import Blokupi.AccountsFixtures

  @create_attrs %{display_name: "some display_name", avatar: "some avatar", bio: "some bio", urls: "some urls", amount_buttons: "some amount_buttons"}
  @update_attrs %{display_name: "some updated display_name", avatar: "some updated avatar", bio: "some updated bio", urls: "some updated urls", amount_buttons: "some updated amount_buttons"}
  @invalid_attrs %{display_name: nil, avatar: nil, bio: nil, urls: nil, amount_buttons: nil}

  defp create_user_profile(_) do
    user_profile = user_profile_fixture()
    %{user_profile: user_profile}
  end

  describe "Index" do
    setup [:create_user_profile]

    test "lists all user_profiles", %{conn: conn, user_profile: user_profile} do
      {:ok, _index_live, html} = live(conn, ~p"/user_profiles")

      assert html =~ "Listing User profiles"
      assert html =~ user_profile.display_name
    end

    test "saves new user_profile", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/user_profiles")

      assert index_live |> element("a", "New User profile") |> render_click() =~
               "New User profile"

      assert_patch(index_live, ~p"/user_profiles/new")

      assert index_live
             |> form("#user_profile-form", user_profile: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_profile-form", user_profile: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_profiles")

      html = render(index_live)
      assert html =~ "User profile created successfully"
      assert html =~ "some display_name"
    end

    test "updates user_profile in listing", %{conn: conn, user_profile: user_profile} do
      {:ok, index_live, _html} = live(conn, ~p"/user_profiles")

      assert index_live |> element("#user_profiles-#{user_profile.id} a", "Edit") |> render_click() =~
               "Edit User profile"

      assert_patch(index_live, ~p"/user_profiles/#{user_profile}/edit")

      assert index_live
             |> form("#user_profile-form", user_profile: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_profile-form", user_profile: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_profiles")

      html = render(index_live)
      assert html =~ "User profile updated successfully"
      assert html =~ "some updated display_name"
    end

    test "deletes user_profile in listing", %{conn: conn, user_profile: user_profile} do
      {:ok, index_live, _html} = live(conn, ~p"/user_profiles")

      assert index_live |> element("#user_profiles-#{user_profile.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#user_profiles-#{user_profile.id}")
    end
  end

  describe "Show" do
    setup [:create_user_profile]

    test "displays user_profile", %{conn: conn, user_profile: user_profile} do
      {:ok, _show_live, html} = live(conn, ~p"/user_profiles/#{user_profile}")

      assert html =~ "Show User profile"
      assert html =~ user_profile.display_name
    end

    test "updates user_profile within modal", %{conn: conn, user_profile: user_profile} do
      {:ok, show_live, _html} = live(conn, ~p"/user_profiles/#{user_profile}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User profile"

      assert_patch(show_live, ~p"/user_profiles/#{user_profile}/show/edit")

      assert show_live
             |> form("#user_profile-form", user_profile: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#user_profile-form", user_profile: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/user_profiles/#{user_profile}")

      html = render(show_live)
      assert html =~ "User profile updated successfully"
      assert html =~ "some updated display_name"
    end
  end
end
