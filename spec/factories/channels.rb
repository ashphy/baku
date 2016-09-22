# == Schema Information
#
# Table name: channels
#
#  id         :integer          not null, primary key
#  server_id  :integer
#  name       :string(255)
#  active     :boolean          default(TRUE), not null
#  boolean    :boolean          default(TRUE), not null
#  created_at :datetime
#  updated_at :datetime
#  key        :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :channel do
    name 'foo'
    active true
  end
end
