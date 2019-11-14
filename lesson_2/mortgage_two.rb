require "colorize"

def prompt(message)
  puts message.bold
end

def space
  puts " "
end

def obtain_name
  loop do
    prompt "Hello. What's your name?"
    puts " "
    name = gets.chomp.strip

    if name.empty? || name =~ /\d/
      prompt "Required. Please enter your name.".red
    else
      space
      prompt "Welcome, #{name}. Let's begin with your loan amount.".bold
      return name
    end
  end
end

def check_for_letters?(string)
  lowercase = ('a'..'z')
  uppercase = ('A'..'Z')
  string.each_char.any? do |char|
    lowercase.cover?(char) || uppercase.cover?(char)
  end
end

def obtain_loan
  loan = ""
  loop do
    prompt "What's your loan amount? (No commas, please.)"
    loan = gets.chomp
    if check_for_letters?(loan) == true
      prompt "Sorry, please include only the loan amount. Let's try again.".red
    elsif loan.empty? || (loan.to_i <= 0 || loan.length < 4)
      prompt "Hey, please enter a valid amount with a minumum of $1000.".red
    else
      prompt "Got it."
      return loan
    end
  end
end

def obtain_apr(name)
  loop do
    prompt "What's your interest rate? (No more than 100%)"
    apr = gets.chomp

    if check_for_letters?(apr)
      prompt "#{name}, please include only a valid interest amount.".red
    elsif apr.empty? || (apr.to_i <= 0 || apr.to_i > 100)
      prompt "Please enter a positive percentage of no more than 100%.".red
    else
      prompt "Great, #{name}. Now, let's factor in the duration of the loan."
      return apr
    end
  end
end

def get_duration_years(name)
  loop do
    prompt "Would you like a mortgage period of 15 or 30 years?"
    prompt "Please type either 15 or 30."
    years = gets.chomp

    if check_for_letters?(years) == true
      puts "#{name}, please include the number of years only.".red
    elsif years.empty? || (years.to_i != 15 && years.to_i != 30)
      puts "#{name}, please enter a valid number of years.".red
    else
      return years
    end
  end
end

AFFIRMATIVE_ANSWERS = %w(y yes yeah absolutely sure ok)
NEGATIVE_ANSWERS = %w(n no nope never not negative)

def play_again?(name)
  answer = ""
  loop do
    prompt "Would you like to make another calculation?"
    space
    answer = gets.chomp.downcase

    if AFFIRMATIVE_ANSWERS.include?(answer)
      return true
    elsif NEGATIVE_ANSWERS.include?(answer)
      return false
    else
      space
      prompt "#{name}, that's not a valid answer.".red
    end
  end
end

def clear
  system('clear') || system('cls')
end

space
welcome = "HDR Mortgage Calculator"
puts welcome.cyan.bold
space
message = "Estimate your monthly mortgage payment."
puts message.underline.bold
space
name = obtain_name
space
arrow = "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts arrow.cyan.bold
sleep 2.1
clear

loop do
  puts arrow.cyan
  space
  loan = obtain_loan
  sleep 1.2
  clear

  puts arrow.cyan.bold
  space
  apr = obtain_apr(name)
  sleep 2.4
  clear

  puts arrow.cyan.bold
  space
  years = get_duration_years(name)
  space
  prompt "Calculating.."
  sleep 2.3
  clear

  monthly_ir = apr.to_f / 100 / 12
  months = years.to_i * 12

  monthly_payment = loan.to_f *
                    (monthly_ir / (1 - (1 + monthly_ir)**(-months)))

  puts arrow.cyan.bold
  space
  pay = "Your monthly payment will be: $#{format('%02.2f', monthly_payment)}"
  puts pay.bold
  space

  break unless play_again?(name) == true

  space

  prompt "Great. Let's start over."
  sleep 1.2
  clear
end

clear
puts arrow.cyan.bold
space
prompt "Thanks for visiting, #{name}. Have a nice day."
space
