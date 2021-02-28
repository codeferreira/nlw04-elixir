defmodule Rocketpay.Users.Delete do
  alias Ecto.Multi
  alias Rocketpay.{Repo, User, Account}

  def call(%{id: user_id}) do
    Multi.new()
    |> Multi.run(:deleted_account, fn repo, _changes -> delete_account(repo, user_id) end)
    |> Multi.run(:deleted_user, fn repo, _changes -> delete_user(repo, user_id) end)
    |> run_transaction()
  end

  defp delete_account(repo, user_id) do
    account = repo.get_by(Account, user_id: user_id)

    case repo.delete(account) do
      {:ok, _struct} -> {:ok, %{message: "Account Deleted"}}
      {:error, reason} -> {:error, reason}
    end
  end

  defp delete_user(repo, user_id) do
    user = repo.get!(User, user_id)

    case repo.delete(user) do
      {:ok, _struct} -> {:ok, %{message: "User Deleted"}}
      {:error, reason} -> {:error, reason}
    end
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, _message} -> {:ok}
    end
  end
end
