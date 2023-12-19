defmodule BlokupiWeb.UserPaymentMethodLive.Show do
  use BlokupiWeb, :live_view

  alias Blokupi.Accounts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user_payment_method, Accounts.get_user_payment_method!(id))}
  end

  defp page_title(:show), do: "Show User payment method"
  defp page_title(:edit), do: "Edit User payment method"
end
