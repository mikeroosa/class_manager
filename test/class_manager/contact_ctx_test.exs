defmodule ClassManager.ContactCtxTest do
  use ClassManager.DataCase

  alias ClassManager.ContactCtx

  describe "contacts" do
    alias ClassManager.ContactCtx.Contact

    @valid_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name"}
    @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name"}
    @invalid_attrs %{email: nil, first_name: nil, last_name: nil}

    def contact_fixture(attrs \\ %{}) do
      {:ok, contact} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ContactCtx.create_contact()

      contact
    end

    test "list_contacts/0 returns all contacts" do
      contact = contact_fixture()
      assert ContactCtx.list_contacts() == [contact]
    end

    test "get_contact!/1 returns the contact with given id" do
      contact = contact_fixture()
      assert ContactCtx.get_contact!(contact.id) == contact
    end

    test "create_contact/1 with valid data creates a contact" do
      assert {:ok, %Contact{} = contact} = ContactCtx.create_contact(@valid_attrs)
      assert contact.email == "some email"
      assert contact.first_name == "some first_name"
      assert contact.last_name == "some last_name"
    end

    test "create_contact/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ContactCtx.create_contact(@invalid_attrs)
    end

    test "update_contact/2 with valid data updates the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{} = contact} = ContactCtx.update_contact(contact, @update_attrs)
      assert contact.email == "some updated email"
      assert contact.first_name == "some updated first_name"
      assert contact.last_name == "some updated last_name"
    end

    test "update_contact/2 with invalid data returns error changeset" do
      contact = contact_fixture()
      assert {:error, %Ecto.Changeset{}} = ContactCtx.update_contact(contact, @invalid_attrs)
      assert contact == ContactCtx.get_contact!(contact.id)
    end

    test "delete_contact/1 deletes the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{}} = ContactCtx.delete_contact(contact)
      assert_raise Ecto.NoResultsError, fn -> ContactCtx.get_contact!(contact.id) end
    end

    test "change_contact/1 returns a contact changeset" do
      contact = contact_fixture()
      assert %Ecto.Changeset{} = ContactCtx.change_contact(contact)
    end
  end
end
