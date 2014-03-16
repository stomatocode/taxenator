require "csv"
require "pry"


module Scanner
  def load_items_csv(filename)
    items = []
    CSV.foreach(filename, :headers => true, :header_converters => :symbol) do |row|
      items << row.to_hash
    end
    items
  end
end

module Printer
  def terminal_output(items_hash)
    
  end

end

class Basket 
  include Scanner

  attr_reader :items

  def initialize(origin)
    @items = load_items_csv(origin)
  end

  def compute
    calculator = Calculator.new
    totals = calculator.calculate(@items)

  end

end

class Calculator

  def initialize(rates = {})
    @tax_rate = rates[:tax_rate] || 0.1
    @import_duty = rates[:import_duty] || 0.05
    @exempt = rates[:exempt] || ["food","book","medical"]
  end

  def calculate(basket)

  end

end

basket = Basket.new("items.csv")
binding.pry

basket.compute


