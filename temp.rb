require 'pry'
require 'csv'

def load_deck(filename)
    CSV.foreach(filename, headers: true, col_sep: "$", header_converters: :symbol) do |row|
      card = Flashcard.new(row)
      @deck.add_card(card)
    end
end

load_deck