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
      import Pakex.Data
      import Mutation, only: [query: 2, action: 3]
    end
  end

  defmacro query(name, do: body) do
    quote do
      def unquote(name)() do
        new |> scope(@prop, unquote(body))
      end
    end
  end

  defmacro action(name, [data: data], do: body) do
    quote do
      def unquote(name)(var!(params)) do
        unquote(body)
        rendered = Phoenix.View.render_to_string(@view, @template, data: unquote(data))
        @endpoint.broadcast "mutations", unquote(Atom.to_string(name)), %{target: @prop, view: rendered}
        # TODO mutation channel should probably be scoped or something...
      end
    end
  end
end
