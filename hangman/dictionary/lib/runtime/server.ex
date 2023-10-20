defmodule Dictionary.Runtime.Server do
  alias Dictionary.Impl.WordList

  @type t :: pid()

  @me __MODULE__

  use Agent

  def start_link(_) do
    Agent.start_link(&WordList.word_list/0, name: @me)
  end

  def random_word() do
   # Code to kill the process, so we can restart the server.
   #if :rand.uniform() < 0.22 do
   #    Agent.get(@me, fn _-> exit(:boom) end)
   #end
   Agent.get(@me, &WordList.random_word/1)
  end
end
