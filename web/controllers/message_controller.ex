defmodule Pakex.MessageController do
  use Pakex.Web, :controller

  def create(conn, %{"message" => message_params}) do
    Pakex.Messages.create(message_params)
    redirect conn, to: "/"
  end
end
