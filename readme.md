# Taxenator # 
A Ruby tax and import duty calculator.

I enjoyed working on this challenge, and it proved to be a learning experience as well! I wrote it in Ruby 2.0.0, and used Pry 0.9.12 for testing purposes. I'm very much a junior when it comes to TDD and writing proper Rspec tests, so instead of including the incomplete test suites, I opted to say I did not in fact write this using a TDD approach. It is my goal to become more proficient and experienced in TDD principles going forward. 
I wrote this challenge in Ruby because I completed Dev Bootcamp with a focus on Ruby. One of the biggest challenges was dealing with the way Ruby treats floats and precision; this is an area where I also need more experience, as I may have opted to use a different datatype for the prices if I were more familiar with Ruby's math characteristics. 

# To run #

1. Open terminal and navigate to directory with unzipped files.
2. Enter Ruby interpreter command [ruby] and the name of the script file [taxenator.rb]
2a. You can specify which of the three test data files named [input1.csv, input2.csv, input3.csv] after the script filename to have the script calculate a specific set of items (based on prompt's test data)
2b. Alternatively, if no filename is provided after the name of the script, it will default to calculating the test data file containing all test data in one collection.
3. The script will output the calculation and formatting and auto-terminate; simply run again to test again. 

# Design #

I chose to structure the program the way I did because I wanted to design a program that attempted to model the way an actual register or retail transaction might be structured. I attempted to follow principles of OO design, like those I became aware of from sources like Practical Object Oriented Design in Ruby and author Sandi Metz; keep methods and classes small and specific, use modules for behavior that isn't inherently part of the concept of an object (i.e., Baskets shouldn't print themselves), etc.. I was not always successful there, and I see many opportunities to refactor (Basket#compute?), but as a junior developer I believe this is in keeping with the principles I've been taught so far. Also, I still struggle with attempting to optimize from the beginning, a personal challenge I'm working on! 

Thank you for reading and taking the time to evaluate my code!