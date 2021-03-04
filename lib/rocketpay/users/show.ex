defmodule Rocketpay.Users.Show do
  import Ecto.Query
  alias Ecto.Multi
  alias Rocketpay.{Repo, User}

  def call(%{id: user_id}) do
    Multi.new()
    |> Multi.run(:user, fn repo, _changes -> get_user(repo, user_id) end)
    |> Multi.run(:preload_data, &preload_data/2)
    |> run_transaction()
  end

  defp get_user(repo, user_id) do
    query =
      from(
        users in User,
        where: users.id == ^user_id
      )

    user = repo.one(query)
    {:ok, user}
  end

  defp preload_data(repo, %{user: user}), do: {:ok, repo.preload(user, :account)}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_data: user}} -> {:ok, user}
    end
  end
end
