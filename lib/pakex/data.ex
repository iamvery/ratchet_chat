# This would probably end up being part of Ratchet
defmodule Pakex.Data do
  def new, do: %{}

  def scope(data, property, property_data) do
    Map.put(data, property, property_data)
  end
end
