class BackboneTodo.Routers.TodoListsRouter extends Backbone.Router
  initialize: (options) ->
    @todoLists = new BackboneTodo.Collections.TodoListsCollection()
    @todoLists.reset options.todoLists
    
  routes:
    "index"    : "index"
    ".*"        : "index"

  index: ->
    @view = new BackboneTodo.Views.TodoLists.IndexView(collection: @todoLists)
    $("#main").html(@view.render().el)

