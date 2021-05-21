require 'rails_helper'

RSpec.describe 'ApplicationControllers', js:true, type: :system do
  describe 'error' do
    context 'If the user access unexist task URL' do
      it 'show 404 page' do
        visit 'tasks/hoge'
        expect(page).to have_content('404')
      end
    end
  end
end
