FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    uid { "MyString" }
    token { "MyString" }
  end
end
