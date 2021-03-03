# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe '#task' do
    it 'create task' do
      visit new_task_path
      fill_in 'task_title', with: 'title'
      fill_in 'task_detail', with: 'detail'
      fill_in 'task_status', with: '1'
      fill_in 'task_priority', with: '1'

      click_button I18n.t('helpers.submit.create')
      expect(page).to have_content'title'
    end

    it 'update task' do
      task = create(:task)
      visit edit_task_path(task)

      fill_in 'task_title', with: 'sample'
      expect(page).to have_field 'task_detail', with: 'detail'
      click_button I18n.t('helpers.submit.update')

      expect(page).to have_content 'sample'
    end
  end
end
