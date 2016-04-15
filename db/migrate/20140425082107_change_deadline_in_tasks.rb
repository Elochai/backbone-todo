class ChangeDeadlineInTasks < ActiveRecord::Migration
  def change
    change_table(:tasks) do |t|
      t.change :deadline, :string 
    end
  end
end
