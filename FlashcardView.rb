class FlashcardView

  def open_prompt
    display("Welcome to Flashcards! Let's get started learning!\n\n")
  end

  def display(output)
    puts output
  end

  def show_definition(input)
    display(input + "\n")
  end

  def ask_for_answer
    print "Guess: "
    get_input
  end

  def get_input
    input = STDIN.gets.chomp
  end

  def prompt_try_again
    display("Try again")
  end

  def prompt_correct
    display("That's correct! Nice job!\n\n")
  end

  def prompt_incorrect
    display("\n\nIncorrect")
  end

  def prompt_next_card
    display("------Next Card------\n\n")
  end

  def prompt_completed
    display("You completed the deck! Nice work genius!")
  end

  def show_attempts(input)
    display("Attempts: #{input}")
  end

  def prompt_run_repeat
    display("You have a few cards that you need to work on. Let's try again.")
  end
end