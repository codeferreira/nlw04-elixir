defmodule Rocketpay.Guardian do
  use Guardian, otp_app: :rocketpay

  alias Rocketpay.User

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]

    with {:ok, %User{} = resource} <- Rocketpay.get_user(%{id: id}) do
      {:ok, resource}
    end
  end
end
