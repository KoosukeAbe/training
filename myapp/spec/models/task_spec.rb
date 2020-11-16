require 'rails_helper'

RSpec.describe Task, type: :model do

  context 'without user' do
    it 'invalid' do
      task = Task.new(title: 'ttt')
      expect(task).not_to be_valid
    end
  end

  context 'with user' do
    let(:user) { create(:user) }

    it 'empty title' do
      task = Task.new(user: user)
      expect(task).not_to be_valid
    end

    it 'title exceed max length' do
      task = Task.new(title: 't' * 101)
      expect(task).not_to be_valid
    end

    it 'description exeed max length' do
      task = Task.new(title: 't', description: 'd' * 2001)
      expect(task).not_to be_valid
    end

    it 'valid' do
      task = Task.new(user: user, title: 't' * 100, description: 'd' * 2000)
      expect(task).to be_valid
    end
  end

end
