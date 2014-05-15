#!/usr/bin/env ruby

wordbank = ["tumble", "elixir", "falter", "erroneous", "sensible", "arrogant"] #Create wordbank with some words
word = wordbank.sample.upcase  #Choose sample word from bank
unaltered_word = word.upcase #Word will be altered later, this is used for congrats message
previous_guesses = [] #Stores user's guesses to alert when re-use is attempted
target = "_"*word.length  #Displays user's progress in guessing the word
counter = 8 #Create and display a counter for guesses

def add_guess(array, guessed_letter) #DRY's out adding old guesses to their array
  array << guessed_letter
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
	puts "#{counter} tries remaining!\n" #decrementing counter
end

def letter_swapper(word, guess, target_displayed)
  until !word.include?(guess)
	position = word.index(guess)  #Index it, where in word is guess?
	target_displayed[position] = guess #Replace that position of word with guess using [ ]
	word[position] = "_" #Remove the letter from word for re-indexing
  end 
end

until counter == 0 || !target.include?("_") #Loop until no more tries remaining or user has guessed word
	prompt(target, counter)
	guess = gets.chomp.upcase
	if guess.length == 1 #If single character
		if previous_guesses.include?(guess)  #Did user already guess that letter?
			puts "You've already guessed that letter!\n" #If yes, return to prompt
		elsif word.include?(guess) #If not, does word include guess?
			puts "Good guess!\n"
			letter_swapper(word, guess, target)
			add_guess(previous_guesses, guess) #ADD GUESS TO ALREADY GUESSED LETTERS
		else
		    puts "Sorry, try again!\n"
		    counter -= 1 #If not included, decrement counter, alert user
			add_guess(previous_guesses, guess) #Add guess to already guessed
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
end

congrats(target) if !target.include?("_")  #If target == word ...win
failure if counter == 0 #If counter == 0 ...lose



