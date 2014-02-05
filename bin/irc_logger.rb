#!/usr/bin/env ruby
require File.expand_path('../../config/application', __FILE__)
Rails.application.require_environment!

class IRCLogger
  def initialize(server)
    bot = Cinch::Bot.new do
      configure do |c|
        c.server = server.host
        c.nick   = 'baku_bot'
        c.channels = server.channels.where(joined: true).pluck(:name)
        c.encoding = server.encoding
      end

      on :message, /.*/ do |m, channel|
        ActiveRecord::Base.connection_pool.with_connection do
          channel = Channel.find_by(name: m.channel.name)
          message = Message.new(channel_id: channel.id, user: m.user.nick, text: m.message, command: m.command)
          message.save!
        end
      end
    end

    bot.start
  end
end

class ResqueWorkerDaemon < DaemonSpawn::Base
  def start(args)
    ActiveRecord::Base.connection_pool.with_connection do
      Server.all.find_each do |server|
        @irc_logger = IRCLogger.new(server)
      end
    end
  end

  def stop
  end
end

ResqueWorkerDaemon.spawn!({
  :processes => 1,
  :working_dir => Rails.root,
  :pid_file => File.join(Rails.root, 'tmp', 'pids', 'baku_irc_logger.pid'),
  :log_file => File.join(Rails.root, 'log', 'baku_irc_logger.log'),
  :sync_log => true,
  :singleton => true,
  :signal => 'QUIT'
})