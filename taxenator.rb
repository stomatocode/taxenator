require "csv"

module Ring_up
  def self.run
    if ARGV.empty?
      basket = Basket.new("items.csv")
      basket.compute
      basket.print_items(basket.items)
      basket.print_totals
    else
      ARGV.each do |file|
        basket = Basket.new(file)      
        basket.compute
        basket.print_items(basket.items)
        basket.print_totals
      end
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
      item[:type]   = item[:type].to_sym
      item[:origin] = item[:origin].to_sym
    end
    items
  end
end

module Printer
  def print_totals
    puts  "Pre-tax total: $#{@pre_tax_total}"
    puts  "Tax: $#{@tax}"
    puts  "Final: $#{@final}"
  end

  def print_items(items)
    puts  "# Receipt #"
    items.each_value do |item|
      puts "#{item[:quantity]} #{item[:name]}, #{item[:type]}: $#{item[:price]}"
    end
  end
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
    @taxenator = Tax_calculator.new
    @taxenator.calculate(@items)
    @items.each_value {|post_tax| @final += post_tax[:price]}
    @tax = @final - @pre_tax_total
    @tax = @tax.round(2)
    @final = @final.round(2)
  end

  def pre_tax
    @items.each_value {|pre_tax| @pre_tax_total += pre_tax[:price]}    
    @pre_tax_total = @pre_tax_total.round(2)
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
        foreign(item)        
      else
        domestic(item)
      end
    end
  end

  def foreign(item)
    if exempt?(item[:type])
      item[:price] = item[:price] + (item[:price] * @import_duty)
      item[:price] = item[:price].round(2)
    else
      item[:price] = item[:price] + (item[:price] * @tax_rate) + (item[:price] * @import_duty)
      item[:price] = item[:price].round(2)
    end   
  end

  def domestic(item)
    if exempt?(item[:type])
      item[:price]
    else
      item[:price] = item[:price] + (item[:price] * @tax_rate)
      item[:price] = item[:price].round(2)
    end 
  end

  def exempt?(type)
    @tax_exempt.include?(type)
  end

end

Ring_up.run
