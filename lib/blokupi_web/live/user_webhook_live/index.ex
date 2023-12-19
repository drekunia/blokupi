defmodule BlokupiWeb.UserWebhookLive.Index do
  use BlokupiWeb, :live_view

  alias Blokupi.Features
  alias Blokupi.Features.UserWebhook

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :user_webhooks, Features.list_user_webhooks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User webhook")
    |> assign(:user_webhook, Features.get_user_webhook!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User webhook")
    |> assign(:user_webhook, %UserWebhook{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing User webhooks")
    |> assign(:user_webhook, nil)
  end

  @impl true
  def handle_info({BlokupiWeb.UserWebhookLive.FormComponent, {:saved, user_webhook}}, socket) do
    {:noreply, stream_insert(socket, :user_webhooks, user_webhook)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user_webhook = Features.get_user_webhook!(id)
    {:ok, _} = Features.delete_user_webhook(user_webhook)

    {:noreply, stream_delete(socket, :user_webhooks, user_webhook)}
  end
end
