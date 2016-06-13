defmodule Pakex.PageController do
  use Pakex.Web, :controller

  def index(conn, _params) do
    data = Pakex.Data.new |> Pakex.Data.scope(:message, Pakex.MessageMutator.all)
    render conn, "index.html", data: data
  end
end
