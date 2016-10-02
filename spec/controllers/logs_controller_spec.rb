# frozen_string_literal: true
require 'rails_helper'

describe LogsController, type: :controller do
  describe 'GET index' do
    context 'when the channel that has empty log is showed' do
      before do
        create(:channel)
      end
    end
  end
end
