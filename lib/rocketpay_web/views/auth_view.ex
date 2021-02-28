defmodule RocketpayWeb.AuthView do
  def render("auth.json", %{token: token}) do
    %{token: token}
  end
end
