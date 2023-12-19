defmodule BlokupiWeb.UserStreamKeyLive.Index do
  use BlokupiWeb, :live_view

  alias Blokupi.Features
  alias Blokupi.Features.UserStreamKey

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :user_stream_keys, Features.list_user_stream_keys())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User stream key")
    |> assign(:user_stream_key, Features.get_user_stream_key!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User stream key")
    |> assign(:user_stream_key, %UserStreamKey{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing User stream keys")
    |> assign(:user_stream_key, nil)
  end

  @impl true
  def handle_info({BlokupiWeb.UserStreamKeyLive.FormComponent, {:saved, user_stream_key}}, socket) do
    {:noreply, stream_insert(socket, :user_stream_keys, user_stream_key)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user_stream_key = Features.get_user_stream_key!(id)
    {:ok, _} = Features.delete_user_stream_key(user_stream_key)

    {:noreply, stream_delete(socket, :user_stream_keys, user_stream_key)}
  end
end
