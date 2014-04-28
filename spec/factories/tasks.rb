# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    desc "task_desc"
    deadline "today"
    completed false
    priority 1
  end
end
