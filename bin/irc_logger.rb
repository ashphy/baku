require 'cinch'

class IRCLogger
  def initialize
    p 'IRC Bot initilized'

    bot = Cinch::Bot.new do
      configure do |c|
        c.server = "irc.livedoor.ne.jp"
        c.nick   = "baku_bot"
        c.channels = ["#pd2013"]
        c.encoding = "iso-2022-jp"
      end

      on :message, /.*/ do |m, channel|
        p m
        p channel
        p ''

        message = Message.new(user: m.user.nick, text: m.message, command: command)
        message.save!
      end

      # 律儀に出て行ってくれる君
      on :message, /go away(?: (.+))?/ do |m, channel|
        m.reply "#{m.user.nick} said #{m.message}. ok, I'm parting." if m.user.nick == 'masasuzu'

        channel ||= m.channel

        bot.part channel, 'bye'
      end
    end

    p 'IRC Bot started'
    bot.start
  end
end

