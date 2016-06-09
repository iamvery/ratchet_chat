defmodule Pakex.PageController do
  use Pakex.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", data: %{}
  end
end
