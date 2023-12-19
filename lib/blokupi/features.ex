defmodule Blokupi.Features do
  @moduledoc """
  The Features context.
  """

  import Ecto.Query, warn: false
  alias Blokupi.Repo

  alias Blokupi.Features.UserStreamKey

  @doc """
  Returns the list of user_stream_keys.

  ## Examples

      iex> list_user_stream_keys()
      [%UserStreamKey{}, ...]

  """
  def list_user_stream_keys do
    Repo.all(UserStreamKey)
  end

  @doc """
  Gets a single user_stream_key.

  Raises `Ecto.NoResultsError` if the User stream key does not exist.

  ## Examples

      iex> get_user_stream_key!(123)
      %UserStreamKey{}

      iex> get_user_stream_key!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_stream_key!(id), do: Repo.get!(UserStreamKey, id)

  @doc """
  Creates a user_stream_key.

  ## Examples

      iex> create_user_stream_key(%{field: value})
      {:ok, %UserStreamKey{}}

      iex> create_user_stream_key(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_stream_key(attrs \\ %{}) do
    %UserStreamKey{}
    |> UserStreamKey.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_stream_key.

  ## Examples

      iex> update_user_stream_key(user_stream_key, %{field: new_value})
      {:ok, %UserStreamKey{}}

      iex> update_user_stream_key(user_stream_key, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_stream_key(%UserStreamKey{} = user_stream_key, attrs) do
    user_stream_key
    |> UserStreamKey.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_stream_key.

  ## Examples

      iex> delete_user_stream_key(user_stream_key)
      {:ok, %UserStreamKey{}}

      iex> delete_user_stream_key(user_stream_key)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_stream_key(%UserStreamKey{} = user_stream_key) do
    Repo.delete(user_stream_key)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_stream_key changes.

  ## Examples

      iex> change_user_stream_key(user_stream_key)
      %Ecto.Changeset{data: %UserStreamKey{}}

  """
  def change_user_stream_key(%UserStreamKey{} = user_stream_key, attrs \\ %{}) do
    UserStreamKey.changeset(user_stream_key, attrs)
  end

  alias Blokupi.Features.UserWebhook

  @doc """
  Returns the list of user_webhooks.

  ## Examples

      iex> list_user_webhooks()
      [%UserWebhook{}, ...]

  """
  def list_user_webhooks do
    Repo.all(UserWebhook)
  end

  @doc """
  Gets a single user_webhook.

  Raises `Ecto.NoResultsError` if the User webhook does not exist.

  ## Examples

      iex> get_user_webhook!(123)
      %UserWebhook{}

      iex> get_user_webhook!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_webhook!(id), do: Repo.get!(UserWebhook, id)

  @doc """
  Creates a user_webhook.

  ## Examples

      iex> create_user_webhook(%{field: value})
      {:ok, %UserWebhook{}}

      iex> create_user_webhook(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_webhook(attrs \\ %{}) do
    %UserWebhook{}
    |> UserWebhook.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_webhook.

  ## Examples

      iex> update_user_webhook(user_webhook, %{field: new_value})
      {:ok, %UserWebhook{}}

      iex> update_user_webhook(user_webhook, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_webhook(%UserWebhook{} = user_webhook, attrs) do
    user_webhook
    |> UserWebhook.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_webhook.

  ## Examples

      iex> delete_user_webhook(user_webhook)
      {:ok, %UserWebhook{}}

      iex> delete_user_webhook(user_webhook)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_webhook(%UserWebhook{} = user_webhook) do
    Repo.delete(user_webhook)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_webhook changes.

  ## Examples

      iex> change_user_webhook(user_webhook)
      %Ecto.Changeset{data: %UserWebhook{}}

  """
  def change_user_webhook(%UserWebhook{} = user_webhook, attrs \\ %{}) do
    UserWebhook.changeset(user_webhook, attrs)
  end
end
