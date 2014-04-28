class Task < ActiveRecord::Base
  belongs_to :todo_list
  validates :desc, :priority, presence: true
end
