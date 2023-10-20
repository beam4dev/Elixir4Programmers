defmodule Chain1 do

    defstruct(
    	next_node: nil,
    	count: 10000
    )
    
    def start_link(next_node) do
        spawn_link(Chain1, :message_loop, [%Chain1{next_node: next_node}])
        |> Process.register(:chainer)
    end
    
    def message_loop(%{count: 0}) do
    	IO.puts "done"
    end  
    
    def message_loop(state) do
    	receive do
    	   {:trigger, _list} ->
    	        send {:chainer, state.next_node}, {:trigger, []}
    	end
    	message_loop(%{state| count: state.count - 1})
    end	
end
