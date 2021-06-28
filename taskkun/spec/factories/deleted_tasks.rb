FactoryBot.define do
  factory :deleted_task do
    title { 'MyString' }
    description { 'MyText' }
    importance { '' }
    due_date { '2021-06-24' }
  end
end
