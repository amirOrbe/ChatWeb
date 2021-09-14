defmodule Chat.SessionTest do
  use Chat.DataCase

  alias Chat.Session

  describe "messages" do
    alias Chat.Session.Message

    @valid_attrs %{name: "some name", text: "some text"}
    @update_attrs %{name: "some updated name", text: "some updated text"}
    @invalid_attrs %{name: nil, text: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Session.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Session.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Session.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = Session.create_message(@valid_attrs)
      assert message.name == "some name"
      assert message.text == "some text"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Session.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, %Message{} = message} = Session.update_message(message, @update_attrs)
      assert message.name == "some updated name"
      assert message.text == "some updated text"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Session.update_message(message, @invalid_attrs)
      assert message == Session.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Session.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Session.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Session.change_message(message)
    end
  end
end
