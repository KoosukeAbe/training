require 'rails_helper'

RSpec.describe 'TasksControllers', type: :system do
  # let!(:task1) { create(:task_template, name: 'test_name1', description: 'test_description1') }
  # let!(:task2) { create(:task_template, name: 'test_name2', description: 'test_description2') }

  describe 'index' do

    it 'show Task List' do
      visit '/tasks'
      expect(page).to have_content('タスク一覧')
    end

    it 'can go to new task page' do
      visit '/tasks'
      click_on 'Make New Task'
      expect(page).to have_content('タスク登録')
    end

    context 'If the user has a task' do
      let!(:task1) { create(:task_template, name: 'test_name1', description: 'test_description1') }
      it 'show test_name1' do
        visit '/tasks'
        expect(page).to have_content('test_name1')
      end
    end
  end

  context 'If the use has three tasks' do
    let!(:task1) { create(:task_template, name: 'first', description: 'test_description') }
    let!(:task2) { create(:task_template, name: 'second', description: 'test_description') }
    let!(:task3) { create(:task_template, name: 'third', description: 'test_description') }
    it 'order according to updated_at' do
      visit '/tasks'
      expect(all('tbody tr')[0].text).to have_content("third")
      expect(all('tbody tr')[1].text).to have_content("second")
      expect(all('tbody tr')[2].text).to have_content("first")
    end

  end

  describe 'show' do
    context 'If the user has a task' do
      let!(:task1) { create(:task_template, name: 'test_name1', description: 'test_description1') }
      it 'show detail page' do
        visit task_path(task1)
        expect(page).to have_content('タスク詳細')
      end
    end
  end

  describe 'new' do
    before do
      visit '/tasks/new'
    end
    it 'show new task page' do
      expect(page).to have_content('タスク登録')
    end

    context 'When task create' do
      it 'can add new task' do
        fill_in 'Name', with: 'newtask1'
        fill_in 'Description', with: 'newdescription1'
        click_on '提出'
        expect(page).to have_content('newtask1')
      end
    end
  end

  describe 'edit' do
    let!(:task1) { create(:task_template, name: 'test_name1', description: 'test_description1') }
    before do
      visit edit_task_path(task1)
    end

    context 'when user has task' do
      it 'can see detail page' do
        expect(page).to have_content('タスク編集')
      end

      it 'cat edit task' do
        fill_in 'Name', with: 'edited_task1'
        fill_in 'Description', with: 'edited_description1'
        click_on '提出'
        expect(page).to have_content('edited_task1')
      end
    end
  end

  describe 'delete' do
    context 'when user has task' do
      let!(:task1) { create(:task_template, name: 'test_name1', description: 'test_description1') }
      let!(:task2) { create(:task_template, name: 'test_name2', description: 'test_description2') }
      it 'can delete' do
        visit task_path(task2)
        click_on 'Delete this task'
        expect {
          expect(page.accept_confirm)
          expect(page).to_not have_content('test_task2')
        }
      end
    end
  end
end
