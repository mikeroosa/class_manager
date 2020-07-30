defmodule ClassManagerWeb.CampaignLiveTest do
  use ClassManagerWeb.ConnCase

  import Phoenix.LiveViewTest

  alias ClassManager.CampaignCtx

  @create_attrs %{body: "some body", subject: "some subject"}
  @update_attrs %{body: "some updated body", subject: "some updated subject"}
  @invalid_attrs %{body: nil, subject: nil}

  defp fixture(:campaign) do
    {:ok, campaign} = CampaignCtx.create_campaign(@create_attrs)
    campaign
  end

  defp create_campaign(_) do
    campaign = fixture(:campaign)
    %{campaign: campaign}
  end

  describe "Index" do
    setup [:create_campaign]

    test "lists all campaigns", %{conn: conn, campaign: campaign} do
      {:ok, _index_live, html} = live(conn, Routes.campaign_index_path(conn, :index))

      assert html =~ "Listing Campaigns"
      assert html =~ campaign.body
    end

    test "saves new campaign", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.campaign_index_path(conn, :index))

      assert index_live |> element("a", "New Campaign") |> render_click() =~
               "New Campaign"

      assert_patch(index_live, Routes.campaign_index_path(conn, :new))

      assert index_live
             |> form("#campaign-form", campaign: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#campaign-form", campaign: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.campaign_index_path(conn, :index))

      assert html =~ "Campaign created successfully"
      assert html =~ "some body"
    end

    test "updates campaign in listing", %{conn: conn, campaign: campaign} do
      {:ok, index_live, _html} = live(conn, Routes.campaign_index_path(conn, :index))

      assert index_live |> element("#campaign-#{campaign.id} a", "Edit") |> render_click() =~
               "Edit Campaign"

      assert_patch(index_live, Routes.campaign_index_path(conn, :edit, campaign))

      assert index_live
             |> form("#campaign-form", campaign: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#campaign-form", campaign: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.campaign_index_path(conn, :index))

      assert html =~ "Campaign updated successfully"
      assert html =~ "some updated body"
    end

    test "deletes campaign in listing", %{conn: conn, campaign: campaign} do
      {:ok, index_live, _html} = live(conn, Routes.campaign_index_path(conn, :index))

      assert index_live |> element("#campaign-#{campaign.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#campaign-#{campaign.id}")
    end
  end

  describe "Show" do
    setup [:create_campaign]

    test "displays campaign", %{conn: conn, campaign: campaign} do
      {:ok, _show_live, html} = live(conn, Routes.campaign_show_path(conn, :show, campaign))

      assert html =~ "Show Campaign"
      assert html =~ campaign.body
    end

    test "updates campaign within modal", %{conn: conn, campaign: campaign} do
      {:ok, show_live, _html} = live(conn, Routes.campaign_show_path(conn, :show, campaign))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Campaign"

      assert_patch(show_live, Routes.campaign_show_path(conn, :edit, campaign))

      assert show_live
             |> form("#campaign-form", campaign: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#campaign-form", campaign: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.campaign_show_path(conn, :show, campaign))

      assert html =~ "Campaign updated successfully"
      assert html =~ "some updated body"
    end
  end
end
