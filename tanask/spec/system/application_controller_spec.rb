require 'rails_helper'

RSpec.describe 'ApplicationController', type: :system do
  describe 'error' do
    context 'If the user access unexist task URL' do
      it 'show 404 page' do
        visit 'tasks/hoge'
        expect(page).to have_content('404')
      end
    end
    context 'If the raise 500 error' do
      it 'show 500 page' do
        allow(Task).to receive(:all).and_throw(ActiveModel::Errors)
        visit 'tasks/'
        expect(page).to have_content('500')
      end
    end
  end
end
