defmodule JetpackPhoenix.PageController do
  use JetpackPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def oauth_callback(conn, %{ "code" => code}) do
    IO.inspect code
    HTTPoison.start


    encoded_params = Poison.encode!(build_params(code))
    IO.inspect(encoded_params)
    response = HTTPoison.post! "https://app.procore.com/oauth/", encoded_params, [{"Content-Type", "application/json"}]
    case response do
      {:ok, %HTTPoison.Response{ status_code: 200, body: body }} ->
        IO.inspect body
    end
    render conn, "index.html"
  end

  defp build_params(code) do
    client_id = System.get_env("PROCORE_CLIENT_ID")
    client_secret = System.get_env("PROCORE_CLIENT_SECRET")
    params = %{
      "grant_type": "authorization_code",
      "code": code,
      "client_id": client_id,
      "client_secret": client_secret,
      "redirect_uri": "http://localhost:4000/oauth_callback",
    }
    params
  end
end
