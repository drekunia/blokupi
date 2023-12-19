defmodule BlokupiWeb.UserStreamKeyLive.FormComponent do
  use BlokupiWeb, :live_component

  alias Blokupi.Features

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage user_stream_key records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="user_stream_key-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:key_name]} type="text" label="Key name" />
        <.input field={@form[:stream_key]} type="text" label="Stream key" />
        <.input field={@form[:is_active]} type="checkbox" label="Is active" />
        <:actions>
          <.button phx-disable-with="Saving...">Save User stream key</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{user_stream_key: user_stream_key} = assigns, socket) do
    changeset = Features.change_user_stream_key(user_stream_key)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"user_stream_key" => user_stream_key_params}, socket) do
    changeset =
      socket.assigns.user_stream_key
      |> Features.change_user_stream_key(user_stream_key_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"user_stream_key" => user_stream_key_params}, socket) do
    save_user_stream_key(socket, socket.assigns.action, user_stream_key_params)
  end

  defp save_user_stream_key(socket, :edit, user_stream_key_params) do
    case Features.update_user_stream_key(socket.assigns.user_stream_key, user_stream_key_params) do
      {:ok, user_stream_key} ->
        notify_parent({:saved, user_stream_key})

        {:noreply,
         socket
         |> put_flash(:info, "User stream key updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_user_stream_key(socket, :new, user_stream_key_params) do
    case Features.create_user_stream_key(user_stream_key_params) do
      {:ok, user_stream_key} ->
        notify_parent({:saved, user_stream_key})

        {:noreply,
         socket
         |> put_flash(:info, "User stream key created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
