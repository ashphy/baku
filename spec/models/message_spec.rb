require 'spec_helper'

describe Message do

  let(:user) { 'test' }
  let(:text) { 'text' }
  let(:command) { 'PRIVMSG' }
  let(:message) { Message.new(user: user, text: text, command: command) }

  it 'PRIVMSG should save' do
    message.save.should be_true
    message.user.should be == user
    message.text.should be == text
    message.command.should be == command
  end

  it 'NOTICE should save' do
    message.command = 'NOTICE'
    message.save.should be_true
    message.command.should be == 'NOTICE'
  end

  it 'invalid command should not save' do
    message.command = 'hoge'
    message.save.should be_false
  end

  it 'empty user should not save' do
    message.user = nil
    message.save.should be_false
    message.user = ''
    message.save.should be_false
  end

  it 'empty user should not save' do
    message.text = nil
    message.save.should be_false
    message.text = ''
    message.save.should be_false
  end

  it 'long message should save' do
    message.text = 'a' * 512
    message.save.should be_true
  end

  it 'longest message should save' do
    message.text = 'a' * 513
    message.save.should be_false
  end
end
