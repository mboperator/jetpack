defmodule JetpackPhoenix.ApiController do
  use JetpackPhoenix.Web, :controller

  def v2_proxy(conn, %{"path" => path}) do
    response = contact_procore(conn, "https://app.procore.com/vapid/#{path}")
    render conn, "response.json", response: response
  end

  defp contact_procore(conn, path) do
    HTTPoison.start
    headers = build_headers(conn)
    response = HTTPoison.get! path, headers

    case response do
      %HTTPoison.Response{status_code: 200, body: body} ->
        body
      %HTTPoison.Error{reason: reason} ->
        IO.inspect reason
    end
  end

  defp build_headers(conn) do
    access_token = conn |> get_req_header("authorization")

    [
      "Content-Type": "application/json",
      "Authorization": "Bearer #{access_token}"
    ]
  end
end
