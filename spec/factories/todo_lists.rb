# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :todo_list do
    name {Faker::Name.title}
    user_id nil
  end
end
