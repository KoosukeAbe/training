FactoryBot.define do
  factory :user do
    name { 'hogehoge' }
    email { 'hoge@fuga.com' }
    password { 'hoge123' }
    role { 0 }
  end
end
