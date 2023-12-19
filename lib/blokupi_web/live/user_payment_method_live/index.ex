defmodule BlokupiWeb.UserPaymentMethodLive.Index do
  use BlokupiWeb, :live_view

  alias Blokupi.Accounts
  alias Blokupi.Accounts.UserPaymentMethod

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :user_payment_methods, Accounts.list_user_payment_methods())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User payment method")
    |> assign(:user_payment_method, Accounts.get_user_payment_method!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User payment method")
    |> assign(:user_payment_method, %UserPaymentMethod{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing User payment methods")
    |> assign(:user_payment_method, nil)
  end

  @impl true
  def handle_info({BlokupiWeb.UserPaymentMethodLive.FormComponent, {:saved, user_payment_method}}, socket) do
    {:noreply, stream_insert(socket, :user_payment_methods, user_payment_method)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user_payment_method = Accounts.get_user_payment_method!(id)
    {:ok, _} = Accounts.delete_user_payment_method(user_payment_method)

    {:noreply, stream_delete(socket, :user_payment_methods, user_payment_method)}
  end
end
