require 'spec_helper'

describe Channel, :type => :model do
  it { expect(subject).to belong_to(:server) }
end
