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