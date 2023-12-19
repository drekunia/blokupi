defmodule Blokupi.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blokupi.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "HelloTheWorld!"
  def unique_username, do: "john#{System.unique_integer()}"
  def unique_uri, do: "john#{System.unique_integer()}"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      username: unique_username(),
      uri: unique_uri(),
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> Blokupi.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end

  @doc """
  Generate a user_profile.
  """
  def user_profile_fixture(attrs \\ %{}) do
    {:ok, user_profile} =
      attrs
      |> Enum.into(%{
        amount_buttons: "some amount_buttons",
        avatar: "some avatar",
        bio: "some bio",
        display_name: "some display_name",
        urls: "some urls"
      })
      |> Blokupi.Accounts.create_user_profile()

    user_profile
  end
end
