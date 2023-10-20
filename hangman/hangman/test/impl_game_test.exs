defmodule HangmanImplGameTest do
  use ExUnit.Case
  alias Hangman.Impl.Game

  test "new game return structure" do
    game = Game.new_game

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "new game return correct word" do
    game = Game.new_game("wombat")

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert game.letters == ["w","o","m","b","a","t"]
  end


  test "each element of the letters list is a lower-case ASCII character (a to z). " do
    game = Game.new_game("wombat")

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert Enum.all?(game.letters, fn codepoint -> codepoint >= "a" and codepoint <= "z" end) == true
  end

  test "state doesn't change if a game is won or lost" do
    for state <- [:won, :lost] do
      game = Game.new_game("wombat")
      game = Map.put(game, :game_state, state)
      {new_game, _tally} = Game.make_move(game, "x")

      assert new_game == game
    end
  end

  test "we record letters used" do
      game = Game.new_game("wombat")
      {game, _tally} = Game.make_move(game, "x")
      {game, _tally} = Game.make_move(game, "y")
      {game, _tally} = Game.make_move(game, "x")
      assert MapSet.equal?(game.used, MapSet.new(["x", "y"]))
  end


  test "we recognize letters in the word" do
    game = Game.new_game("wombat")
    {game, tally} = Game.make_move(game, "m")
    assert tally.game_state == :good_guess

    {_game, tally} = Game.make_move(game, "t")
    assert tally.game_state == :good_guess

  end

  test "we recognize letters not in the word" do
    game = Game.new_game("wombat")
    {game, tally} = Game.make_move(game, "x")
    assert tally.game_state == :bad_guess

    {game, tally} = Game.make_move(game, "w")
    assert tally.game_state == :good_guess

    {_game, tally} = Game.make_move(game, "l")
    assert tally.game_state == :bad_guess
  end

  test "can handle a sequence of moves" do
  #
    [
      # guess | state   turns   letters,                   used
      ["a",  :bad_guess,  6, ["_", "_", "_", "_","_"], ["a"]],
      ["a",  :already_used,  6, ["_", "_", "_", "_","_"], ["a"]],
      ["e",  :good_guess, 6, ["_", "e", "_", "_","_"], ["a","e"]],
      ["x",  :bad_guess,  5, ["_", "e", "_", "_","_"], ["a", "e", "x"]],
    ] |> test_sequence_of_moves()
  end

  test "can handle winning game" do
    #
      [
        # guess | state   turns   letters,                   used
        ["a",  :bad_guess,   6, ["_", "_", "_", "_","_"], ["a"]],
        ["a",  :already_used,6, ["_", "_", "_", "_","_"], ["a"]],
        ["e",  :good_guess,  6, ["_", "e", "_", "_","_"], ["a","e"]],
        ["x",  :bad_guess,   5, ["_", "e", "_", "_","_"], ["a", "e", "x"]],
        ["l",  :good_guess,  5, ["_", "e", "l", "l","_"], ["a", "e", "l","x"]],
        ["o",  :good_guess,  5, ["_", "e", "l", "l","o"], ["a", "e", "l", "o","x"]],
        ["y",  :bad_guess,   4, ["_", "e", "l", "l","o"], ["a", "e", "l", "o","x", "y"]],
        ["h",  :won,         4, ["h", "e", "l", "l","o"], ["a", "e", "h", "l", "o","x", "y"]],
      ] |> test_sequence_of_moves()
    end

  test "can handle lossing game" do
      #
        [
          # guess | state   turns   letters,                   used
          ["a",  :bad_guess,   6, ["_", "_", "_", "_","_"], ["a"]],
          ["b",  :bad_guess,   5, ["_", "_", "_", "_","_"], ["a", "b"]],
          ["c",  :bad_guess,   4, ["_", "_", "_", "_","_"], ["a", "b", "c"]],
          ["d",  :bad_guess,   3, ["_", "_", "_", "_","_"], ["a", "b", "c", "d"]],
          ["e",  :good_guess,  3, ["_", "e", "_", "_","_"], ["a", "b", "c", "d", "e"]],
          ["f",  :bad_guess,   2, ["_", "e", "_", "_","_"], ["a", "b", "c", "d", "e", "f"]],
          ["g",  :bad_guess,   1, ["_", "e", "_", "_","_"], ["a", "b", "c", "d", "e", "f", "g"]],
          ["h",  :good_guess,  1,  ["h", "e", "_", "_","_"], ["a", "b", "c", "d", "e", "f", "g", "h"]],
          ["i",  :lost,        0, ["h", "e", "l", "l","o"], ["a", "b", "c", "d", "e", "f", "g", "h", "i"]],
        ] |> test_sequence_of_moves()
      end

  #test "can handle bad guess inputs" do
  #      game = Game.new_game("wombat")
  #      {new_game, tally} = Game.make_move(game, "A")
  #      assert new_game == :error
  #end

  test "can handle winning game2" do
      moves = [
        {"w", :good_guess},
        {"i", :good_guess},
        {"b", :good_guess},
        {"l", :good_guess},
        {"e", :won}
      ]

      game = Game.new_game("wibble")

      for {guess, state, game} <- moves, game do
        game = Game.make_move(game, guess)
        assert game.game_state == state
        game
      end
  end

  def test_sequence_of_moves(script) do
    game =Game.new_game("hello")
    Enum.reduce(script, game, &check_one_move/2)
  end

  defp check_one_move([guess, state, turns, letters, used], game) do
     {game, tally} = Game.make_move(game, guess)
     assert tally.game_state == state
     assert tally.turns_left == turns
     assert tally.letters == letters
     assert tally.used == used

     game
  end
end
