defmodule BlokupiWeb.AlertTemplateLive.FormComponent do
  use BlokupiWeb, :live_component

  alias Blokupi.Features

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage alert_template records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="alert_template-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:is_active]} type="checkbox" label="Is active" />
        <.input field={@form[:is_content_active]} type="checkbox" label="Is content active" />
        <.input field={@form[:is_speech_active]} type="checkbox" label="Is speech active" />
        <.input field={@form[:alert_threshold]} type="number" label="Alert threshold" />
        <.input field={@form[:content_threshold]} type="number" label="Content threshold" />
        <.input field={@form[:speech_threshold]} type="number" label="Speech threshold" />
        <.input field={@form[:alert_sound]} type="text" label="Alert sound" />
        <.input field={@form[:filtered_words]} type="text" label="Filtered words" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Alert template</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{alert_template: alert_template} = assigns, socket) do
    changeset = Features.change_alert_template(alert_template)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"alert_template" => alert_template_params}, socket) do
    changeset =
      socket.assigns.alert_template
      |> Features.change_alert_template(alert_template_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"alert_template" => alert_template_params}, socket) do
    save_alert_template(socket, socket.assigns.action, alert_template_params)
  end

  defp save_alert_template(socket, :edit, alert_template_params) do
    case Features.update_alert_template(socket.assigns.alert_template, alert_template_params) do
      {:ok, alert_template} ->
        notify_parent({:saved, alert_template})

        {:noreply,
         socket
         |> put_flash(:info, "Alert template updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_alert_template(socket, :new, alert_template_params) do
    case Features.create_alert_template(alert_template_params) do
      {:ok, alert_template} ->
        notify_parent({:saved, alert_template})

        {:noreply,
         socket
         |> put_flash(:info, "Alert template created successfully")
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
