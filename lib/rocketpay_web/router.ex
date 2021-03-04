defmodule RocketpayWeb.Router do
  use RocketpayWeb, :router

  alias Rocketpay.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/api", RocketpayWeb do
    pipe_through :api

    post "/auth/signup", UsersController, :create
    post "/auth/signin", AuthController, :create
  end

  scope "/api", RocketpayWeb do
    pipe_through [:api, :jwt_authenticated]

    get "/users", UsersController, :index
    get "/users/:id", UsersController, :show

    get "/me", UsersController, :show_me
    delete "/me", UsersController, :delete

    get "/friendship", FriendController, :index
    post "/friendship", FriendController, :create

    get "/accounts/transactions", TransactionsController, :index

    post "/accounts/:id/deposit", AccountsController, :deposit
    post "/accounts/:id/withdraw", AccountsController, :withdraw
    post "/accounts/transaction", AccountsController, :transaction
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: RocketpayWeb.Telemetry
    end
  end
end
