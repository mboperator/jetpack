defmodule JetpackPhoenix.PageController do
  use JetpackPhoenix.Web, :controller

  def index(conn, _params) do
    IO.inspect get_session(conn, :token_properties)
    render conn, "index.html"
  end

  def redirect_to_auth(conn, _params) do
    redirect conn, external: "https://app.procore.com/oauth/authorize?response_type=code&client_id=9f2991210a431c6dbf24c016fbb16ed29909c1a944b4b8133923a37b8ce3e791&redirect_uri=http://localhost:4000/oauth/procore/callback"
  end

  def oauth_callback(conn, %{ "code" => code }) do
    code
    |> build_params
    |> Poison.encode!
    |> get_access_token
    |> store_access_token(conn)
    |> render("index.html")
  end

  defp store_access_token(access_token_response, conn) do
    case access_token_response do
      {:ok, token_properties} ->
        put_session(conn, :token_properties, token_properties)
      {:error, error} ->
        IO.inspect error
        conn
    end
  end

  defp get_access_token(encoded_params) do
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

  defp decodeJSON(body_string) do
    Poison.decode!(body_string)
  end

  defp build_params(code) do
    client_id = Application.get_env(:jetpack_phoenix, :client_id)
    client_secret = Application.get_env(:jetpack_phoenix, :client_secret)

    %{
      "grant_type": "authorization_code",
      "code": code,
      "client_id": client_id,
      "client_secret": client_secret,
      "redirect_uri": "http://localhost:4000/oauth/procore/callback",
    }
  end
end
