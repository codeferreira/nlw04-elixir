defmodule RocketpayWeb.FriendControllerTest do
  use RocketpayWeb.ConnCase

  alias Rocketpay.Friendship
  alias Rocketpay.Friendship.Friend

  @create_attrs %{
    friend: "some friend",
    user: "some user"
  }
  @update_attrs %{
    friend: "some updated friend",
    user: "some updated user"
  }
  @invalid_attrs %{friend: nil, user: nil}

  def fixture(:friend) do
    {:ok, friend} = Friendship.create_friend(@create_attrs)
    friend
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all friends", %{conn: conn} do
      conn = get(conn, Routes.friend_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create friend" do
    test "renders friend when data is valid", %{conn: conn} do
      conn = post(conn, Routes.friend_path(conn, :create), friend: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.friend_path(conn, :show, id))

      assert %{
               "id" => id,
               "friend" => "some friend",
               "user" => "some user"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.friend_path(conn, :create), friend: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update friend" do
    setup [:create_friend]

    test "renders friend when data is valid", %{conn: conn, friend: %Friend{id: id} = friend} do
      conn = put(conn, Routes.friend_path(conn, :update, friend), friend: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.friend_path(conn, :show, id))

      assert %{
               "id" => id,
               "friend" => "some updated friend",
               "user" => "some updated user"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, friend: friend} do
      conn = put(conn, Routes.friend_path(conn, :update, friend), friend: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete friend" do
    setup [:create_friend]

    test "deletes chosen friend", %{conn: conn, friend: friend} do
      conn = delete(conn, Routes.friend_path(conn, :delete, friend))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.friend_path(conn, :show, friend))
      end
    end
  end

  defp create_friend(_) do
    friend = fixture(:friend)
    %{friend: friend}
  end
end
