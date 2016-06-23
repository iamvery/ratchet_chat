defmodule Pakex.Messages do
  use Mutation,
    prop: :message,
    endpoint: Pakex.Endpoint,
    view: Pakex.PageView,
    template: "message.html"

  query(:all) do
    Message.all
  end

  action(:create) do
    Message.add(params["body"])
  end
end
