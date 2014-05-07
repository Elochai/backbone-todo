BackboneTodo.Views.Tasks ||= {}

class BackboneTodo.Views.Tasks.TaskView extends Backbone.View
  template: JST["backbone/templates/tasks/task"]

  tagName: 'tr'
  
  events:
    "click #delete_task" : "destroy"
    "click #check_completed" : "complete"
    "click #edit_task" : "edit"
    "mouseenter td" : "showManage"
    "mouseleave td" : "hideManage"
    "drop": "drop"

  stopAll: (e) ->
    e.preventDefault()
    e.stopPropagation()

  destroy: (e) ->
    @stopAll(e)
    alertify.confirm('Are you sure you want to delete this task?',
      (e, str) =>
          if e
            @model.destroy()
            this.remove()
            alertify.success("Task was successfully deleted!")
    )

  complete: (e) ->
    @stopAll(e)
    @model.save({completed: !@model.get('completed')})
    @render()

  edit: (e) ->
    if @model.get('completed') is true
      alertify.error("Can't update already completed task!")
      return false

  showManage: ->
    @$('#manage_buttons').removeClass('hidden')

  hideManage: ->
    @$('#manage_buttons').addClass('hidden')

  drop: (event, index) ->
    @$el.trigger "update-sort", [
      @model
      index
    ]
    return

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    @$('td.fixed1#task_desc').toggleClass('striked', @model.get('completed'))
    @$('#check_completed').attr('checked', @model.get('completed'))
    if @model.get('deadline')
      @$('#task_desc').append("<small>(deadline: #{@model.get('deadline')})</small>")

    return this
