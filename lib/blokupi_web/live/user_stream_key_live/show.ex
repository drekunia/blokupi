defmodule BlokupiWeb.UserStreamKeyLive.Show do
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
     |> assign(:user_stream_key, Features.get_user_stream_key!(id))}
  end

  defp page_title(:show), do: "Show User stream key"
  defp page_title(:edit), do: "Edit User stream key"
end
