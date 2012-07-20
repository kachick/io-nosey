$VERBOSE = true

# setup
require_relative '../lib/io/nosey'

include IO::Nosey

def show(obj)
  puts "This script understands your input: #{obj.inspect}"
end

# with input validation
name = ask 'What\'s your name?("firstname lastname")', input: /\A\w+ \w+\z/
show name

# with default value
answer = ask "What's your favorite?", default: 'ruby'
show answer

# handle return value
age = ask 'How old are you?', input:   /\A(\d+)\z/,
                              parse:   ->s{Integer s},
                              return: 10..100
show age

# yes or no
bool = agree? 'Do you like this API?'
show  bool

# get password
password = ask "What's your password?", echo: false
show password

# choose one
choice =  \
    choose 'Which Five do you like?',  5     => '5 is a Integer',
                                      'five' => '"five" is a String',
                                      :FIVE  => ':FIVE is a Symbol'
show choice
