defmodule JetpackPhoenix.Router do
  use JetpackPhoenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", JetpackPhoenix do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/sessions/create", PageController, :redirect_to_auth
    get "/oauth/procore/callback", PageController, :oauth_callback
  end

  scope "/api", JetpackPhoenix do
    pipe_through :api

    get "/:path", ApiController, :proxy_request
  end

  # Other scopes may use custom stacks.
  # scope "/api", JetpackPhoenix do
  #   pipe_through :api
  # end
end
