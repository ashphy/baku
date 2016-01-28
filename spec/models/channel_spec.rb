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
#  key        :string(255)
#

require 'rails_helper'

describe Channel, :type => :model do
  it { expect(subject).to belong_to(:server) }
end
