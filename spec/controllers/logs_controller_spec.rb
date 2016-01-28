require 'rails_helper'

describe LogsController, :type => :controller do
  describe 'GET index' do
    context 'when the channel that has empty log is showed' do
      before do
        create(:channel)
      end

      it 'shows empty log message' do
        get :index
        expect(response).to render_template('index')
      end
    end
  end
end
