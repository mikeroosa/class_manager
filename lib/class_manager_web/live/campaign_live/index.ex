defmodule ClassManagerWeb.CampaignLive.Index do
  use ClassManagerWeb, :live_view

  alias ClassManager.CampaignCtx
  alias ClassManager.CampaignCtx.Campaign

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :campaigns, list_campaigns())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Campaign")
    |> assign(:campaign, CampaignCtx.get_campaign!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Campaign")
    |> assign(:campaign, %Campaign{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Campaigns")
    |> assign(:campaign, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    campaign = CampaignCtx.get_campaign!(id)
    {:ok, _} = CampaignCtx.delete_campaign(campaign)

    {:noreply, assign(socket, :campaigns, list_campaigns())}
  end

  defp list_campaigns do
    CampaignCtx.list_campaigns()
  end
end
