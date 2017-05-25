defmodule JetpackPhoenix.PageController do
  use JetpackPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def oauth_callback(conn, %{ "code" => code}) do
    oauth_response =
      code
      |> build_params
      |> Poison.encode!
      |> request_token

    case oauth_response do
      {:ok, body} ->
        IO.inspect body
        render conn, "index.html"
      {:error, body} ->
        IO.inspect body
        render conn, "index.html"
    end
  end

  defp decodeJSON(body_string) do
     decoded_body = Poison.decode!(body_string)
     IO.inspect decoded_body
     decoded_body
  end

  defp request_token(encoded_params) do
    HTTPoison.start
    response = HTTPoison.post! "https://app.procore.com/oauth/token",
                                encoded_params,
                                [{"Content-Type", "application/json"}]

    case response do
      %HTTPoison.Response{ status_code: 200, body: body } ->
        {:ok, decodeJSON(body)}
      %HTTPoison.Response{ status_code: 401, body: body } ->
        {:error, decodeJSON(body)}
    end
  end

  defp build_params(code) do
    client_id = Application.get_env(:jetpack_phoenix, :client_id)
    client_secret = Application.get_env(:jetpack_phoenix, :client_secret)

    %{
      "grant_type": "authorization_code",
      "code": code,
      "client_id": client_id,
      "client_secret": client_secret,
      "redirect_uri": "http://localhost:4000/oauth_callback",
    }
  end
end
