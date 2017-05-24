defmodule JetpackPhoenix.PageController do
  use JetpackPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def oauth_callback(conn, %{ "code" => code}) do
    IO.inspect code
    HTTPoison.start
    params = %{
      "grant_type": "authorization_code",
      "code": code,
      "client_id": "GET_FROM_ENV",
      "client_secret": "GET_FROM_ENV",
      "redirect_uri": "http://localhost:4000/oauth_callback",
    }

    encoded_params = Poison.encode!(params)
    IO.inspect(encoded_params)
    response = HTTPoison.post! "https://app.procore.com/oauth/", encoded_params, [{"Content-Type", "application/json"}]
    case response do
      {:ok, %HTTPoison.Response{ status_code: 200, body: body }} ->
        IO.inspect body
    end
    render conn, "index.html"
  end
end
