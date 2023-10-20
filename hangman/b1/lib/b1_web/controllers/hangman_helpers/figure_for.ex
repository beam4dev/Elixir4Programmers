defmodule B1Web.HangmanHelpers.FigureFor do

@spec figure_for(0 | 1 | 2 | 3 | 4 | 5 | 6 | 7) :: <<_::1184>>
  def figure_for(0) do
    ~s{
       _______
      |       |
      |       |
      O       |
    / | \\     |
    / \\      |
              |
              |
     ==========
    }
  end

  def figure_for(1) do
    ~s{
       _______
      |       |
      |       |
      O       |
    / | \\     |
    /        |
              |
              |
     ==========
    }
  end

  def figure_for(2) do
    ~s{
       _______
      |       |
      |       |
      O       |
    / | \\     |
              |
              |
              |
     ==========
    }
  end

  def figure_for(3) do
    ~s{
       _______
      |       |
      |       |
      O       |
    / |       |
              |
              |
              |
     ==========
    }
  end

  def figure_for(4) do
    ~s{
       _______
      |       |
      |       |
      O       |
    /         |
              |
              |
              |
     ==========
    }
  end

  def figure_for(5) do
    ~s{
       _______
      |       |
      |       |
      O       |
              |
              |
              |
              |
     ==========
    }
  end


  def figure_for(6) do
    ~s{
       _______
      |       |
      |       |
              |
              |
              |
              |
              |
     ==========
    }
  end

  def figure_for(7) do
    ~s{
       _______
      |       |
              |
              |
              |
              |
              |
              |
     ==========
    }
  end

end
