defmodule BlokupiWeb.AlertTemplateLive.Show do
  use BlokupiWeb, :live_view

  alias Blokupi.Features

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:alert_template, Features.get_alert_template!(id))}
  end

  defp page_title(:show), do: "Show Alert template"
  defp page_title(:edit), do: "Edit Alert template"
end
