class FlashcardView

  def open_prompt
    display("Welcome to Flashcards! Let's get started learning!\n\n")
  end

  def display(output)
    puts output
  end

  def show_definition(input)
    display(input + "\n\n")
  end

  def ask_for_answer
    print "Guess: "
    get_input
  end

  def display_answer(answer)
    display("The correct answer was: #{answer}.")
  end

  def get_input
    input = STDIN.gets.chomp
  end

  def prompt_correct
    display("That's correct! Nice job!\n\n")
  end

  def prompt_incorrect
    display("\nIncorrect Guess")
  end

  def prompt_completed_deck
    display("You completed the deck! Good work genius!")
  end

  def prompt_next_card
    display("-----Next card-----\n\n")
  end

  def prompt_card_attempts(input)
    display("Attempts: #{input}\n\n")
  end

  def prompt_repeat_deck
    display("There were a few flashcards you need to work on. Let's try those again.\n-------\n")
  end
end