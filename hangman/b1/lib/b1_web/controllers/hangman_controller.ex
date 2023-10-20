defmodule B1Web.HangmanController do
  use B1Web, :controller


  @spec home(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end


  def new(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    game = Hangman.new_game()
    conn
      |> put_session(:game, game)
      |> redirect(to: ~p"/hangman/current")
  end

  def update(conn, params) do
    guess = params["make_move"]["guess"]

    put_in(conn.params["make_move"]["guess"], "")
      |> get_session(:game)
      |> Hangman.make_move(guess)

    redirect(conn, to: ~p"/hangman/current")
  end

  def show(conn, _params) do
     tally =
      conn
        |> get_session(:game)
        |> Hangman.tally()

      render(conn, :game, tally: tally, layout: false)
  end

end
