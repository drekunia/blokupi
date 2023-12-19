defmodule BlokupiWeb.AlertTemplateLive.Index do
  use BlokupiWeb, :live_view

  alias Blokupi.Features
  alias Blokupi.Features.AlertTemplate

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :alert_templates, Features.list_alert_templates())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Alert template")
    |> assign(:alert_template, Features.get_alert_template!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Alert template")
    |> assign(:alert_template, %AlertTemplate{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Alert templates")
    |> assign(:alert_template, nil)
  end

  @impl true
  def handle_info({BlokupiWeb.AlertTemplateLive.FormComponent, {:saved, alert_template}}, socket) do
    {:noreply, stream_insert(socket, :alert_templates, alert_template)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    alert_template = Features.get_alert_template!(id)
    {:ok, _} = Features.delete_alert_template(alert_template)

    {:noreply, stream_delete(socket, :alert_templates, alert_template)}
  end
end
