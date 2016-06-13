defmodule Pakex.MessageController do
  use Pakex.Web, :controller

  def create(conn, %{"message" => message_params}) do
    Message.add(message_params["body"])
    redirect conn, to: "/"
  end
end
