require 'pry'
require 'csv'

class Flashcard
  attr_reader :definition, :answer
  def initialize(args = {})
    @definition = args[:definition]
    @answer = args[:answer]
  end
end

$testing = []
def load_deck(filename)
  counter = 1
  args = {}
  File.foreach(filename, col_sep: "\n") do |csv_line|
    # binding.pry
    if counter == 1
      args[:definition] = csv_line.chomp
      counter += 1
    elsif counter == 2
      args[:answer] = csv_line.chomp
      counter += 1
    elsif counter == 3
      counter = 1
      card = Flashcard.new(args)
      $testing << card
    end
  end
end

load_deck('flashcard_samples_redux.txt')

binding.pry
puts ""