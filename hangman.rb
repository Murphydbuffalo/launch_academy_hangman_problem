#!/usr/bin/env ruby

wordbank = ["tumble", "elixir", "falter", "erroneous", "sensible", "arrogant"] #Create wordbank with some words
word = wordbank.sample.upcase  #Choose sample word from bank
unaltered_word = word.upcase #Word will be altered later, this is used for congrats message
previous_guesses = [] #Stores user's guesses to alert when re-use is attempted
target = "_"*word.length  #Displays user's progress in guessing the word
counter = 8 #Create and display a counter for guesses

def add_guess(array, guess) #DRY's out adding old guesses to their array
  array << guess
end

def congrats(solution) #DRY's out congrats messages ...but something is wrong here
  puts "Congratulations, you got it!  The word is : #{solution}"
end

def failure #DRY's out failure messages
  puts "Sorry, better luck next time!"
end

def prompt(target, counter) #DRY's out user input and progress prompt
	puts "Word to guess: #{target}  " #Create a and display "target" string of _ _ _ _ _'s
	print "Guess a single letter or the entire word.  " #Prompt user for input
	puts "#{counter} tries remaining!" #decrementing counter
end

prompt(target, counter)
guess = gets.chomp.upcase

until counter == 0 || !target.include?("_") #Loop until no more tries remaining or user has guessed word
	if guess.length === 1 #If single character
		if previous_guesses.include?(guess)  #Did user already guess that letter?
			puts "You've already guessed that letter!" #If yes, return to prompt
			prompt(target, counter)
		elsif word.include?(guess) #If not, does word include guess?
			puts "Good guess!"
			until !word.include?(guess)
			  position = word.index(guess)  #Index it, where in word is guess?
			  target[position] = guess #Replace that position of word with guess using [ ]
			  word[position] = "_" #Remove the letter from word for re-indexing
			end 
			add_guess(previous_guesses, guess) #ADD GUESS TO ALREADY GUESSED LETTERS
			prompt(target, counter) #Return to prompt
		else
		    puts "Sorry, try again!"
		    counter -= 1 #If not included, decrement counter, alert user
			add_guess(previous_guesses, guess) #Add guess to already guessed
			prompt(target, counter) #Return to prompt
		end
	elsif guess.length > 1  #If multicharacter, does guess equal word?
		if guess == unaltered_word  
		  congrats(unaltered_word) #If yes, congrats
		  break
		else
		  failure #If no, failure
		  break
		end
	end
	guess = gets.chomp.upcase
end

congrats(target) if !target.include?("_")  #If target == word ...win
failure if counter == 0 #If counter == 0 ...lose



