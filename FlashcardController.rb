require_relative 'flashcard'
require_relative 'flashcardview'

class FlashcardController
  attr_reader :view, :deck, :completed_deck

  def initialize
    @deck = FlashcardDeck.new
    @completed_deck = FlashcardDeck.new
    @view = FlashcardView.new
    view.open_prompt
    filename = ARGV.any? ? ARGV[0] : 'flashcard_samples_redux.txt'
    load_deck(filename)
    run_deck
    run_repeat(3)
  end

  def load_deck(filename)
  counter = 1
  args = {}
  File.foreach(filename) do |csv_line|

    if counter == 1 && csv_line != "\n"
      args[:definition] = csv_line.chomp
      counter += 1
    elsif counter == 2
      args[:answer] = csv_line.chomp
      counter = 1
      card = Flashcard.new(args)
      @deck.add_card(card)
    end


  end
end

  def run_deck

    until deck.is_empty?
      card = deck.pick_a_card
      view.show_definition(card.definition)
      answer = view.ask_for_answer
      if check_answer?(answer, card.answer)
        deck.remove_card(card)
        completed_deck.add_card(card)
        view.prompt_correct
      else
        view.prompt_incorrect
        view.display_answer(card.answer)
      end
      card.attempts += 1
      view.prompt_card_attempts(card.attempts)
      view.prompt_next_card
    end

    view.prompt_completed_deck
  end

  def run_repeat(threshold)
    deck.flashcards = completed_deck.flashcards.select {|card| card.attempts >= threshold}
    reset_attempts
    if !deck.is_empty?
      view.prompt_repeat_deck
      run_deck
    end
  end

  def check_answer?(answer, correct_answer)
    answer == correct_answer
  end

  def reset_attempts
    deck.flashcards.each do |card|
      card.attempts = 0
    end
  end
end

FlashcardController.new