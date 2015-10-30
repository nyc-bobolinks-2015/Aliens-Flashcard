require 'csv'
require 'pry'

class Flashcard
  attr_reader :definition, :answer
  attr_accessor :attempts
  def initialize(args = {})
    @definition = args[:definition]
    @answer = args[:answer]
    @attempts = 0
  end
end

class FlashcardDeck
  attr_accessor :flashcards
  def initialize
    @flashcards = []
  end

  def remove_card(card)
    @flashcards.delete(card)
  end

  def add_card(card)
    @flashcards << card
  end

  def pick_a_card
    @flashcards.sample
  end

  def is_empty?
    flashcards.length == 0
  end
end