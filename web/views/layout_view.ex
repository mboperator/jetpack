defmodule JetpackPhoenix.LayoutView do
  use JetpackPhoenix.Web, :view

  def get_auth_token(conn) do
    token_properties = Plug.Conn.get_session(conn, :token_properties)
    case token_properties do
      nil ->
        false
      properties ->
        properties["access_token"]
    end
  end
end
