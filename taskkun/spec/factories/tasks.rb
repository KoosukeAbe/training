FactoryBot.define do
    factory :task do
        sequence(:id) { |n| n}
        sequence(:title) { |n| "Task Version#{n}"}
        sequence(:description) { |n| "This is Task Version#{n}"}
        sequence(:importance) { |n| n}
        due_date {'2021-06-23'}
    end
end