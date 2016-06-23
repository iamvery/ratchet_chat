defmodule Pakex.PageController do
  use Pakex.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", data: data
  end

  defp data do
    messages_data
    |> Pakex.Data.scope(:new_message_form, message_form)
  end

  defp messages_data, do: Pakex.Messages.all

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
