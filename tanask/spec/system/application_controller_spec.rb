require 'rails_helper'

RSpec.describe 'ApplicationControllers', type: :system do
  describe 'error' do
    context 'If the user access unexist task URL' do
      it 'show 404 page' do
        visit 'tasks/hoge'
        # expect(ErrorHandlers).to receive(:resque404).once
        expect(response).to have_http_status(404)
        # expect(ErrorsController).to receive(:routeing_error).once
      end
    end
  end
end
