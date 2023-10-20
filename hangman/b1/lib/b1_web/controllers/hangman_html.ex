defmodule B1Web.HangmanHTML do
  import Phoenix.HTML.Link
  import Phoenix.HTML.Form
  use B1Web, :html

  embed_templates "hangman_html/*"


  def continue_or_try_again(_conn, status) when status in [:won, :lost] do
    button("Try again", to: ~p"/hangman")
  end


  def continue_or_try_again(conn, _status) do
    form_for(conn, ~p"/hangman", [as: "make_move", method: :put], fn f ->
      [
       text_input(f, :guess, required: true, pattern: "[a-z]"),
       " ",
       submit("Make new guess")
      ]
    end)
  end


  @status_fields %{
    initializing: {"initializing", "Guess the word, a letter at a time"},
    good_guess: {"good-guess", "Good guess!"},
    bad_guess: {"bad-guess", "Sorry, that's a bad guess"},
    won: {"won", "You won!"},
    lost: {"lost", "Sorry, you lost"},
    already_used: {"already-used", "You already used that letter"}
  }


  def move_status(status) do
    {class, msg} = @status_fields[status]
    "<div class='status #{class}'>#{msg}</div>"
  end

  defdelegate figure_for(input), to: B1Web.HangmanHelpers.FigureFor

end
