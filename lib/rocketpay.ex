defmodule Rocketpay do
  alias Rocketpay.Users.Create, as: CreateUser
  defdelegate create_user(params), to: CreateUser, as: :call

  alias Rocketpay.Accounts.{Deposit, Withdraw, Transaction}
  defdelegate deposit(params), to: Deposit, as: :call
  defdelegate withdraw(params), to: Withdraw, as: :call
  defdelegate transaction(params), to: Transaction, as: :call
end
