# - Object-oriented design
# - Naming
# - Algorithms
# - Unit testing
# - Style
# - Robustness

# Introduction to the Problems All problems below require some kind of input. You are free to implement any
# mechanism for feeding input into your solution (for example, using hard coded data 
# within a unit test). You should provide sufficient evidence that your solution is complete 
# by, as a minimum, indicating that it works correctly against the supplied test data.

# Problem One: Sales Tax 
# Basic sales tax is applicable at a rate of 10% on all goods, except books, food, and 
# medical products that are exempt. Import duty is an additional sales tax applicable on all 
# imported goods at a rate of 5%, with no exemptions. 

## module Import_duty
## -> proc with rate application
## module Tax_rate
## -> proc with rate application

 
# When I purchase items I receive a receipt, which lists the name of all the items and their 
# price (including tax), finishing with the total cost of the items, and the total amounts of 
# sales taxes paid. The rounding rules for sales tax are that for a tax rate of n%, a shelf 
# price of p contains (np/100 rounded up to the nearest 0.05) amount of sales tax. 

## from Basket to Printer
## module Printer
 
# Write an application that prints out the receipt details for these shopping baskets... 
# INPUT: 

## these inputs should come from a CSV as "scanned items", each a Basket object
 
# Input 1: 
# 1 book at 12.49 
# 1 music CD at 14.99 
# 1 chocolate bar at 0.85 
 
# Input 2: 
# 1 imported box of chocolates at 10.00 
# 1 imported bottle of perfume at 47.50 
 
# Input 3: 
# 1 imported bottle of perfume at 27.99 
# 1 bottle of perfume at 18.99 
# 1 packet of headache pills at 9.75 
# 1 box of imported chocolates at 11.25 
 
# OUTPUT 
 
# Output 1: 
# 1 book: 12.49 
# 1 music CD: 16.49 
# 1 chocolate bar: 0.85 
# Sales Taxes: 1.50 
# Total: 29.83 
 
# Output 2: 
# 1 imported box of chocolates: 10.50 
# 1 imported bottle of perfume: 54.65 
# Sales Taxes: 7.65 
# Total: 65.15 
 
# Output 3: 
# 1 imported bottle of perfume: 32.19 
# 1 bottle of perfume: 20.89 
# 1 packet of headache pills: 9.75 
# 1 imported box of chocolates: 11.85 
# Sales Taxes: 6.70 
# Total: 74.68 

# describe Printer do
  
# end

# describe Scanner do

#   let(:items) {Scanner}

#   describe "#load_items_csv" do
#     it "should read in items from a CSV (mock 'scanner')" do
#       expect
#     end
#   end

# end

describe Basket do

  let(:calculator) {Calculator.new}

  describe "#compute" do

    it "should create an instance of a Calculator" do
      expect(calculator).to be_a Calculator
    end

  end

end
