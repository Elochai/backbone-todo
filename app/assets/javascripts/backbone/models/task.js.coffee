class BackboneTodo.Models.Task extends Backbone.RelationalModel
  paramRoot: 'task'

  defaults:
    desc: "new task"
    deadline: null
    completed: false

  initialize: ->
    @on "invalid", (model, error) ->
      alertify.error error

  validate: (attrs) ->
    console.log attrs
    "Task description should not be empty!" if attrs.desc is ''


class BackboneTodo.Collections.TasksCollection extends Backbone.Collection
  model: BackboneTodo.Models.Task
  url: '/tasks'

  comparator: (task) ->
    task.get('priority')

  nextPriority: -> if !@.length then 1 else @last().get('priority') + 1


