require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @alphabet = ('A'..'Z').to_a
    @letters = []
    10.times { @letters << @alphabet.sample.upcase }
  end


  def score
    guess = params[:word]
    grid = params[:letters_array].split("")
    english_word = english_word?(guess)
    @valid_word = included?(guess, grid)
  end


  def included?(guess, grid)
    guess.upcase.split.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(guess)
    response = open("https://wagon-dictionary.herokuapp.com/#{guess}")
    json = JSON.parse(response.read)
    return json['found']
  end
end


    # @guess = params[:word].upcase.split("")
    # @letters = params[:letters_array].split("")

    # if @guess.any? { |x| @letters.include? x }
    #   @message = "Well done!"
    # else
    #   @message = "sorry you used the wrong characters!"
    # end


    # if @guess.chars.all? { |letter| params[:word].count(letter) <= @letters.count(letter) }
    #   @message = "Well done!"
    # else
    #   @message = "sorry you used the wrong characters!"
    # end
