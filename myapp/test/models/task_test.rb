require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "should not save task without name" do
    task = Task.new
    task.status = 1
    assert_not task.save
  end

  test "should not save task with name length exceed 50" do
    task = Task.new
    task.name = 'a' * 51
    assert_not task.save
  end

  test "should save with valid length for name" do
    task = Task.new
    task.name = 'a' * 50
    assert task.save
  end

  test "should save task with valid data" do
    task = Task.new
    task.name = "valid name."
    task.status = 1
    assert task.save
  end

end
