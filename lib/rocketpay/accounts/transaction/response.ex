defmodule Rocketpay.Accounts.Transactions.Response do
  alias Rocketpay.Account

  defstruct [:from, :to, :isPrivate, :value]

  def build(%Account{} = from_account, %Account{} = to_account, value, is_private) do
    %__MODULE__{
      from: from_account,
      to: to_account,
      isPrivate: is_private,
      value: value
    }
  end
end
