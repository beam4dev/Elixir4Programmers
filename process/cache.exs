defmodule Cache do

  def start() do
    Agent.start_link(fn -> %{0 => 0, 1 => 1 } end)
  end

  def get(agent) do
     Agent.get(agent, fn state-> state end)
  end

  def update(agent, key, value) do
    Agent.update(agent, fn state-> Map.put(state, key, value) end)
  end
end
