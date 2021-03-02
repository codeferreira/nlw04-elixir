defmodule Rocketpay.Accounts.Transaction do
  alias Ecto.Multi

  alias Rocketpay.Accounts.Operation
  alias Rocketpay.{Repo, Transaction}
  alias Rocketpay.Accounts.Transactions.Response, as: TransactionResponse

  def call(%{
        "from" => from_id,
        "to" => to_id,
        "value" => value,
        "is_private" => is_private
      }) do
    withdraw_params = build_params(from_id, value)
    deposit_params = build_params(to_id, value)

    transaction_params = %{
      account_id_from: from_id,
      account_id_to: to_id,
      value: value,
      is_private: is_private
    }

    Multi.new()
    |> Multi.merge(fn _changes -> Operation.call(withdraw_params, :withdraw) end)
    |> Multi.merge(fn _changes -> Operation.call(deposit_params, :deposit) end)
    |> Multi.insert(:create_transaction, Transaction.changeset(transaction_params))
    |> Multi.run(:preload_data, &preload_data/2)
    |> run_transaction()
  end

  defp build_params(id, value), do: %{"id" => id, "value" => value}

  defp preload_data(repo, %{create_transaction: transaction}),
    do: {:ok, repo.preload(transaction, [:account_from, :account_to])}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} ->
        {:error, reason}

      {:ok,
       %{
         preload_data: %Transaction{
           account_from: from_account,
           account_to: to_account,
           is_private: is_private,
           value: value
         }
       }} ->
        {:ok, TransactionResponse.build(from_account, to_account, value, is_private)}
    end
  end
end
