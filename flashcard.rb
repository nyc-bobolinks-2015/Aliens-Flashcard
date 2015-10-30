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

class FlashcardController
  attr_reader :view
  def initialize
    @deck = FlashcardDeck.new
    @view = FlashcardView.new
    run_deck
  end

  def load_deck(filename)
  counter = 1
  args = {}
  File.foreach(filename, col_sep: "\n") do |csv_line|
    if counter == 1
      args[:definition] = csv_line.chomp
      counter += 1
    elsif counter == 2
      args[:answer] = csv_line.chomp
      counter += 1
    elsif counter == 3
      counter = 1
      card = Flashcard.new(args)
      @deck.add_card(card)
    end
  end
end

  def run_deck
    view.open_prompt
    load_deck('flashcard_samples_redux.txt')
    @deck.flashcards.each do |card|
      view.show_definition(card.definition)
      answer = view.ask_for_answer
      until check_answer?(answer, card.answer)
        view.prompt_try_again
        answer = view.ask_for_answer
      end
      go_to_next_card
    end
  end

  def check_answer?(answer, correct_answer)
    answer == correct_answer
  end

  def go_to_next_card
    view.prompt_correct
  end

end

class FlashcardView

  def open_prompt
    display("Welcome to Flashcards! Let's get started learning!")
  end

  def display(output)
    puts output
  end

  def show_definition(input)
    puts input
  end

  def ask_for_answer
    puts "What is your answer?"
    get_input
  end

  def get_input
    input = gets.chomp
  end

  def prompt_try_again
    puts "Try again"
  end

  def prompt_correct
    puts "That's correct! Nice job!"
  end

end

FlashcardController.new