defmodule JetpackPhoenix.PageView do
  use JetpackPhoenix.Web, :view

  def logged_in(conn) do
    token_properties = Plug.Conn.get_session(conn, :token_properties)
    case token_properties do
      nil ->
        false
      properties ->
        true
    end
  end
end
