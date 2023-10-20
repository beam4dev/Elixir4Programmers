defmodule Fib do
  Code.require_file("cache.exs")

  def fibonacci(n) do
    {:ok, agent} = Cache.start()
    fib(n, agent)
  end

  def fib(0, agent) do
      map = Cache.get(agent)
      map[0]
  end

  def fib(1, agent) do
      map = Cache.get(agent)
      map[1]
  end

  def fib(n, agent) do
    IO.inspect(Cache.get(agent))
    map = Cache.get(agent)
    val = compute_fib(map[n-1], agent, n-1) + compute_fib(map[n-2], agent, n-2)
    Cache.update(agent, n, val)
    map = Cache.get(agent)
    IO.inspect(map)
    map[n]
  end

  def compute_fib(nil, agent, n ) do
      Cache.update(agent, n, fib(n, agent))
      map = Cache.get(agent)
      map[n]
  end

  def compute_fib(v, agent, n ) do
    map = Cache.get(agent)
    map[n]
  end


end
