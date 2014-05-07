class TasksController < ApplicationController
  load_and_authorize_resource
  respond_to :json

  # POST /tasks
  # POST /tasks.json
  def create
    respond_with Task.create task_params
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_with @task.update(task_params)
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    respond_with @task.destroy
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:desc, :deadline, :completed, :priority, :todo_list_id)
    end
end
