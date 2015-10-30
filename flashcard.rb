require 'csv'
require 'pry'

class Flashcard
  attr_reader :definition, :answer
  def initialize(args = {})
    @definition = args[:definition]
    @answer = args[:answer]
  end
end

class FlashcardDeck
  attr_reader :flashcards
  def initialize
    @flashcards = []
  end

  def remove_card(card)
    @flashcards.delete(card)
  end

  def add_card(card)
    @flashcards << card
  end
end