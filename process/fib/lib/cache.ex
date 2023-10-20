defmodule Cache do

  @moduledoc """
  We implement a simple key/value cache. State is stored in an Agent, in
  the form of a map.

  The function `lookup` tries to look the value up in the cache, and then
  calls `complete_if_not_found`. This takes two forms. If there was
  no value in the cache, it calls the function passed in by the client
  to supply it, updating the cache at the same time.

  Otherwise, it simply returns the cached value.
  """

  @doc """
  Start the cache, run the supplied function, then stop the cache.

  Eventually we'll be able to do better than this.
  """

  def run(body) do
    { :ok, pid } = Agent.start_link(fn -> %{ 0 => 0, 1 => 1 } end)
    result = body.(pid)
    Agent.stop(pid)
    result
  end

  def lookup(cache, n, if_not_found) do
    Agent.get(cache, fn map -> map[n] end)
    |> complete_if_not_found(cache, n, if_not_found)
  end

  defp complete_if_not_found(nil, cache, n, if_not_found) do
    if_not_found.()
    |> set(cache, n)
  end

  defp complete_if_not_found(value, _cache, _n, _if_not_found) do
    value
  end

  defp set(val, cache, n) do
    Agent.get_and_update(cache, fn map ->
      { val, Map.put(map, n, val)}
    end)
  end
end
