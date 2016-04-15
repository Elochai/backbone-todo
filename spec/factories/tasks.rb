# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    desc {Faker::Name.title}
    deadline nil
    completed false
    priority {Faker::Number.digit}
    todo_list_id nil
  end
end
