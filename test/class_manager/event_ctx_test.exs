defmodule ClassManager.EventCtxTest do
  use ClassManager.DataCase

  alias ClassManager.EventCtx

  describe "events" do
    alias ClassManager.EventCtx.Event

    @valid_attrs %{scheduled_for: ~N[2010-04-17 14:00:00], title: "some title"}
    @update_attrs %{scheduled_for: ~N[2011-05-18 15:01:01], title: "some updated title"}
    @invalid_attrs %{scheduled_for: nil, title: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> EventCtx.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert EventCtx.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert EventCtx.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = EventCtx.create_event(@valid_attrs)
      assert event.scheduled_for == ~N[2010-04-17 14:00:00]
      assert event.title == "some title"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = EventCtx.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, %Event{} = event} = EventCtx.update_event(event, @update_attrs)
      assert event.scheduled_for == ~N[2011-05-18 15:01:01]
      assert event.title == "some updated title"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = EventCtx.update_event(event, @invalid_attrs)
      assert event == EventCtx.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = EventCtx.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> EventCtx.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = EventCtx.change_event(event)
    end
  end
end
