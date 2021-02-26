defmodule Rocketpay.Accounts.Transactions.Response do
  alias Rocketpay.Account

  defstruct [:from, :to, :value]

  def build(%Account{} = from_account, %Account{} = to_account, value) do
    %__MODULE__{
      from: from_account,
      to: to_account,
      value: value
    }
  end
end
