Baku - The IRC Logger
======
[![Build Status](https://travis-ci.org/ashphy/baku.svg?branch=master)](https://travis-ci.org/ashphy/baku)
[![Code Climate](https://codeclimate.com/github/ashphy/baku/badges/gpa.svg)](https://codeclimate.com/github/ashphy/baku)

Share all knowledge, devour it.

## Features
- IRC Logging
- Beautiful Web Interface
- Full-text log search

## Setup
### Requirements
- Ruby 2.3+
- MySQL 5.5+ or MariaDB 5.5+ or Percona Server 5.5+
- Mroonga 6+
- Rack HTTP Server(Passenger, Unicorn or Puma)

### Instructions
#### Setup Web Server
Passenger + Apache2 is the popular combination. See instructions https://www.phusionpassenger.com/library/install/apache/install/oss/

#### Deploy Application
```
git clone https://github.com/ashphy/baku.git
bundle install --without development test 
```

#### Setup Database
Baku uses mroonga for Japanase Full-Text search.
http://mroonga.org/docs/install.html

Create the baku database.
```
RAILS_ENV=production bundle exec rails db:setup
```

#### Configurations
- Make config/bot.yml from bot.yml.sample
- Make config/database.yml from database.yml.sample
- Make config/ldap.yml from ldap.yml.sample

Register the channel where you want to log on the web ui.
Admin's account is located at db/seeds/production/users.rb

#### Launch Logger Deamon
```
RAILS_ENV=production bundle exec bin/irc_logger.rb start
```

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
