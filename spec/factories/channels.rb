# == Schema Information
#
# Table name: channels
#
#  id         :integer          not null, primary key
#  server_id  :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  active     :boolean          default(TRUE), not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :channel do
    name 'foo'
    active true
  end
end
