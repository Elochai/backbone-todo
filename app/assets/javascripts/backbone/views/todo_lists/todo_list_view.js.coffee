BackboneTodo.Views.TodoLists ||= {}

class BackboneTodo.Views.TodoLists.TodoListView extends Backbone.View
  template: JST["backbone/templates/todo_lists/todo_list"]

  initialize: ->
    @listenTo(@model, 'change', @reRender);

  events:
    "click .delproject" : "destroy"
    "dblclick .bartext": "edit"
    "click .editproject": "edit"
    "keypress .todo_list_edit_input": "update"
    "blur .todo_list_edit_input": "restore"
    "mouseenter .navbar-blue.head" : "showManage"
    "mouseleave .navbar-blue.head" : "hideManage"

  destroy: ->
    alertify.confirm('Are you sure you want to delete this todo list?',
    (e, str) =>
        if e
          @model.destroy()
          this.remove()
          alertify.success("Todo list was successfully deleted!")
          return false
    )

  edit: ->
    @$('.head').addClass('hidden')
    @$('.editing').removeClass('hidden')
    @$('.todo_list_edit_input').focus()
    return false

  update: (e) ->
    if e.keyCode is 13
      @model.save({name: @$('.todo_list_edit_input').val()},
        success : (todo_list) =>
          @reRender()
          @restore()
          alertify.success("Todo list was successfully updated!")
      )

  restore: ->
    @$('.head').removeClass('hidden')
    @$('.editing').addClass('hidden')

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
