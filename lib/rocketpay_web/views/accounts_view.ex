defmodule RocketpayWeb.AccountsView do
  alias Rocketpay.Account
  alias Rocketpay.Accounts.Transactions.Response, as: TransactionResponse

  def render("update.json", %{account: %Account{id: account_id, balance: balance}}) do
    %{
      message: "Balance changed successfully",
      account: %{
        id: account_id,
        balance: balance
      }
    }
  end

  def render("transaction.json", %TransactionResponse{to: to_account, from: from_account}) do
    %{
      message: "Transaction done successfully",
      transaction: %{
        from: %{
          id: from_account.id,
          balance: from_account.balance
        },
        to: %{
          id: to_account.id,
          balance: to_account.balance
        }
      }
    }
  end
end
