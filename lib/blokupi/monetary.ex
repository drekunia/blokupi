defmodule Blokupi.Monetary do
  @moduledoc """
  The Monetary context.
  """

  import Ecto.Query, warn: false
  alias Blokupi.Repo

  alias Blokupi.Monetary.UserBalance

  @doc """
  Returns the list of user_balances.

  ## Examples

      iex> list_user_balances()
      [%UserBalance{}, ...]

  """
  def list_user_balances do
    Repo.all(UserBalance)
  end

  @doc """
  Gets a single user_balance.

  Raises `Ecto.NoResultsError` if the User balance does not exist.

  ## Examples

      iex> get_user_balance!(123)
      %UserBalance{}

      iex> get_user_balance!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_balance!(id), do: Repo.get!(UserBalance, id)

  @doc """
  Creates a user_balance.

  ## Examples

      iex> create_user_balance(%{field: value})
      {:ok, %UserBalance{}}

      iex> create_user_balance(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_balance(attrs \\ %{}) do
    %UserBalance{}
    |> UserBalance.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_balance.

  ## Examples

      iex> update_user_balance(user_balance, %{field: new_value})
      {:ok, %UserBalance{}}

      iex> update_user_balance(user_balance, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_balance(%UserBalance{} = user_balance, attrs) do
    user_balance
    |> UserBalance.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_balance.

  ## Examples

      iex> delete_user_balance(user_balance)
      {:ok, %UserBalance{}}

      iex> delete_user_balance(user_balance)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_balance(%UserBalance{} = user_balance) do
    Repo.delete(user_balance)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_balance changes.

  ## Examples

      iex> change_user_balance(user_balance)
      %Ecto.Changeset{data: %UserBalance{}}

  """
  def change_user_balance(%UserBalance{} = user_balance, attrs \\ %{}) do
    UserBalance.changeset(user_balance, attrs)
  end

  alias Blokupi.Monetary.Transaction

  @doc """
  Returns the list of transactions.

  ## Examples

      iex> list_transactions()
      [%Transaction{}, ...]

  """
  def list_transactions do
    Repo.all(Transaction)
  end

  @doc """
  Gets a single transaction.

  Raises `Ecto.NoResultsError` if the Transaction does not exist.

  ## Examples

      iex> get_transaction!(123)
      %Transaction{}

      iex> get_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transaction!(id), do: Repo.get!(Transaction, id)

  @doc """
  Creates a transaction.

  ## Examples

      iex> create_transaction(%{field: value})
      {:ok, %Transaction{}}

      iex> create_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transaction.

  ## Examples

      iex> update_transaction(transaction, %{field: new_value})
      {:ok, %Transaction{}}

      iex> update_transaction(transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transaction.

  ## Examples

      iex> delete_transaction(transaction)
      {:ok, %Transaction{}}

      iex> delete_transaction(transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transaction changes.

  ## Examples

      iex> change_transaction(transaction)
      %Ecto.Changeset{data: %Transaction{}}

  """
  def change_transaction(%Transaction{} = transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end
end
