defmodule BlokupiWeb.UserBalanceLive.Show do
  use BlokupiWeb, :live_view

  alias Blokupi.Monetary

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user_balance, Monetary.get_user_balance!(id))}
  end

  defp page_title(:show), do: "Show User balance"
  defp page_title(:edit), do: "Edit User balance"
end
