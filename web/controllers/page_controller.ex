defmodule Pakex.PageController do
  use Pakex.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", data: data
  end

  defp data do
    Pakex.Data.new
    |> Pakex.Data.scope(:message, all_messages)
  end

  defp all_messages, do: Pakex.MessageMutator.all
end
