defmodule RocketpayWeb.AuthController do
  use RocketpayWeb, :controller

  alias Rocketpay.{Auth}

  action_fallback RocketpayWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    case Auth.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn |> render("auth.json", token: token)

      _ ->
        {:error, :unauthorized}
    end
  end
end
