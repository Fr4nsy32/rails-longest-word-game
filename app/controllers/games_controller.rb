require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = Array.new(9) { ('A'..'Z').to_a.sample };
  end

  def score
    @attempt = params[:suggestion]
    p @attempt
    @grid = params[:letters].gsub(/\s+/, "")
    p @grid
    @message = ""
    def english_word?
      response = URI.parse("https://wagon-dictionary.herokuapp.com/#{@attempt}")
      json = JSON.parse(response.read)
      return json['found']
    end
    if english_word? && @attempt.upcase.chars.all? { |letter| @attempt.count(letter) <= @grid.chars.count(letter) }
      @message = "Congratulations! #{@attempt} is an English word."
    elsif english_word?
      @message = "Sorry but #{@attempt} contains non-grid letters."
    else
      @message = "Sorry but #{@attempt} is not an English word."
    end
  end
end
