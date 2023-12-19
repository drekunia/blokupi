defmodule Blokupi.FeaturesTest do
  use Blokupi.DataCase

  alias Blokupi.Features

  describe "user_stream_keys" do
    alias Blokupi.Features.UserStreamKey

    import Blokupi.FeaturesFixtures

    @invalid_attrs %{key_name: nil, stream_key: nil, is_active: nil}

    test "list_user_stream_keys/0 returns all user_stream_keys" do
      user_stream_key = user_stream_key_fixture()
      assert Features.list_user_stream_keys() == [user_stream_key]
    end

    test "get_user_stream_key!/1 returns the user_stream_key with given id" do
      user_stream_key = user_stream_key_fixture()
      assert Features.get_user_stream_key!(user_stream_key.id) == user_stream_key
    end

    test "create_user_stream_key/1 with valid data creates a user_stream_key" do
      valid_attrs = %{key_name: "some key_name", stream_key: "some stream_key", is_active: true}

      assert {:ok, %UserStreamKey{} = user_stream_key} = Features.create_user_stream_key(valid_attrs)
      assert user_stream_key.key_name == "some key_name"
      assert user_stream_key.stream_key == "some stream_key"
      assert user_stream_key.is_active == true
    end

    test "create_user_stream_key/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Features.create_user_stream_key(@invalid_attrs)
    end

    test "update_user_stream_key/2 with valid data updates the user_stream_key" do
      user_stream_key = user_stream_key_fixture()
      update_attrs = %{key_name: "some updated key_name", stream_key: "some updated stream_key", is_active: false}

      assert {:ok, %UserStreamKey{} = user_stream_key} = Features.update_user_stream_key(user_stream_key, update_attrs)
      assert user_stream_key.key_name == "some updated key_name"
      assert user_stream_key.stream_key == "some updated stream_key"
      assert user_stream_key.is_active == false
    end

    test "update_user_stream_key/2 with invalid data returns error changeset" do
      user_stream_key = user_stream_key_fixture()
      assert {:error, %Ecto.Changeset{}} = Features.update_user_stream_key(user_stream_key, @invalid_attrs)
      assert user_stream_key == Features.get_user_stream_key!(user_stream_key.id)
    end

    test "delete_user_stream_key/1 deletes the user_stream_key" do
      user_stream_key = user_stream_key_fixture()
      assert {:ok, %UserStreamKey{}} = Features.delete_user_stream_key(user_stream_key)
      assert_raise Ecto.NoResultsError, fn -> Features.get_user_stream_key!(user_stream_key.id) end
    end

    test "change_user_stream_key/1 returns a user_stream_key changeset" do
      user_stream_key = user_stream_key_fixture()
      assert %Ecto.Changeset{} = Features.change_user_stream_key(user_stream_key)
    end
  end
end
