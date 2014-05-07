BackboneTodo.Views.TodoLists ||= {}

class BackboneTodo.Views.TodoLists.TodoListView extends Backbone.View
  template: JST["backbone/templates/todo_lists/todo_list"]

  initialize: ->
    @listenTo(@model, 'change', @reRender);

  events:
    "click .delproject" : "destroy"
    "mouseenter .navbar-blue.head" : "showManage"
    "mouseleave .navbar-blue.head" : "hideManage"

  destroy: ->
    alertify.confirm('Are you sure you want to delete this todo list?',
    (e, str) =>
        if e
          @model.destroy()
          this.remove()
          this.stopListening()
          alertify.success("Todo list was successfully deleted!")
          return false
    )

  showManage: ->
    @$('#list_manage_buttons').removeClass('hidden')

  hideManage: ->
    @$('#list_manage_buttons').addClass('hidden')

  reRender: ->
    @render()
    tasks_view = new BackboneTodo.Views.Tasks.IndexView(tasks: @model.get('tasks'))
    @$("tbody#tasks").append(tasks_view.render().el)
    new_task_view = new BackboneTodo.Views.Tasks.NewView(collection: @model.get('tasks'))
    @$("#new_task").append(new_task_view.render().el)

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    @$('#list_manage_buttons').addClass('hidden')
    return this
