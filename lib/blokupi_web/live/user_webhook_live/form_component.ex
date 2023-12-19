defmodule BlokupiWeb.UserWebhookLive.FormComponent do
  use BlokupiWeb, :live_component

  alias Blokupi.Features

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage user_webhook records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="user_webhook-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:platform]} type="text" label="Platform" />
        <.input field={@form[:is_active]} type="checkbox" label="Is active" />
        <.input field={@form[:url]} type="text" label="Url" />
        <.input field={@form[:message]} type="text" label="Message" />
        <.input field={@form[:fail_count]} type="number" label="Fail count" />
        <:actions>
          <.button phx-disable-with="Saving...">Save User webhook</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{user_webhook: user_webhook} = assigns, socket) do
    changeset = Features.change_user_webhook(user_webhook)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"user_webhook" => user_webhook_params}, socket) do
    changeset =
      socket.assigns.user_webhook
      |> Features.change_user_webhook(user_webhook_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"user_webhook" => user_webhook_params}, socket) do
    save_user_webhook(socket, socket.assigns.action, user_webhook_params)
  end

  defp save_user_webhook(socket, :edit, user_webhook_params) do
    case Features.update_user_webhook(socket.assigns.user_webhook, user_webhook_params) do
      {:ok, user_webhook} ->
        notify_parent({:saved, user_webhook})

        {:noreply,
         socket
         |> put_flash(:info, "User webhook updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_user_webhook(socket, :new, user_webhook_params) do
    case Features.create_user_webhook(user_webhook_params) do
      {:ok, user_webhook} ->
        notify_parent({:saved, user_webhook})

        {:noreply,
         socket
         |> put_flash(:info, "User webhook created successfully")
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
