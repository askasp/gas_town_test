defmodule GasTownTestWeb.PageController do
  use GasTownTestWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
