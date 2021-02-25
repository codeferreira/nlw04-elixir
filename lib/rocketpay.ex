defmodule Rocketpay do
  alias Rocketpay.Users.Create, as: CreateUser
  defdelegate create_user(params), to: CreateUser, as: :call

  alias Rocketpay.Accounts.Deposit
  defdelegate deposit(params), to: Deposit, as: :call
end
