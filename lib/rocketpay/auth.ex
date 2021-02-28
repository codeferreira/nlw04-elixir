defmodule Rocketpay.Auth do
  import Bcrypt, only: [verify_pass: 2, no_user_verify: 0]
  import Ecto.Query

  alias Rocketpay.{Guardian, Repo, User}

  def token_sign_in(email, password) do
    case email_password_auth(email, password) do
      {:ok, user} ->
        Guardian.encode_and_sign(user)

      _ ->
        {:error, :unauthorized}
    end
  end

  defp email_password_auth(email, password) when is_binary(email) and is_binary(password) do
    with {:ok, user} <- get_by_email(email),
         do: verify_password(password, user)
  end

  defp get_by_email(email) when is_binary(email) do
    query =
      from(
        user in User,
        where: user.email == ^email
      )

    case Repo.one(query) do
      nil ->
        no_user_verify()
        {:error, "Login error."}

      user ->
        {:ok, user}
    end
  end

  defp verify_password(password, %User{} = user) when is_binary(password) do
    if verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end
end
