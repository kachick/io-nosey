# io-nosey

![Build Status](https://github.com/kachick/io-nosey/actions/workflows/test_behaviors.yml/badge.svg?branch=main)
[![Gem Version](https://badge.fury.io/rb/io-nosey.png)](http://badge.fury.io/rb/io-nosey)

Tiny assistant for CUI operations.

## Usage

Require Ruby 2.6 or later

This command will install latest version into your machines

```shell
gem install 'io-nosey'
```

### Overview

Try below scenario on REPL. Or execute this repository's [./bin/console](bin/console)

```ruby
require 'io/nosey'

parker = IO::Nosey::Parker.new

# input validation
parker.ask('What\'s your name?("first_name last_name"): ', input: /\A\w+ \w+\z/)

# mix the validations and procedures
parker.ask('How old are you?: ',
  input:  /\A(\d+)\z/,
  parse:  ->s{Integer s},
  return: 10..100
)

# default value
parker.ask("What's your favorite?: ", default: 'ruby')

# yes or no
parker.agree?('Do you like this API?: ')

# for password and secrets
parker.ask("What's your password?: ", echo: false)

# choose one from collections
parker.choose('Which Five do you like?: ',
  5 => '5 is a Integer',
  'five' => '"five" is a String',
  :FIVE  => ':FIVE is a Symbol'
)

# multi line mode
parker.ask('Write your poem and exit ctrl+d :) ', multi_line: true)
```

## Features

* #ask
* #agree?
* #choose

### #ask option parameter

input -> parse -> return

1. input     # validation for input string
2. parse     # procedure for input string
3. return    # validation for return value

Other

* default    # when null input
* echo       # set "echo is (true or false)"
* error      # change error message when invalid input
* multi_line # prefer multi_line mode for inputs(exit via ctrl+d)

## Links

* [Repository](https://github.com/kachick/io-nosey)
* [API documents](https://kachick.github.io/io-nosey/)
