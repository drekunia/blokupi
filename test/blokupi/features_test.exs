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

  describe "user_webhooks" do
    alias Blokupi.Features.UserWebhook

    import Blokupi.FeaturesFixtures

    @invalid_attrs %{message: nil, url: nil, platform: nil, is_active: nil, fail_count: nil}

    test "list_user_webhooks/0 returns all user_webhooks" do
      user_webhook = user_webhook_fixture()
      assert Features.list_user_webhooks() == [user_webhook]
    end

    test "get_user_webhook!/1 returns the user_webhook with given id" do
      user_webhook = user_webhook_fixture()
      assert Features.get_user_webhook!(user_webhook.id) == user_webhook
    end

    test "create_user_webhook/1 with valid data creates a user_webhook" do
      valid_attrs = %{message: "some message", url: "some url", platform: "some platform", is_active: true, fail_count: 42}

      assert {:ok, %UserWebhook{} = user_webhook} = Features.create_user_webhook(valid_attrs)
      assert user_webhook.message == "some message"
      assert user_webhook.url == "some url"
      assert user_webhook.platform == "some platform"
      assert user_webhook.is_active == true
      assert user_webhook.fail_count == 42
    end

    test "create_user_webhook/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Features.create_user_webhook(@invalid_attrs)
    end

    test "update_user_webhook/2 with valid data updates the user_webhook" do
      user_webhook = user_webhook_fixture()
      update_attrs = %{message: "some updated message", url: "some updated url", platform: "some updated platform", is_active: false, fail_count: 43}

      assert {:ok, %UserWebhook{} = user_webhook} = Features.update_user_webhook(user_webhook, update_attrs)
      assert user_webhook.message == "some updated message"
      assert user_webhook.url == "some updated url"
      assert user_webhook.platform == "some updated platform"
      assert user_webhook.is_active == false
      assert user_webhook.fail_count == 43
    end

    test "update_user_webhook/2 with invalid data returns error changeset" do
      user_webhook = user_webhook_fixture()
      assert {:error, %Ecto.Changeset{}} = Features.update_user_webhook(user_webhook, @invalid_attrs)
      assert user_webhook == Features.get_user_webhook!(user_webhook.id)
    end

    test "delete_user_webhook/1 deletes the user_webhook" do
      user_webhook = user_webhook_fixture()
      assert {:ok, %UserWebhook{}} = Features.delete_user_webhook(user_webhook)
      assert_raise Ecto.NoResultsError, fn -> Features.get_user_webhook!(user_webhook.id) end
    end

    test "change_user_webhook/1 returns a user_webhook changeset" do
      user_webhook = user_webhook_fixture()
      assert %Ecto.Changeset{} = Features.change_user_webhook(user_webhook)
    end
  end

  describe "alert_templates" do
    alias Blokupi.Features.AlertTemplate

    import Blokupi.FeaturesFixtures

    @invalid_attrs %{is_active: nil, is_content_active: nil, is_speech_active: nil, alert_threshold: nil, content_threshold: nil, speech_threshold: nil, alert_sound: nil, filtered_words: nil}

    test "list_alert_templates/0 returns all alert_templates" do
      alert_template = alert_template_fixture()
      assert Features.list_alert_templates() == [alert_template]
    end

    test "get_alert_template!/1 returns the alert_template with given id" do
      alert_template = alert_template_fixture()
      assert Features.get_alert_template!(alert_template.id) == alert_template
    end

    test "create_alert_template/1 with valid data creates a alert_template" do
      valid_attrs = %{is_active: true, is_content_active: true, is_speech_active: true, alert_threshold: 42, content_threshold: 42, speech_threshold: 42, alert_sound: "some alert_sound", filtered_words: "some filtered_words"}

      assert {:ok, %AlertTemplate{} = alert_template} = Features.create_alert_template(valid_attrs)
      assert alert_template.is_active == true
      assert alert_template.is_content_active == true
      assert alert_template.is_speech_active == true
      assert alert_template.alert_threshold == 42
      assert alert_template.content_threshold == 42
      assert alert_template.speech_threshold == 42
      assert alert_template.alert_sound == "some alert_sound"
      assert alert_template.filtered_words == "some filtered_words"
    end

    test "create_alert_template/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Features.create_alert_template(@invalid_attrs)
    end

    test "update_alert_template/2 with valid data updates the alert_template" do
      alert_template = alert_template_fixture()
      update_attrs = %{is_active: false, is_content_active: false, is_speech_active: false, alert_threshold: 43, content_threshold: 43, speech_threshold: 43, alert_sound: "some updated alert_sound", filtered_words: "some updated filtered_words"}

      assert {:ok, %AlertTemplate{} = alert_template} = Features.update_alert_template(alert_template, update_attrs)
      assert alert_template.is_active == false
      assert alert_template.is_content_active == false
      assert alert_template.is_speech_active == false
      assert alert_template.alert_threshold == 43
      assert alert_template.content_threshold == 43
      assert alert_template.speech_threshold == 43
      assert alert_template.alert_sound == "some updated alert_sound"
      assert alert_template.filtered_words == "some updated filtered_words"
    end

    test "update_alert_template/2 with invalid data returns error changeset" do
      alert_template = alert_template_fixture()
      assert {:error, %Ecto.Changeset{}} = Features.update_alert_template(alert_template, @invalid_attrs)
      assert alert_template == Features.get_alert_template!(alert_template.id)
    end

    test "delete_alert_template/1 deletes the alert_template" do
      alert_template = alert_template_fixture()
      assert {:ok, %AlertTemplate{}} = Features.delete_alert_template(alert_template)
      assert_raise Ecto.NoResultsError, fn -> Features.get_alert_template!(alert_template.id) end
    end

    test "change_alert_template/1 returns a alert_template changeset" do
      alert_template = alert_template_fixture()
      assert %Ecto.Changeset{} = Features.change_alert_template(alert_template)
    end
  end
end
