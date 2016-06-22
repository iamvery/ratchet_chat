defmodule Pakex.PageController do
  use Pakex.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", data: data
  end

  defp data do
    Pakex.Data.new
    |> Pakex.Data.scope(:message, all_messages)
    |> Pakex.Data.scope(:new_message_form, message_form)
  end

  defp all_messages, do: Pakex.Messages.all

  defp message_form do
    {
      %{
        csrf: [value: get_csrf_token, name: "_csrf_token"],
        body: [name: "message[body]"],
        submit: [type: "submit"],
      },
      action: "/messages", method: "post"
    }
  end
end
