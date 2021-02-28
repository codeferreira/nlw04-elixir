defmodule Rocketpay.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :rocketpay,
    module: Rocketpay.Guardian,
    error_handler: Rocketpay.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
