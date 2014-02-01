require 'cinch'

class IRCLogger
  def initialize(server)
    bot = Cinch::Bot.new do
      configure do |c|
        c.server = server.host
        c.nick   = 'baku_bot'
        c.channels = server.channels.pluck(:name)
        c.encoding = server.encoding
      end

      on :message, /.*/ do |m, channel|
        channel = Channel.find_by(name: m.channel.name)
        message = Message.new(channel_id: channel.id, user: m.user.nick, text: m.message, command: m.command)
        message.save!
      end
    end

    bot.start
  end
end

Server.all.find_each do |server|
  IRCLogger.new(server)
end