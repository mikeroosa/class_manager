defmodule ClassManagerWeb.CampaignLive.FormComponent do
  use ClassManagerWeb, :live_component

  alias ClassManager.CampaignCtx

  @impl true
  def update(%{campaign: campaign} = assigns, socket) do
    changeset = CampaignCtx.change_campaign(campaign)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"campaign" => campaign_params}, socket) do
    changeset =
      socket.assigns.campaign
      |> CampaignCtx.change_campaign(campaign_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"campaign" => campaign_params}, socket) do
    save_campaign(socket, socket.assigns.action, campaign_params)
  end

  defp save_campaign(socket, :edit, campaign_params) do
    case CampaignCtx.update_campaign(socket.assigns.campaign, campaign_params) do
      {:ok, _campaign} ->
        {:noreply,
         socket
         |> put_flash(:info, "Campaign updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_campaign(socket, :new, campaign_params) do
    case CampaignCtx.create_campaign(campaign_params) do
      {:ok, _campaign} ->
        {:noreply,
         socket
         |> put_flash(:info, "Campaign created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
