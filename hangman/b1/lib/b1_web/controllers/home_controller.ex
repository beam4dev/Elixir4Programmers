defmodule B1Web.HomeController do
  use B1Web, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    redirect(conn, to: ~p"/hangman")
  end
end
