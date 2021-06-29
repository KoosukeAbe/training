require 'rails_helper'

RSpec.describe TasksController, type: :system do
  let!(:task1) { create(:task, created_at: DateTime.new(2021, 1, 1, 0, 0, 0).in_time_zone, due_date: '2021-06-01') }
  let!(:task2) { create(:task, created_at: DateTime.new(2021, 2, 1, 0, 0, 0).in_time_zone, due_date: '2021-07-01') }
  let!(:task3) { create(:task, created_at: DateTime.new(2021, 3, 1, 0, 0, 0).in_time_zone, due_date: '2021-08-01') }

  describe 'Task CRUD' do
    describe 'index' do
      before do
        visit root_path
      end

      it 'display task list' do
        expect(page).to have_content 'タスクリスト'
        expect(page).to have_content 'Task Version1'
        expect(page).to have_content 'Task Version2'
        expect(page).to have_content 'Task Version3'
      end

      context 'go to the create page' do
        it 'click create button' do
          click_on 'おNEW'
          expect(page).to have_content '新規タスク'
        end
      end

      context 'go to the task detail' do
        it 'click each tasks' do
          click_on 'Task Version7'
          expect(page).to have_content 'タスク詳細'
        end
      end

      context 'sort based on created_at' do
        it 'click created_sort link' do
          click_on '作成日順'
          expect(all('div a')[0].text).to have_content('Task Version12')
          expect(all('div a')[1].text).to have_content('Task Version11')
          expect(all('div a')[2].text).to have_content('Task Version10')
        end
      end

      context 'sort based on created_at' do
        it 'click created_sort link' do
          click_on '期日順'
          expect(all('div a')[0].text).to have_content('Task Version15')
          expect(all('div a')[1].text).to have_content('Task Version14')
          expect(all('div a')[2].text).to have_content('Task Version13')
        end
      end
    end

    describe 'show' do
      before do
        visit task_path(task1)
      end

      it 'display task detail' do
        expect(page).to have_content 'タスク詳細'
        expect(page).to have_content 'Task Version16'
      end

      context 'go to the edit page' do
        it 'click edit button' do
          click_on 'おチェンジ'
          expect(page).to have_content 'タスク編集'
        end
      end
    end

    describe 'new' do
      before do
        visit new_task_path
      end

      it 'display create form' do
        expect(page).to have_content '新規タスク'
      end

      context 'create task' do
        let(:submit) { "登録する" }

        it 'correct process' do
          fill_in 'task_title', with: 'teeeest'
          fill_in 'task_description', with: 'super ultra test'
          fill_in 'task_due_date', with: '002020/12/12'
          click_on submit
          expect(page).to have_content('teeeest')
        end

        it 'when task title is no name' do
          fill_in 'task_title', with: ''
          fill_in 'task_description', with: 'super ultra test'
          fill_in 'task_due_date', with: "002020/12/12"
          click_on submit

          expect(page).to have_content('エラｱｱｱｱｱｱｱｱｱ')
          expect(page).to have_content('Titleは1文字以上で入力してください')
        end

        it 'when task description length is over limit' do
          fill_in 'task_title', with: 'test'
          fill_in 'task_description', with: 'ああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ'
          fill_in 'task_due_date', with: "002020/12/12"
          click_on submit

          expect(page).to have_content('エラｱｱｱｱｱｱｱｱｱ')
          expect(page).to have_content('Descriptionは255文字以内で入力してください')
        end

        it 'when task due date is not inputted' do
          fill_in 'task_title', with: 'test'
          fill_in 'task_description', with: 'testest'
          click_on submit

          expect(page).to have_content('エラｱｱｱｱｱｱｱｱｱ')
          expect(page).to have_content('Due dateは不正な値です')
        end
      end
    end

    describe 'edit' do
      before do
        visit edit_task_path(task1)
      end

      it 'display edit form' do
        expect(page).to have_content 'タスク編集'
      end

      context 'update task' do
        let(:submit) { 'Update Task' }
        it 'click update button' do
          fill_in 'task_title', with: 'Task Version2020'
          fill_in 'task_description', with: 'super ultra Test2020'
          click_on submit
          expect(page).to have_content('Task Version2020')
        end
      end
    end

    describe 'destroy' do
      context 'delete task' do
        it 'click delete button' do
          visit task_path(task1)
          click_on 'おデリート'
          expect {
            expect(page).to_not have_content('test_task28')
          }
        end
      end
    end
  end
end
