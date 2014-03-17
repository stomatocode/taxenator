require "csv"
require "pry"

module Ring_up
  # adapt to accept ARGV for filename
  def self.run
    baskets = []
    if ARGV
      ARGV.each do |file|
        baskets << Basket.new(file)
      end
    else
      basket = Basket.new(filename)
    end

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
  def print
    puts  "Pre-tax total: #{@pre_tax_total}"
    puts  "Tax: #{@tax}"
    puts  "Final: #{@final}"
  end

# def purchase_price
#   sprintf( "%.2f",attributes['purchase_price'])
# end

end

class Basket 
  include Scanner
  include Printer

  attr_reader :items, :pre_tax_total, :tax

  def initialize(origin)
    @items = load_items_csv(origin)
    @pre_tax_total = 0
    @tax = 0
    @final = 0
  end

  def compute
    pre_tax
    p @pre_tax_total
    @taxenator = Tax_calculator.new
    @taxenator.calculate(@items)
    @items.each_value {|post_tax| @final += post_tax[:price]}
    @tax = @final - @pre_tax_total
    p "fart #{@tax.round(2)}"
  end

  def pre_tax
    @items.each_value {|pre_tax| @pre_tax_total += pre_tax[:price]}    
  end

end

class Tax_calculator

  def initialize(rates = {})
    @tax_rate    = rates[:tax_rate]     || 0.1
    @import_duty = rates[:import_duty]  || 0.05
    @tax_exempt  = rates[:tax_exempt]   || [:food,:book,:medical]
  end

  def calculate(items)
    items.each_value do |item|
      if item[:origin] == :for
        if !@tax_exempt.include?(item[:type])
          item[:price] = item[:price] + (item[:price] * @tax_rate) + (item[:price] * @import_duty)
          item[:price] = item[:price].round(2)
          p "foreign not exempt: #{item[:price]}"
        end
        item[:price] = item[:price] + (item[:price] * @import_duty)
        item[:price] = item[:price].round(2)
        p "foreign exempt #{item[:price]}"
      else
        if !@tax_exempt.include?(item[:type])
          item[:price] = item[:price] + (item[:price] * @tax_rate)
          item[:price] = item[:price].round(2)
          p "domestic not exempt: #{item[:price]}"
        end

        item[:price]
        p "domestic exempt: #{item[:price]}"
      end
    item[:price] = item[:price].round(2)
    end
  end

  def round=(num) 
    num=num.round(2)
  end

  def imported
    
  end

  def domestic
    
  end

end

basket = Basket.new("input3.csv")
binding.pry
basket.compute
