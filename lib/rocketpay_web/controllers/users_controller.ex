defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller

  alias Rocketpay.{User, Guardian}

  action_fallback RocketpayWeb.FallbackController

  def index(conn, _params) do
    with {:ok, [%User{} | _] = users} <- Rocketpay.get_users() do
      conn
      |> put_status(:ok)
      |> render("index.json", users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Rocketpay.get_user(%{id: id}) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end

  def show_me(conn, _params) do
    user = Guardian.Plug.current_resource(conn)

    conn
    |> put_status(:ok)
    |> render("show.json", user: user)
  end

  def create(conn, params) do
    with {:ok, %User{} = user} <- Rocketpay.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def delete(conn, _params) do
    user = Guardian.Plug.current_resource(conn)

    with {:ok} <- Rocketpay.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
