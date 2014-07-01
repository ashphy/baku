Baku - The IRC Logger
======
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
