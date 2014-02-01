require_relative '../../bin/irc_logger'

namespace :irc do

  desc "Generate report"

  task :log => :environment do
    # 処理を記述
    #ReportGenerator.generate
    puts 'log'
    IRCLogger.new
  end
end
