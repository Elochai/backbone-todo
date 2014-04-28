class TodoListsController < ApplicationController
  load_and_authorize_resource
  respond_to :json

  # POST /todo_lists
  # POST /todo_lists.json
  def create
    respond_with current_user.todo_lists.create todo_list_params
  end

  # PATCH/PUT /todo_lists/1
  # PATCH/PUT /todo_lists/1.json
  def update
    respond_with @todo_list.update(todo_list_params)
  end

  # DELETE /todo_lists/1
  # DELETE /todo_lists/1.json
  def destroy
    respond_with @todo_list.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_list_params
      params.require(:todo_list).permit(:name, {:user_id => ["1"]})
    end
end
