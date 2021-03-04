defmodule RocketpayWeb.TransactionsController do
  use RocketpayWeb, :controller

  alias Rocketpay.{Transaction}
  alias Rocketpay.Accounts.Transactions.Index, as: TransactionIndex

  action_fallback RocketpayWeb.FallbackController

  def index(conn, _params) do
    with {:ok, [%Transaction{} | _] = transactions} <- TransactionIndex.call() do
      conn
      |> put_status(:ok)
      |> render("index.json", transactions: transactions)
    end
  end
end
