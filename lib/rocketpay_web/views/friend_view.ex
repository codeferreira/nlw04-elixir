defmodule RocketpayWeb.FriendView do
  use RocketpayWeb, :view
  alias RocketpayWeb.FriendView
  alias Rocketpay.User
  alias Rocketpay.Friendship.Friend

  def render("index.json", %{friends: friends}) do
    %{data: render_many(friends, FriendView, "friend.json")}
  end

  def render("show.json", %{friend: friend}) do
    %{data: render_one(friend, FriendView, "friend.json")}
  end

  def render("friend.json", %{
        friend: %Friend{
          id: id,
          user: %User{id: user_id, name: user_name, nickname: user_nickname},
          addresse: %User{id: addresse_id, name: addresse_name, nickname: addresse_nickname}
        }
      }) do
    %{
      id: id,
      user: %{
        id: user_id,
        name: user_name,
        nickname: user_nickname
      },
      addresse: %{
        id: addresse_id,
        name: addresse_name,
        nickname: addresse_nickname
      }
    }
  end
end
