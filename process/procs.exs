defmodule Procs do
	def hello(count) do
		receive do
			{:crash, reason} ->
				exit(reason)

			{:quit} ->
				IO.puts("I'm outta here!")

			{:reset} ->
					hello(0)
			{:add, n} when is_integer(n) ->
					hello(count + n)
			 msg ->
					IO.puts("#{count}: Hello #{msg}")
					hello(count)
		end
	end
end
