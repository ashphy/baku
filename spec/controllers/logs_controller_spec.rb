require 'spec_helper'

describe LogsController do
  describe 'GET index' do
    it 'renders the index template' do
      allow_any_instance_of(Channel).to receive(:all)
      get :index
      expect(response).to render_template("index")
    end
  end
end
