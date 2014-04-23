# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    desc "MyString"
    deadline "2014-04-09"
    completed false
    priority 1
  end
end
