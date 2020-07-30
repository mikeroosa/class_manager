defmodule ClassManager.CampaignCtxTest do
  use ClassManager.DataCase

  alias ClassManager.CampaignCtx

  describe "campaigns" do
    alias ClassManager.CampaignCtx.Campaign

    @valid_attrs %{body: "some body", subject: "some subject"}
    @update_attrs %{body: "some updated body", subject: "some updated subject"}
    @invalid_attrs %{body: nil, subject: nil}

    def campaign_fixture(attrs \\ %{}) do
      {:ok, campaign} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CampaignCtx.create_campaign()

      campaign
    end

    test "list_campaigns/0 returns all campaigns" do
      campaign = campaign_fixture()
      assert CampaignCtx.list_campaigns() == [campaign]
    end

    test "get_campaign!/1 returns the campaign with given id" do
      campaign = campaign_fixture()
      assert CampaignCtx.get_campaign!(campaign.id) == campaign
    end

    test "create_campaign/1 with valid data creates a campaign" do
      assert {:ok, %Campaign{} = campaign} = CampaignCtx.create_campaign(@valid_attrs)
      assert campaign.body == "some body"
      assert campaign.subject == "some subject"
    end

    test "create_campaign/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CampaignCtx.create_campaign(@invalid_attrs)
    end

    test "update_campaign/2 with valid data updates the campaign" do
      campaign = campaign_fixture()
      assert {:ok, %Campaign{} = campaign} = CampaignCtx.update_campaign(campaign, @update_attrs)
      assert campaign.body == "some updated body"
      assert campaign.subject == "some updated subject"
    end

    test "update_campaign/2 with invalid data returns error changeset" do
      campaign = campaign_fixture()
      assert {:error, %Ecto.Changeset{}} = CampaignCtx.update_campaign(campaign, @invalid_attrs)
      assert campaign == CampaignCtx.get_campaign!(campaign.id)
    end

    test "delete_campaign/1 deletes the campaign" do
      campaign = campaign_fixture()
      assert {:ok, %Campaign{}} = CampaignCtx.delete_campaign(campaign)
      assert_raise Ecto.NoResultsError, fn -> CampaignCtx.get_campaign!(campaign.id) end
    end

    test "change_campaign/1 returns a campaign changeset" do
      campaign = campaign_fixture()
      assert %Ecto.Changeset{} = CampaignCtx.change_campaign(campaign)
    end
  end
end
