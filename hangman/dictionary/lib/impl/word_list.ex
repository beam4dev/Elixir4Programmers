defmodule Dictionary.Impl.WordList do

  @type t :: list(String.t)

  @spec word_list() :: t
  def word_list() do
    "../../assets/words1.txt"
      |> Path.expand(__DIR__)
      |> File.read!()
      |> String.split(~r/\n/, trim: true)
  end

  @spec random_word(t) :: String.t
  def random_word(list) do
    list
    |> Enum.random
  end

end



#    "./assets/words.txt"
#|> Path.expand(__DIR__)
#|> File.read!()
#|> String.split(~r{\n}, trim: true)
