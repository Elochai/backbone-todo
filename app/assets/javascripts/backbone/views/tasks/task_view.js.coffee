BackboneTodo.Views.Tasks ||= {}

class BackboneTodo.Views.Tasks.TaskView extends Backbone.View
  template: JST["backbone/templates/tasks/task"]

  tagName: 'tr'
  
  events:
    "click #delete_task" : "destroy"
    "click #edit_task" : "edit"
    "dblclick #task_desc" : "edit"
    "click #update_task" : "updateOnClick"
    "click #choose_deadline" : "editDeadline"
    "keypress .task_edit_input#edit_desc" : "updateOnEnter"
    "click #set_deadline" : "setDeadline"
    "click #cancel_deadline" : "restoreFromDatepicker"
    "click #cancel_edit" : "restore"
    "click #check_completed" : "complete"
    "click #up" : "up"
    "click #down" : "down"
    "mouseenter td" : "showManage"
    "mouseleave td" : "hideManage"

  stopAll: (e) ->
    e.preventDefault()
    e.stopPropagation()

  destroy: (e) ->
    @stopAll(e)
    @model.destroy()
    this.remove()
    alertify.success("Task was successfully deleted!")

  edit: (e) ->
    @stopAll(e)
    @$('td.visible').addClass('hidden')
    @$('.editing_task').removeClass('hidden')
    @$('.editing_deadline').addClass('hidden')
    @$('.task_edit_input#edit_desc').focus()
    return false

  editDeadline: (e) ->
    @stopAll(e)
    @$('td.visible').addClass('hidden')
    @$('.editing_task').addClass('hidden')
    @$('.editing_deadline').removeClass('hidden')
    @$('.task_edit_input#datepicker').datepicker(
      todayBtn: "linked",
      startDate: 'd',
      endDate: '+10y',
      todayHighlight: true
    )
    @$('.task_edit_input#datepicker').focus()
    return false

  update: ->
    @model.save({desc: @$('.task_edit_input').val().trim(), validate: true},
      success : (task) =>
        @render()
        @restore()
        alertify.success("Task was successfully updated!")
    )

  updateOnClick: (e) ->
    @stopAll(e)
    @update()

  updateOnEnter: (e) ->
    if e.keyCode is 13
      @update()

  restore: (e) ->
    @$('td.visible').removeClass('hidden')
    @$('.editing_task').addClass('hidden')
    return false

  restoreFromDatepicker: (e) ->
    @$('td.visible').removeClass('hidden')
    @$('.editing_deadline').addClass('hidden')
    return false

  complete: (e) ->
    @stopAll(e)
    @model.save({completed: !@model.get('completed')})
    @render()

  setDeadline: (e) -> 
    @stopAll(e)
    @model.save(deadline: @$('.task_edit_input#datepicker').val().trim())
    @render()
    @restore()
    alertify.success("Deadline was successfully added!")

  showManage: ->
    @$('#manage_buttons').removeClass('hidden')

  hideManage: ->
    @$('#manage_buttons').addClass('hidden')

  up: (e) ->
    @stopAll(e)
    currentPriority = @model.get('priority')
    if currentPriority <= @model.collection.length && currentPriority != 1
      temp = @model.collection.where(priority: currentPriority - 1)[0]
      temp.save(priority: currentPriority)
      @model.save(priority: currentPriority - 1)
      @model.collection.sort()
      @model.get('todo_list_id').trigger('change')

  down: (e) ->
    @stopAll(e)
    currentPriority = @model.get('priority')
    if currentPriority < @model.collection.length 
      temp = @model.collection.where(priority: currentPriority + 1)[0]
      temp.save(priority: currentPriority)
      @model.save(priority: currentPriority + 1)
      @model.collection.sort()
      @model.get('todo_list_id').trigger('change')

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    @$('#manage_buttons').addClass('hidden')
    @$('td.fixed1#task_desc').toggleClass('striked', @model.get('completed'))
    @$('#check_completed').attr('checked', @model.get('completed'))
    if @model.get('deadline')
      @$('#task_desc').append("<small>(deadline: #{@model.get('deadline')})</small>")
    return this
