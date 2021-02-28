defmodule Rocketpay.Friendship do
  import Ecto.Query, warn: false
  alias Ecto.{Multi}

  alias Rocketpay.Repo

  alias Rocketpay.Friendship.Friend

  def list_friends(user) do
    Multi.new()
    |> Multi.run(:user_friends_list, fn repo, _changes -> get_user_friends(repo, user) end)
    |> Multi.run(:friends, &load_friends/2)
    |> run_transaction()
  end

  defp get_user_friends(repo, user) do
    user_with_friends = repo.preload(user, :friends)

    {:ok, %{friends: user_with_friends.friends, user_id: user.id}}
  end

  defp load_friends(repo, %{user_friends_list: %{friends: friends, user_id: user_id}}) do
    friend_ids =
      Enum.map(
        friends,
        fn friend ->
          case friend.user_id == user_id do
            true -> friend.addresse_id
            _ -> friend.user_id
          end
        end
      )

    friends_query =
      from(
        friend in Friend,
        preload: [:user],
        where: friend.id in ^friend_ids,
        select: friend
      )

    {:ok, repo.all(friends_query)}
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{friends: friends}} -> {:ok, friends}
    end
  end

  def create_friend(attrs \\ %{}) do
    %Friend{}
    |> Friend.changeset(attrs)
    |> Repo.insert()
  end

  def update_friend(%Friend{} = friend, attrs) do
    friend
    |> Friend.changeset(attrs)
    |> Repo.update()
  end

  def delete_friend(%Friend{} = friend) do
    Repo.delete(friend)
  end

  def change_friend(%Friend{} = friend, attrs \\ %{}) do
    Friend.changeset(friend, attrs)
  end
end
