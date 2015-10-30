require_relative 'flashcard'
require_relative 'flashcardview'

class FlashcardController
  attr_reader :view, :deck, :completed_deck
  def initialize
    @deck = FlashcardDeck.new
    @completed_deck = FlashcardDeck.new
    @view = FlashcardView.new
    view.open_prompt
    load_deck('flashcard_samples.txt')
    run_deck
    run_repeat
  end

  def load_deck(filename)
  counter = 1
  args = {}
  File.foreach(filename) do |csv_line|
    row = csv_line.chomp
    if counter == 1 &&  csv_line != "\n"
      args[:definition] = row
      counter += 1
    elsif counter == 2
      args[:answer] = row
      counter = 1
      card = Flashcard.new(args)
      deck.add_card(card)
    end

  end
end

  def run_deck

    until deck.is_empty?
      view.prompt_next_card
      card = deck.pick_a_card
      view.show_definition(card.definition)
      answer = view.ask_for_answer
      if check_answer?(answer, card.answer)
        view.prompt_correct
        deck.remove_card(card)
        completed_deck.add_card(card)
      else
        view.prompt_incorrect
      end
      card.attempts += 1
      view.show_attempts(card.attempts)
    end
    view.prompt_completed
  end

  def run_repeat
    deck.flashcards = completed_deck.flashcards.select {|card| card.attempts >= 3}

    if !deck.is_empty?
      view.prompt_run_repeat
      run_deck
    end
  end

  def check_answer?(answer, correct_answer)
    answer == correct_answer
  end

  def go_to_next_card
    view.prompt_correct
  end

end

FlashcardController.new