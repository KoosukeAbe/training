require 'rails_helper'

RSpec.describe 'ApplicationControllers', js:true, type: :system do
  describe 'error' do
    context 'If the user access unexist task URL' do
      it 'show 404 page' do
        visit 'tasks/hoge'
        # expect(page.status_code).to eq 404
        # expect(response.response_code).to eq(404)
        # expect(response).to have_http_status(404)
        # p(response)
        expect(response).to render_template(file: "#{Rails.root}/app/views/errors/404")
      end
    end
  end
end
