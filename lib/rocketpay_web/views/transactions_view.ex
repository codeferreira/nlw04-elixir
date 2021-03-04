defmodule RocketpayWeb.TransactionsView do
  use RocketpayWeb, :view
  alias Rocketpay.{Transaction}
  alias RocketpayWeb.UsersView

  def render("index.json", %{transactions: transactions}) do
    %{data: render_many(transactions, UsersView, "transaction.json", as: :transaction)}
  end

  def render("transaction.json", %Transaction{
        account_from: to_account,
        account_to: from_account,
        value: value
      }) do
    %{
      from: %{
        id: from_account.id
      },
      to: %{
        id: to_account.id
      },
      value: value
    }
  end
end
