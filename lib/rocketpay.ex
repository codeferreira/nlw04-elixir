defmodule Rocketpay do
  alias Rocketpay.Users.Create, as: CreateUser
  defdelegate create_user(params), to: CreateUser, as: :call
  alias Rocketpay.Users.Index, as: GetUsers
  defdelegate get_users(), to: GetUsers, as: :call
  alias Rocketpay.Users.Show, as: GetUser
  defdelegate get_user(params), to: GetUser, as: :call
  alias Rocketpay.Users.Delete, as: DeleteUser
  defdelegate delete_user(params), to: DeleteUser, as: :call

  alias Rocketpay.Accounts.{Deposit, Withdraw, Transaction}
  defdelegate deposit(params), to: Deposit, as: :call
  defdelegate withdraw(params), to: Withdraw, as: :call
  defdelegate transaction(params), to: Transaction, as: :call
end
