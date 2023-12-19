defmodule BlokupiWeb.UserBalanceLive.FormComponent do
  use BlokupiWeb, :live_component

  alias Blokupi.Monetary

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage user_balance records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="user_balance-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:total_balance]} type="number" label="Total balance" />
        <.input field={@form[:withdrawable_balance]} type="number" label="Withdrawable balance" />
        <.input field={@form[:accrued_balance]} type="number" label="Accrued balance" />
        <.input field={@form[:currency]} type="text" label="Currency" />
        <.input field={@form[:is_user_active]} type="checkbox" label="Is user active" />
        <:actions>
          <.button phx-disable-with="Saving...">Save User balance</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{user_balance: user_balance} = assigns, socket) do
    changeset = Monetary.change_user_balance(user_balance)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"user_balance" => user_balance_params}, socket) do
    changeset =
      socket.assigns.user_balance
      |> Monetary.change_user_balance(user_balance_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"user_balance" => user_balance_params}, socket) do
    save_user_balance(socket, socket.assigns.action, user_balance_params)
  end

  defp save_user_balance(socket, :edit, user_balance_params) do
    case Monetary.update_user_balance(socket.assigns.user_balance, user_balance_params) do
      {:ok, user_balance} ->
        notify_parent({:saved, user_balance})

        {:noreply,
         socket
         |> put_flash(:info, "User balance updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_user_balance(socket, :new, user_balance_params) do
    case Monetary.create_user_balance(user_balance_params) do
      {:ok, user_balance} ->
        notify_parent({:saved, user_balance})

        {:noreply,
         socket
         |> put_flash(:info, "User balance created successfully")
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
