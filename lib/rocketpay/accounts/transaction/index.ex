defmodule Rocketpay.Accounts.Transactions.Index do
  import Ecto.Query
  alias Ecto.Multi
  alias Rocketpay.{Repo, Transaction}

  def call() do
    Multi.new()
    |> Multi.run(:transactions, &get_transactions/2)
    |> run_transaction()
  end

  defp get_transactions(repo, _changes) do
    query =
      from(
        transaction in Transaction,
        where: transaction.is_private == false
      )

    transactions =
      repo.all(query)
      |> repo.preload([:account_from, :account_to])

    {:ok, transactions}
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{transactions: transactions}} -> {:ok, transactions}
    end
  end
end
