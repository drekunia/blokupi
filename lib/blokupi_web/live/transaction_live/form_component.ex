defmodule BlokupiWeb.TransactionLive.FormComponent do
  use BlokupiWeb, :live_component

  alias Blokupi.Monetary

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage transaction records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="transaction-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:amount]} type="number" label="Amount" />
        <.input field={@form[:currency]} type="text" label="Currency" />
        <.input field={@form[:recipient_user_id]} type="number" label="Recipient user" />
        <.input field={@form[:sender_user_id]} type="number" label="Sender user" />
        <.input field={@form[:sender_name]} type="text" label="Sender name" />
        <.input field={@form[:sender_email]} type="text" label="Sender email" />
        <.input field={@form[:message]} type="text" label="Message" />
        <.input field={@form[:content]} type="text" label="Content" />
        <.input field={@form[:payment_method]} type="text" label="Payment method" />
        <.input field={@form[:request_details]} type="text" label="Request details" />
        <.input field={@form[:response_details]} type="text" label="Response details" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Transaction</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{transaction: transaction} = assigns, socket) do
    changeset = Monetary.change_transaction(transaction)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"transaction" => transaction_params}, socket) do
    changeset =
      socket.assigns.transaction
      |> Monetary.change_transaction(transaction_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"transaction" => transaction_params}, socket) do
    save_transaction(socket, socket.assigns.action, transaction_params)
  end

  defp save_transaction(socket, :edit, transaction_params) do
    case Monetary.update_transaction(socket.assigns.transaction, transaction_params) do
      {:ok, transaction} ->
        notify_parent({:saved, transaction})

        {:noreply,
         socket
         |> put_flash(:info, "Transaction updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_transaction(socket, :new, transaction_params) do
    case Monetary.create_transaction(transaction_params) do
      {:ok, transaction} ->
        notify_parent({:saved, transaction})

        {:noreply,
         socket
         |> put_flash(:info, "Transaction created successfully")
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
