BackboneTodo.Views.TodoLists ||= {}

class BackboneTodo.Views.TodoLists.IndexView extends Backbone.View
  template: JST["backbone/templates/todo_lists/index"]

  events:
    "click #new_todo_list": "save"

  initialize: (options) ->
    @model = new @collection.model()
    options.collection.bind('reset', @addAll, @renderHeader)
    options.collection.bind('add', @addOne, @renderHeader)
    options.collection.bind('add', @renderHeader)
    options.collection.bind('remove', @renderHeader)
    @model.on("change", @addOne)

  addAll: () =>
    @collection.each(@addOne)
    @renderHeader()

  addOne: (todoList) =>
    view = new BackboneTodo.Views.TodoLists.TodoListView({model : todoList})
    @$("#todo_lists").append(view.render().el)
    tasks_view = new BackboneTodo.Views.Tasks.IndexView(tasks: todoList.get('tasks'))
    view.$("tbody#tasks").append(tasks_view.render().el)
    new_task_view = new BackboneTodo.Views.Tasks.NewView(collection: todoList.get('tasks'))
    view.$("#new_task").append(new_task_view.render().el)

  renderHeader: =>
    if @collection.length > 0
      @$('.no_lists').addClass('hidden')
      @$('.have_lists').removeClass('hidden')
    else
      @$('.have_lists').addClass('hidden')
      @$('.no_lists').removeClass('hidden')

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()
    alertify.prompt("Name", 
      (e, str) =>
        if e
          @model = new BackboneTodo.Models.TodoList({name: str})
          @model.unset("errors")
          if @model.isValid() 
            @collection.create(@model,
              error: (todo_list, jqXHR) =>
                @model.set({errors: $.parseJSON(jqXHR.responseText)})
            )
            alertify.success("Todo list was successfully created!")
      , "New todo list")

  render: =>
    $(@el).html(@template(todoLists: @collection.toJSON() ))
    @addAll()
    return this


