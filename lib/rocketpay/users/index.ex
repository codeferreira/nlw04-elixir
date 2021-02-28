defmodule Rocketpay.Users.Index do
  import Ecto.Query
  alias Ecto.Multi
  alias Rocketpay.{Repo, User}

  def call() do
    Multi.new()
    |> Multi.run(:users, &get_users/2)
    |> run_transaction()
  end

  defp get_users(repo, _changes) do
    query =
      from(
        a in User,
        where: a.is_private == false
      )

    users = repo.all(query)

    {:ok, users}
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{users: users}} -> {:ok, users}
    end
  end
end
