VALID_CHOICE = %w(paper rock scissors)
require "colorize"

def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'scissors' && second == 'paper')
end

def display_winner(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("You lost.")
  else
    prompt("Its a tie!!")
  end
end

def display_countdown(rps)
  rps.each do |n|
    puts n.yellow
    1.upto(1)
    sleep 0.5
    break if rps.empty?
  end
end

choice = nil
rps = ["> Paper", "> Rock", "> Scissors", "> Shoot!"]

loop do
  loop do
    prompt("Choose one: #{VALID_CHOICE.join(', ')}")
    choice = gets.chomp.downcase

    if VALID_CHOICE.include?(choice)
      break
    else
      prompt("Not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICE.sample

  display_countdown(rps)

  prompt("You chose: #{choice} // CPU chose: #{computer_choice}")

  display_winner(choice, computer_choice)

  prompt("Do you want to play again? (y/n)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing.")
