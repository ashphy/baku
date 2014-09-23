Baku - The IRC Logger
======
[![Build Status](https://travis-ci.org/ashphy/baku.svg?branch=master)](https://travis-ci.org/ashphy/baku)
[![Code Climate](https://codeclimate.com/github/ashphy/baku/badges/gpa.svg)](https://codeclimate.com/github/ashphy/baku)

Share all knowledge, devour it.

## Features
- IRC Logging
- Beautiful Web Interface
- Full-text log search

## Development
### Running Local IRC Server
```
ngircd
```

### Logger Daemon
```
bundle install
bundle exec ruby bin/irc_logger.rb start
```

### Web Interface
```
bundle exec rails s
```

View at: http://localhost:3000/

## Test
```
bundle exec rake spec
```
