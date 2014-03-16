require "csv"
require "pry"

module Ring_up
  # adapt to accept ARGV for filename
  def self.run(scans = [])
    if ARGV
      baskets = []
      scans = ARGV
      scans.each do |file|
        baskets << Basket.new(file)
      end

    end
    basket = Basket.new(filename)
    
  end

end


module Scanner
  def load_items_csv(filename)
    items = {}
    CSV.foreach(filename, :converters => :numeric, :headers => true, :header_converters => :symbol) do |row|
      items[row[:name].split(/ /).first.downcase.to_sym] = row.to_hash
    end
    items.each_value do |item|
      item[:type] = item[:type].to_sym
      item[:origin] = item[:origin].to_sym
    end
    items
  end
end

module Printer
  def print()
    
  end
end

class Basket 
  include Scanner

  attr_reader :items

  def initialize(origin)
    @items = load_items_csv(origin)
  end

  def compute
    totals = 0
    @items.each_value {|item| totals += item[:price]}
    tax_applied = Tax_calculator.new.calculate(@items)

  end

end

class Tax_calculator

  def initialize(rates = {})
    @tax_rate = rates[:tax_rate] || 0.1
    @import_duty = rates[:import_duty] || 0.05
    @tax_exempt = rates[:tax_exempt] || [:food,:book,:medical]
  end

  def calculate(basket)
    basket.each_value do |item|
      if item[:origin] == :for
        item[:price] += (item[:price] * @import_duty)
        if !@exempt.include?(item[:type])
          item[:price] += (item[:price] * @tax_rate)
        end
      else
        if !@exempt.include?(item[:type])
          item[:price] += (item[:price] * @tax_rate)         
        end
        item[:price] 
      end
    end
  end

end


binding.pry
basket.compute
