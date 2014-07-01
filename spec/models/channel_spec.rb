require 'spec_helper'

describe Channel do
  it { expect(subject).to belong_to(:server) }
end
