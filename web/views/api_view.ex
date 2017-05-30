defmodule JetpackPhoenix.ApiView do
  use JetpackPhoenix.Web, :view

  def render("response.json", %{ :response => response }) do
    Poison.decode! response
  end
end
