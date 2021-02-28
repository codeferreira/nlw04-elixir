defmodule RocketpayWeb.UsersView do
  use RocketpayWeb, :view
  alias Rocketpay.{Account, User}
  alias RocketpayWeb.UsersView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UsersView, "user.json", as: :user)}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UsersView, "user.json", as: :user)}
  end

  def render("user.json", %{
        user: %User{
          id: id,
          name: name,
          nickname: nickname
        }
      }) do
    %{id: id, name: name, nickname: nickname}
  end

  def render("create.json", %{
        user: %User{
          id: id,
          name: name,
          nickname: nickname,
          account: %Account{id: account_id, balance: account_balance}
        }
      }) do
    %{
      message: "User created",
      user: %{
        id: id,
        name: name,
        nickname: nickname,
        account: %{
          id: account_id,
          balance: account_balance
        }
      }
    }
  end
end
