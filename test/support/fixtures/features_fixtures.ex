defmodule Blokupi.FeaturesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blokupi.Features` context.
  """

  @doc """
  Generate a user_stream_key.
  """
  def user_stream_key_fixture(attrs \\ %{}) do
    {:ok, user_stream_key} =
      attrs
      |> Enum.into(%{
        is_active: true,
        key_name: "some key_name",
        stream_key: "some stream_key"
      })
      |> Blokupi.Features.create_user_stream_key()

    user_stream_key
  end

  @doc """
  Generate a user_webhook.
  """
  def user_webhook_fixture(attrs \\ %{}) do
    {:ok, user_webhook} =
      attrs
      |> Enum.into(%{
        fail_count: 42,
        is_active: true,
        message: "some message",
        platform: "some platform",
        url: "some url"
      })
      |> Blokupi.Features.create_user_webhook()

    user_webhook
  end

  @doc """
  Generate a alert_template.
  """
  def alert_template_fixture(attrs \\ %{}) do
    {:ok, alert_template} =
      attrs
      |> Enum.into(%{
        alert_sound: "some alert_sound",
        alert_threshold: 42,
        content_threshold: 42,
        filtered_words: "some filtered_words",
        is_active: true,
        is_content_active: true,
        is_speech_active: true,
        speech_threshold: 42
      })
      |> Blokupi.Features.create_alert_template()

    alert_template
  end
end
