#!/usr/bin/env ruby
require File.expand_path('../../config/application', __FILE__)
Rails.application.require_environment!

require_relative 'bot_settings'

# Log the channel message
class BakuBot
  include Cinch::Plugin

  set :prefix, lambda{ |m| Regexp.new('^' + Regexp.escape(m.bot.nick + ' '))}

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

  listen_to :channel, method: :on_notice
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

  listen_to :invite,  method: :on_invite
  def on_invite(m)
    Channel(m.channel).join
    ActiveRecord::Base.connection_pool.with_connection do
      server = Server.all.first
      channel = Channel.create_with(server_id: server.id).find_or_create_by(name: m.channel.name)
      unless channel.active?
        channel.active = true
        channel.save
      end
    end
  end

  listen_to :leaving, method: :on_leaving
  def on_leaving(m, user)
    if m.command == 'KICK' && user.nick == m.bot.nick
      stop_recording(m)
    end
  end

  match /we can't have you/, method: :on_kick
  def on_kick(m)
    stop_recording(m)
    m.channel.part("OK, I'll find a new home")
  end

  match /give (.*?) op/, method: :on_operations
  def on_operations(m, user)
    if user == 'me'
      m.channel.op(m.user)
    elsif ['all', 'everyone', 'us'].include?(user)
      m.channel.users.each do |u, modes|
        m.channel.op(u) unless modes.include?("o")
      end
    else
      m.channel.op(user)
    end
  end

  match 'help', method: :on_greetings
  def on_greetings(m)
    help = <<-EOS
#{m.bot.nick} is an IRC logger. Please contribute to https://github.com/ashphy/baku
Invite me to start recording the channel, kick me to stop recording.
You can see the logs at #{BotSettings.url}
Commands:
    #{m.bot.nick} give [me|all|everyone|us|NICK] op   Gives one channel operators
    #{m.bot.nick} we can't have you                   Stop recording, and leave from this channel
    #{m.bot.nick} help                                Show this help
    EOS
    help.lines { |h| m.channel.notice h }
  end

  private

  def stop_recording(m)
    ActiveRecord::Base.connection_pool.with_connection do
      channel = Channel.find_by(name: m.channel.name)
      channel.active = false
      channel.save
    end
  end
end

# IRC Logger Process
class IRCLogger
  def initialize(server)
    bot = Cinch::Bot.new do
      configure do |c|
        c.server = server.host
        c.nick   = BotSettings.nick
        c.channels = server.channels.actives.map { |c| c.key? ? "#{c.name} #{c.key}" : c.name }
        c.encoding = server.encoding
        c.plugins.plugins  = [BakuBot]
      end
    end
    bot.start
  end
end

# Bot Daemon
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
