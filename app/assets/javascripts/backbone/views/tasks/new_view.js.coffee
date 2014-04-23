BackboneTodo.Views.Tasks ||= {}

class BackboneTodo.Views.Tasks.NewView extends Backbone.View
  template: JST["backbone/templates/tasks/new"]

  events:
    "click .add_task": "saveOnClick"
    "keypress .input_task": "saveOnEnter"

  constructor: (options) ->
    super(options)

  save_task: ->
    taskDesc = @$('#input_task').val()
    @model = new BackboneTodo.Models.Task({desc: taskDesc, priority: @collection.nextPriority()})
    @model.unset("errors")
    if @model.isValid()
      @collection.create(@model,
        error: (task, jqXHR) =>
            @model.set({errors: $.parseJSON(jqXHR.responseText)})
        success: =>
          @render()
          alertify.success("Task was successfully created!")
        )

  saveOnClick: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @save_task()
    
  saveOnEnter: (e) ->
    if e.keyCode is 13
      @save_task()

  render: ->
    $(@el).html(@template())
    this.$("form").backboneLink(@model)
    return this
