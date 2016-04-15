class BackboneTodo.Routers.TodoListsRouter extends Backbone.Router
  initialize: (options) ->
    @todoLists = new BackboneTodo.Collections.TodoListsCollection()
    @todoLists.reset options.todoLists
    
  routes:
    "index"    : "index"
    "todo_lists/:id/edit" : "editTodoList"
    "todo_lists/:todo_list_id/tasks/:id/edit" : "editTask"
    ".*"        : "index"

  index: ->
    @view = new BackboneTodo.Views.TodoLists.IndexView(collection: @todoLists)
    $("#main").html(@view.render().el)

  editTodoList: (id) ->
    todoList = @todoLists.get(id)
    @view = new BackboneTodo.Views.TodoLists.EditView(model: todoList)
    $("#main").html(@view.render().el)

  editTask: (todo_list_id, id) ->
    todoList = @todoLists.get(todo_list_id)
    task = todoList.get('tasks').get(id)
    @view = new BackboneTodo.Views.Tasks.EditView(model: task)
    $("#main").html(@view.render().el)
