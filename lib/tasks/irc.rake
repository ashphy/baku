namespace :irc do

  desc "Run IRC Logger"

  task :log => :environment do
    require_relative '../../bin/irc_logger'
  end
end
