class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @guess = params["answer"]
    @letters = params["letters"]

    if @guess.chars.all? { |letter| @guess.count(letter) <= @grid.count(letter)} == true

      url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
      user_ser = URI.open(url).read
      user = JSON.parse(user_ser)
      if user[:found] == false
        @message = "This word doesn't exist"
      elsif user[:word].split.sort != @letters.sort
        @message = "This word was not in the grid"
      else
        @message = "Congratulation, you just found a #{user[:word].lenght} word"
      end
    end
  end
end
