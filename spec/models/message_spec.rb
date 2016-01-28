# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  channel_id :integer
#  text       :string(512)
#  user       :string(20)       not null
#  command    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe Message, :type => :model do

  let(:user) { 'test' }
  let(:text) { 'text' }
  let(:command) { 'PRIVMSG' }
  let(:message) { Message.new(user: user, text: text, command: command) }

  it 'PRIVMSG should save' do
    expect(message.save).to be_truthy
    expect(message.user).to eq(user)
    expect(message.text).to eq(text)
    expect(message.command).to eq(command)
  end

  it 'NOTICE should save' do
    message.command = 'NOTICE'
    expect(message.save).to be_truthy
    expect(message.command).to eq('NOTICE')
  end

  it 'invalid command should not save' do
    message.command = 'hoge'
    expect(message.save).to be_falsey
  end

  it 'empty user should not save' do
    message.user = nil
    expect(message.save).to be_falsey
    message.user = ''
    expect(message.save).to be_falsey
  end

  it 'empty user should not save' do
    message.text = nil
    expect(message.save).to be_falsey
    message.text = ''
    expect(message.save).to be_falsey
  end

  it 'long message should save' do
    message.text = 'a' * 512
    expect(message.save).to be_truthy
  end

  it 'longest message should save' do
    message.text = 'a' * 513
    expect(message.save).to be_falsey
  end
end
