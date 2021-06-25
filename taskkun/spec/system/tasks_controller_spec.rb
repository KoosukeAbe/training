require 'rails_helper'

RSpec.describe TasksController, type: :system do
  let!(:task1) { create(:task)}
  let!(:task2) { create(:task)}
  let!(:task3) { create(:task)}

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
          expect(page).to have_content 'タスク作成'
        end
      end

      context 'go to the task detail' do
        it 'click each tasks' do
          click_on 'Task Version7'
          expect(page).to have_content 'タスク詳細'
        end
      end
    end

    describe 'show' do
      before do
        visit task_path(task1)
      end

      it 'display task detail' do
        expect(page).to have_content 'タスク詳細'
        expect(page).to have_content 'Task Version10'
      end
            
      context 'go to the edit page' do
        it 'click edit button' do
          click_on 'change'
          expect(page).to have_content 'タスク編集'
        end
      end
    end

    describe 'new' do
      before do
        visit new_task_path
      end

      it 'display create form' do
        expect(page).to have_content 'タスク作成'
      end

      context 'create task' do
        let(:submit) { "Create Task" }

        it 'click create button' do
          fill_in 'task_title', with: 'teeeest'
          fill_in 'task_description', with: 'super ultra test'
          fill_in 'task_due_date', with: "002020/12/12"
          click_on submit
          expect(page).to have_content('teeeest')
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
        let(:submit) { "Update Task" }
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
          click_on 'delete'
          expect {
            expect(page).to_not have_content('test_task28')
          }
        end
      end
    end
  end
end
