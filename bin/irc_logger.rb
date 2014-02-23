#!/usr/bin/env ruby
require File.expand_path('../../config/application', __FILE__)
Rails.application.require_environment!

# Log the channel message
class LogBot
  include Cinch::Plugin

  listen_to :channel, method: :on_notice
  listen_to :message, method: :save_message
  listen_to :topic,   method: :save_message

  def save_message(m)
    ActiveRecord::Base.connection_pool.with_connection do
      channel = Channel.find_by(name: m.channel.name)
      message = Message.new(
        channel_id: channel.id,
        user: m.user.nick,
        text: m.message,
        command: m.command
      )
      message.save
    end
  end

  def on_notice(m)
    if m.command == 'NOTICE'
      ActiveRecord::Base.connection_pool.with_connection do
        channel = Channel.find_by(name: m.channel.name)
        message = Message.new(
          channel_id: channel.id,
          user: m.user.nick,
          text: m.params[1],
          command: 'NOTICE'
        )
        message.save
      end
    end
  end
end

# When invite, join the channel
class InviteBot
  include Cinch::Plugin

  listen_to :invite,  method: :on_invite
  def on_invite(m)
    Channel(m.channel).join
    ActiveRecord::Base.connection_pool.with_connection do
      server = Server.all.first
      Channel.create_with(server_id: server.id).find_or_create_by(name: m.channel.name)
    end
  end
end

# Hello baku_bot!
class GreetingBot
  include Cinch::Plugin

  match /baku_bot/, use_prefix: false, method: :on_greetings
  def on_greetings(m)
    m.channel.notice "Baku is a IRC logger. I'm recording this channel now."
  end
end

# Hidden Operation Commands
class CommandBot
  include Cinch::Plugin

  match 'baku give me op', use_prefix: false, method: :on_operations
  def on_operations(m)
    m.channel.op(m.user)
  end
end

# baku_bot
class IRCLogger
  def initialize(server)
    bot = Cinch::Bot.new do
      configure do |c|
        c.server = server.host
        c.nick   = 'baku_bot'
        c.channels = server.channels.actives.pluck(:name)
        c.encoding = server.encoding
        c.plugins.plugins  = [LogBot, GreetingBot, CommandBot, InviteBot]
      end
    end

    bot.start
  end
end

# Bot Deamon
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

ResqueWorkerDaemon.spawn!(
  processes:   1,
  working_dir: Rails.root,
  pid_file:    File.join(Rails.root, 'tmp', 'pids', 'baku_irc_logger.pid'),
  log_file:    File.join(Rails.root, 'log', 'baku_irc_logger.log'),
  sync_log:    true,
  singleton:   true,
  signal:      'QUIT'
)
