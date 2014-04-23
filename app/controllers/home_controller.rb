class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @todo_lists = current_user.todo_lists
  end
end