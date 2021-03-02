defmodule RocketpayWeb.FriendController do
  use RocketpayWeb, :controller

  alias Rocketpay.{Friendship, Guardian}
  alias Rocketpay.Friendship.Friend

  action_fallback RocketpayWeb.FallbackController

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)

    with {:ok, [%Friend{}] = friends} <- Friendship.list_friends(user) do
      conn
      |> put_status(:ok)
      |> render("index.json", friends: friends)
    end
  end

  def create(conn, %{"friendship" => friend_params}) do
    with {:ok, %Friend{} = friend} <- Friendship.create_friend(friend_params) do
      conn
      |> put_status(:created)
      |> render("show.json", friend: friend)
    end
  end

  def show(conn, %{"id" => id}) do
    friend = Friendship.get_friend!(id)
    render(conn, "show.json", friend: friend)
  end

  def update(conn, %{"id" => id, "friend" => friend_params}) do
    friend = Friendship.get_friend!(id)

    with {:ok, %Friend{} = friend} <- Friendship.update_friend(friend, friend_params) do
      render(conn, "show.json", friend: friend)
    end
  end

  def delete(conn, %{"id" => id}) do
    friend = Friendship.get_friend!(id)

    with {:ok, %Friend{}} <- Friendship.delete_friend(friend) do
      send_resp(conn, :no_content, "")
    end
  end
end
