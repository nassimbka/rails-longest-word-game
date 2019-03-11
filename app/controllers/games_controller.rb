# Fuck Rubocop
require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @attempt = params[:word]
    @grid = params[:letters]
    @game_result = score_and_message(@attempt, @grid)
  end

  private

  def included?(attempt, grid)
    attempt.upcase!.chars.all? { |letter| attempt.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized_spellcheck_result = open(url).read
    spellcheck_result = JSON.parse(serialized_spellcheck_result)
    spellcheck_result['found'] ? true : false
  end

  def score_and_message(attempt, grid)
    if included?(attempt, grid)
      if !english_word?(attempt)
        [0, 'Not an English word!']
      else
        # score = compute_score(attempt, time)
        # [score, 'Well done!']
        "Congratulations! #{attempt} is a valid English word!"
      end
    else
      [0, 'Not in the grid!']
    end
  end
end


#########################

# def included?(attempt, grid)
#   attempt.upcase!.chars.all? { |letter| attempt.count(letter) <= grid.count(letter) }
# end
# # check presence des lettres dans la grille proposee


# def compute_score(attempt, time)
#   time > 20 ? 0 : attempt.length * 5 / time
# end
# # calcul du score OK

# def english_word?(word)
#   url = "https://wagon-dictionary.herokuapp.com/#{word}"
#   serialized_spellcheck_result = open(url).read
#   spellcheck_result = JSON.parse(serialized_spellcheck_result)
#   spellcheck_result["found"] ? true : false
# end

# def score_and_message(attempt, grid, time)
#   if included?(attempt, grid)
#     if !english_word?(attempt)
#       [0, 'Not an English word!']
#     else
#       score = compute_score(attempt, time)
#       [score, 'Well done!']
#     end
#   else
#     [0, 'Not in the grid!']
#   end
# end
