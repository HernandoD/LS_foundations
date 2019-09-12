require "colorize"

VALID_CHOICE = {
  r: "rock",
  p: "paper",
  sc: "scissors",
  l: "lizard",
  sp: "spock"
}

WINNING_COMBOS = {
  "rock" => %w(lizard scissors),
  "paper" => %w(rock spock),
  "scissors" => %w(paper lizard),
  "lizard" => %w(paper spock),
  "spock" => %w(rock scissors)
}

CHOICES_MESSAGE = <<-MSG
Choose one...
  "r" for ROCK
  "p" for PAPER
  "sc" for SCISSORS
  "l" for LIZARD
  "sp" for SPOCK
MSG

def prompt(message)
  message = message.bold.cyan
  puts "=> #{message}"
end

def obtain_choice
  choice = ""
  loop do
    prompt(CHOICES_MESSAGE)
    choice = gets.chomp.downcase
    if VALID_CHOICE.include?(choice.to_sym)
      return choice = VALID_CHOICE[choice.to_sym]
    else
      k = "INVALID CHOICE."
      puts k.bold.red
    end
  end
end

def win?(first, second)
  WINNING_COMBOS[first].include?(second)
end

def display_winner(player, computer)
  if win?(player, computer)
    prompt("You won that one.")
  elsif win?(computer, player)
    prompt("That one goes to the machine.")
  else
    prompt("Thats a tie. Let's go again.")
  end
end

def display_countdown(rps)
  rps.each do |n|
    puts n.bold.cyan
    1.upto(1)
    sleep 0.3
    break if rps.empty?
  end
end

def clear
  system("clear") || system("cls")
end

prompt("Welcome Rock Paper Scissors Lizard Spock!")
prompt("=========================================")

prompt("BEST TO 5 WINS! Its you against the machine. Lets get started.")
lets_go = "Lets go!"
puts lets_go.bold

choice = nil
rps = ["Rock", "Paper", "Scissors", "Lizard", "Spock", "GO!"]

loop do
  player_score = 0
  cpu_score = 0

  loop do
    choice = obtain_choice
    computer_choice = VALID_CHOICE.values.sample

    display_countdown(rps)

    prompt("You chose: #{choice} <> Machine chose: #{computer_choice}")
    clear

    display_winner(choice, computer_choice)

    if win?(choice, computer_choice)
      player_score += 1
    elsif win?(computer_choice, choice)
      cpu_score += 1
    end

    updates = "   You: #{player_score} <> Machine: #{cpu_score}"
    puts " "
    puts updates.bold.red

    break if player_score == 5 || cpu_score == 5
  end
  flashing_won = "   YOU WON!  YOU WON!  YOU WON!"
  machine_won = "   The machine whooped you!    "
  puts " "

  if player_score > cpu_score
    puts flashing_won.bold.red.blink
    prompt("Collect your prize at www.launchschool.com")
  else
    puts machine_won.bold.red
  end
  prompt("Do you want to play again? (y/n)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
prompt("Thank you for playing.")
