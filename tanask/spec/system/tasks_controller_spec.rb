require 'rails_helper'
require 'date'

RSpec.describe 'TasksControllers', type: :system do
  describe 'index' do
    it 'show Task List' do
      visit '/tasks'
      expect(page).to have_content('タスク一覧')
    end

    it 'can go to new task page' do
      visit '/tasks'
      click_on 'Make New Task'
      expect(page).to have_content('タスク登録')
      expect(current_path).to eq new_task_path
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
    let!(:task1) { create(:task_template, name: 'first', description: 'test_description', created_at: DateTime.new(2021, 1, 1, 0, 0, 0)) }
    let!(:task2) { create(:task_template, name: 'second', description: 'test_description', created_at: DateTime.new(2021, 2, 1, 0, 0, 0)) }
    let!(:task3) { create(:task_template, name: 'third', description: 'test_description', created_at: DateTime.new(2021, 3, 1, 0, 0, 0)) }
    it 'order according to updated_at' do
      visit '/tasks'
      expect(all('tbody tr')[0].text).to have_content('third')
      expect(all('tbody tr')[1].text).to have_content('second')
      expect(all('tbody tr')[2].text).to have_content('first')
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

      context 'When task have no name' do
        it 'show validation error and flash' do
          fill_in 'Name', with: ''
          fill_in 'Description', with: 'newdescription1'
          click_on '提出'
          expect(page).to have_content('タスクの登録に失敗しました')
          expect(page).to have_content('タスク名を入力してください')
          expect(page).to have_content('タスク名は1文字以上で入力してください')
        end
      end
      context 'When task have too long name (51chars)' do
        it 'show validation error and flash' do
          fill_in 'Name', with: 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
          fill_in 'Description', with: 'newdescription1'
          click_on '提出'
          expect(page).to have_content('タスクの登録に失敗しました')
          expect(page).to have_content('タスク名は50文字以内で入力してください')
        end
      end
      context 'When task have too long description (101chars)' do
        it 'show validation error and flash' do
          fill_in 'Name', with: 'newname1'
          fill_in 'Description', with: 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
          click_on '提出'
          expect(page).to have_content('タスクの登録に失敗しました')
          expect(page).to have_content('タスク概要は100文字以内で入力してください')
        end
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
    end

    context 'when user has task' do
      it 'cat edit task' do
        fill_in 'Name', with: 'edited_task1'
        fill_in 'Description', with: 'edited_description1'
        click_on '提出'
        expect(page).to have_content('edited_task1')
        expect(page).to have_content('タスクが更新されました')
        expect(current_path).to eq task_path(task1)
      end
    end

    context 'when user make no name task' do
      it 'show error' do
        fill_in 'Name', with: ''
        fill_in 'Description', with: 'edited_description1'
        click_on '提出'
        expect(page).to have_content('タスクの更新に失敗しました')
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
