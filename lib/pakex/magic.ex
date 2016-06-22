defmodule MutationChannel do
  use Phoenix.Channel

  def join("mutations", _payload, socket) do
    {:ok, socket}
  end
end

defmodule Mutation do
  defmacro __using__(opts) do
    quote do
      Module.put_attribute(__MODULE__, :prop, unquote(opts[:prop]))
      Module.put_attribute(__MODULE__, :endpoint, unquote(opts[:endpoint]))
      Module.put_attribute(__MODULE__, :view, unquote(opts[:view]))
      Module.put_attribute(__MODULE__, :template, unquote(opts[:template]))
      import Mutation, only: [query: 2, action: 2]
    end
  end

  defmacro query(name, do: body) do
    quote do
      def unquote(name)(), do: unquote(body)
    end
  end

  defmacro action(name, do: body) do
    quote do
      def unquote(name)(var!(params)) do
        unquote(body)
        data = Pakex.Data.new |> Pakex.Data.scope(@prop, all)
        rendered = Phoenix.View.render_to_string(@view, @template, data: data)
        @endpoint.broadcast "mutations", unquote(Atom.to_string(name)), %{target: @prop, view: rendered}
      end
    end
  end

  defmacro mutations_channel do
    quote do
      channel "mutations", MutationChannel
    end
  end
end
