defmodule Rocketpay.Accounts.Transactions.Response do
  alias Rocketpay.Account

  defstruct [:from, :to]

  def build(%Account{} = from_account, %Account{} = to_account) do
    %__MODULE__{
      from: from_account,
      to: to_account
    }
  end
end
