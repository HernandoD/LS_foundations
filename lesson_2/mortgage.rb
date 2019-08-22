def prompt(message)
  Kernel.puts("->> #{message} ")
end

# goal is to only accept a positive integer
# no less tham 1000, no more than 100M
def valid_number?(num)
  (num.to_i.to_f > 0) && (num.length > 3) && (num.length < 9)
end

def apr_valid?(input)
  (input.to_f > 0) && (input.to_f <= 100.00)
end

def duration_transform(option)
  if option == "1"
    180
  else
    360
  end
end

prompt "Welcome to HDR Mortgage Calculator"
prompt "Make estimating your monthly payment easy."

prompt "Whats your name?"

name = ""
loop do
  name = gets.chomp
  if name.empty?
    puts "Sorry, I didn't catch that. Please enter a valid name."
  else
    break
  end
end

prompt "Hi, #{name}. Nice to meet you! Lets begin."

loan = ''
loop do
  loop do
    prompt "Please enter your loan amount: (No commas please)"
    loan = gets.chomp
    if valid_number?(loan)
      break
    else
      puts "Please enter a valid number."
    end
  end

  apr = ""

  loop do
    prompt "Please enter the APR%."
    apr = gets.chomp
    if apr_valid?(apr)
      break
    else
      if apr < 0
        puts "Interest rate too low."
      else
        puts "APR% is too high."
      end
    end
  end

  duration_prompt = <<-MSG
Now enter the type of mortgage you'd like. (Choose 1 or 2)
    1. 15-year Fixed
    2. 30-year Fixed
    MSG
  prompt(duration_prompt)

  duration_year = ''
  loop do
    duration_year = gets.chomp
    if %w(1 2).include?(duration_year)
      break
    else
      puts "Please choose either 1) 15-year Fixed or 2) 30-year Fixed"
    end
  end

  annual_interest_rate = apr.to_f / 100
  monthly_interest = annual_interest_rate / 12
  months = duration_transform(duration_year)

  prompt "Calculating..."

  result = loan.to_f * (monthly_interest /
    (1 - (1 + monthly_interest)**(-months)))

  prompt "Your monthly payment is: $#{format('%02.2f', result)}"
  prompt "Do you want to re-calculate?"
  answer = gets.chomp

  if answer.downcase.start_with?("y")
    puts "Great, #{name}. Let's start over."
  else
    break
  end
end

prompt "Thanks for using HDR Mortgage Calculator."
prompt "Have a great day!"
