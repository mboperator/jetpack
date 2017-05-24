defmodule JetpackPhoenix.PageController do
  use JetpackPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
