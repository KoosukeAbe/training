require 'rails_helper'

RSpec.describe TasksController, type: :system do
  let!(:task1) { create(:task, created_at: DateTime.new(2021, 1, 1, 0, 0, 0).in_time_zone, due_date: '2021-06-01', status_id: 1)}
  let!(:task2) { create(:task, created_at: DateTime.new(2021, 2, 1, 0, 0, 0).in_time_zone, due_date: '2021-07-01', status_id: 2)}
  let!(:task3) { create(:task, created_at: DateTime.new(2021, 3, 1, 0, 0, 0).in_time_zone, due_date: '2021-08-01', status_id: 3)}

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
          expect(all('div a')[3].text).to have_content('Task Version12')
          expect(all('div a')[4].text).to have_content('Task Version11')
          expect(all('div a')[5].text).to have_content('Task Version10')
        end
      end

      context 'sort based on created_at' do
        it 'click created_sort link' do
          click_on '期日順'
          expect(all('div a')[3].text).to have_content('Task Version15')
          expect(all('div a')[4].text).to have_content('Task Version14')
          expect(all('div a')[5].text).to have_content('Task Version13')
        end
      end

      context 'search by title' do
        it 'input title and push submit' do
          fill_in 'title', with: 'Task Version16'
          click_on '検索開始'
          expect(page).to have_content 'Task Version16'
        end
      end

      context 'search by status' do
        it 'select status and push submit' do
          select '着手中'
          click_on '検索開始'
          expect(page).to have_content 'Task Version20'
        end
      end
    end

    describe 'show' do
      before do
        visit task_path(task1)
      end

      it 'display task detail' do
        expect(page).to have_content 'タスク詳細'
        expect(page).to have_content 'Task Version22'
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
        let(:submit) { '登録する' }

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
          fill_in 'task_due_date', with: '002020/12/12'
          click_on submit

          expect(page).to have_content('エラｱｱｱｱｱｱｱｱｱ')
          expect(page).to have_content('Titleは1文字以上で入力してください')
        end

        it 'when task description length is over limit in jp' do
          fill_in 'task_title', with: 'test'
          fill_in 'task_description', with: ('あ' * 86)
          fill_in 'task_due_date', with: '002020/12/12'
          click_on submit

          expect(page).to have_content('エラｱｱｱｱｱｱｱｱｱ')
          expect(page).to have_content('Descriptionは255バイト以内で入力してください')
        end

        it 'when task description length is over limit in en' do
          fill_in 'task_title', with: 'test'
          fill_in 'task_description', with: ('a' * 256)
          fill_in 'task_due_date', with: '002020/12/12'
          click_on submit

          expect(page).to have_content('エラｱｱｱｱｱｱｱｱｱ')
          expect(page).to have_content('Descriptionは255バイト以内で入力してください')
        end

        it 'when task description length is within limit in jp' do
          fill_in 'task_title', with: 'kono test ha ikerude'
          fill_in 'task_description', with: ('あ' * 85)
          fill_in 'task_due_date', with: '002020/12/12'
          click_on submit

          expect(page).to have_content('kono test ha ikerude')
        end

        it 'when task description length is within limit in en' do
          fill_in 'task_title', with: 'kono test ha ikerude'
          fill_in 'task_description', with: ('a' * 255)
          fill_in 'task_due_date', with: '002020/12/12'
          click_on submit

          expect(page).to have_content('kono test ha ikerude')
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
        let(:submit) { '更新する' }
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
