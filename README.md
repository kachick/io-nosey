io-nosey
==========

[![Build Status](https://secure.travis-ci.org/kachick/io-nosey.png)](http://travis-ci.org/kachick/io-nosey)
[![Gem Version](https://badge.fury.io/rb/io-nosey.png)](http://badge.fury.io/rb/io-nosey)

Description
-----------

A tiny assistant for CUI operations.

Features
--------

* #ask
* #agree?
* #choose
* PureRuby :)

### #ask's option parameter

input -> parse -> return

1. input     # validation for input string
2. parse     # procedure for input string
3. return    # validation for return value

Other

* default    # when null input
* echo       # set "echo is (true or false)"
* error      # change error message when invalid input
* multi_line # prefer multi_line mode for inputs(exit via ctrl+d)

Usage
-----

### Tutorial

Try below senario on REPL(ex. irb, pry) or excute "example/**_tutorial.rb"

```ruby
require 'io/nosey'
include IO::Nosey

# input validation
ask 'What\'s your name?("firstname lastname"): ', input: /\A\w+ \w+\z/

# mix the validations and procedures
ask 'How old are you?: ', input:  /\A(\d+)\z/,
                          parse:  ->s{Integer s},
                          return: 10..100

# default value
ask "What's your favorite?: ", default: 'ruby'

# yes or no
agree? 'Do you like this API?: '

# for password
ask "What's your password?: ", echo: false

# choose one from collections
choose 'Which Five do you like?: ',  5      => '5 is a Integer',
                                   'five' => '"five" is a String',
                                   :FIVE  => ':FIVE is a Symbol'

# multi line mode
ask 'Write your poem and exit ctrl+d :) ', multi_line: true
```

Requirements
-------------

* [Ruby 2.5 or later](http://travis-ci.org/#!/kachick/io-nosey)

Install
-------

```bash
gem install io-nosey
```

Link
----

* [Home](http://kachick.github.com/io-nosey/)
* [code](https://github.com/kachick/io-nosey)
* [API](http://www.rubydoc.info/github/kachick/io-nosey)
* [issues](https://github.com/kachick/io-nosey/issues)
* [CI](http://travis-ci.org/#!/kachick/io-nosey)
* [gem](https://rubygems.org/gems/io-nosey)

License
--------

The MIT X11 License  
Copyright (c) 2011 Kenichi Kamiya  
See MIT-LICENSE for further details.
