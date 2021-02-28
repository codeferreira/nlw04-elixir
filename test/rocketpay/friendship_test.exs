defmodule Rocketpay.FriendshipTest do
  use Rocketpay.DataCase

  alias Rocketpay.Friendship

  describe "friends" do
    alias Rocketpay.Friendship.Friend

    @valid_attrs %{friend: "some friend", user: "some user"}
    @update_attrs %{friend: "some updated friend", user: "some updated user"}
    @invalid_attrs %{friend: nil, user: nil}

    def friend_fixture(attrs \\ %{}) do
      {:ok, friend} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Friendship.create_friend()

      friend
    end

    test "list_friends/0 returns all friends" do
      friend = friend_fixture()
      assert Friendship.list_friends() == [friend]
    end

    test "get_friend!/1 returns the friend with given id" do
      friend = friend_fixture()
      assert Friendship.get_friend!(friend.id) == friend
    end

    test "create_friend/1 with valid data creates a friend" do
      assert {:ok, %Friend{} = friend} = Friendship.create_friend(@valid_attrs)
      assert friend.friend == "some friend"
      assert friend.user == "some user"
    end

    test "create_friend/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Friendship.create_friend(@invalid_attrs)
    end

    test "update_friend/2 with valid data updates the friend" do
      friend = friend_fixture()
      assert {:ok, %Friend{} = friend} = Friendship.update_friend(friend, @update_attrs)
      assert friend.friend == "some updated friend"
      assert friend.user == "some updated user"
    end

    test "update_friend/2 with invalid data returns error changeset" do
      friend = friend_fixture()
      assert {:error, %Ecto.Changeset{}} = Friendship.update_friend(friend, @invalid_attrs)
      assert friend == Friendship.get_friend!(friend.id)
    end

    test "delete_friend/1 deletes the friend" do
      friend = friend_fixture()
      assert {:ok, %Friend{}} = Friendship.delete_friend(friend)
      assert_raise Ecto.NoResultsError, fn -> Friendship.get_friend!(friend.id) end
    end

    test "change_friend/1 returns a friend changeset" do
      friend = friend_fixture()
      assert %Ecto.Changeset{} = Friendship.change_friend(friend)
    end
  end
end
