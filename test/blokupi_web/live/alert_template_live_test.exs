defmodule BlokupiWeb.AlertTemplateLiveTest do
  use BlokupiWeb.ConnCase

  import Phoenix.LiveViewTest
  import Blokupi.FeaturesFixtures

  @create_attrs %{is_active: true, is_content_active: true, is_speech_active: true, alert_threshold: 42, content_threshold: 42, speech_threshold: 42, alert_sound: "some alert_sound", filtered_words: "some filtered_words"}
  @update_attrs %{is_active: false, is_content_active: false, is_speech_active: false, alert_threshold: 43, content_threshold: 43, speech_threshold: 43, alert_sound: "some updated alert_sound", filtered_words: "some updated filtered_words"}
  @invalid_attrs %{is_active: false, is_content_active: false, is_speech_active: false, alert_threshold: nil, content_threshold: nil, speech_threshold: nil, alert_sound: nil, filtered_words: nil}

  defp create_alert_template(_) do
    alert_template = alert_template_fixture()
    %{alert_template: alert_template}
  end

  describe "Index" do
    setup [:create_alert_template]

    test "lists all alert_templates", %{conn: conn, alert_template: alert_template} do
      {:ok, _index_live, html} = live(conn, ~p"/alert_templates")

      assert html =~ "Listing Alert templates"
      assert html =~ alert_template.alert_sound
    end

    test "saves new alert_template", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/alert_templates")

      assert index_live |> element("a", "New Alert template") |> render_click() =~
               "New Alert template"

      assert_patch(index_live, ~p"/alert_templates/new")

      assert index_live
             |> form("#alert_template-form", alert_template: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#alert_template-form", alert_template: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/alert_templates")

      html = render(index_live)
      assert html =~ "Alert template created successfully"
      assert html =~ "some alert_sound"
    end

    test "updates alert_template in listing", %{conn: conn, alert_template: alert_template} do
      {:ok, index_live, _html} = live(conn, ~p"/alert_templates")

      assert index_live |> element("#alert_templates-#{alert_template.id} a", "Edit") |> render_click() =~
               "Edit Alert template"

      assert_patch(index_live, ~p"/alert_templates/#{alert_template}/edit")

      assert index_live
             |> form("#alert_template-form", alert_template: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#alert_template-form", alert_template: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/alert_templates")

      html = render(index_live)
      assert html =~ "Alert template updated successfully"
      assert html =~ "some updated alert_sound"
    end

    test "deletes alert_template in listing", %{conn: conn, alert_template: alert_template} do
      {:ok, index_live, _html} = live(conn, ~p"/alert_templates")

      assert index_live |> element("#alert_templates-#{alert_template.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#alert_templates-#{alert_template.id}")
    end
  end

  describe "Show" do
    setup [:create_alert_template]

    test "displays alert_template", %{conn: conn, alert_template: alert_template} do
      {:ok, _show_live, html} = live(conn, ~p"/alert_templates/#{alert_template}")

      assert html =~ "Show Alert template"
      assert html =~ alert_template.alert_sound
    end

    test "updates alert_template within modal", %{conn: conn, alert_template: alert_template} do
      {:ok, show_live, _html} = live(conn, ~p"/alert_templates/#{alert_template}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Alert template"

      assert_patch(show_live, ~p"/alert_templates/#{alert_template}/show/edit")

      assert show_live
             |> form("#alert_template-form", alert_template: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#alert_template-form", alert_template: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/alert_templates/#{alert_template}")

      html = render(show_live)
      assert html =~ "Alert template updated successfully"
      assert html =~ "some updated alert_sound"
    end
  end
end
