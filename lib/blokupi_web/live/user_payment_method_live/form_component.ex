defmodule BlokupiWeb.UserPaymentMethodLive.FormComponent do
  use BlokupiWeb, :live_component

  alias Blokupi.Accounts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage user_payment_method records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="user_payment_method-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:bank_name]} type="text" label="Bank name" />
        <.input field={@form[:is_active]} type="checkbox" label="Is active" />
        <.input field={@form[:type]} type="text" label="Type" />
        <.input field={@form[:account_number]} type="text" label="Account number" />
        <.input field={@form[:account_name]} type="text" label="Account name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save User payment method</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{user_payment_method: user_payment_method} = assigns, socket) do
    changeset = Accounts.change_user_payment_method(user_payment_method)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"user_payment_method" => user_payment_method_params}, socket) do
    changeset =
      socket.assigns.user_payment_method
      |> Accounts.change_user_payment_method(user_payment_method_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"user_payment_method" => user_payment_method_params}, socket) do
    save_user_payment_method(socket, socket.assigns.action, user_payment_method_params)
  end

  defp save_user_payment_method(socket, :edit, user_payment_method_params) do
    case Accounts.update_user_payment_method(socket.assigns.user_payment_method, user_payment_method_params) do
      {:ok, user_payment_method} ->
        notify_parent({:saved, user_payment_method})

        {:noreply,
         socket
         |> put_flash(:info, "User payment method updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_user_payment_method(socket, :new, user_payment_method_params) do
    case Accounts.create_user_payment_method(user_payment_method_params) do
      {:ok, user_payment_method} ->
        notify_parent({:saved, user_payment_method})

        {:noreply,
         socket
         |> put_flash(:info, "User payment method created successfully")
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
