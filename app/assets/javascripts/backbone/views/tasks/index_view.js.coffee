BackboneTodo.Views.Tasks ||= {}

class BackboneTodo.Views.Tasks.IndexView extends Backbone.View
  template: JST["backbone/templates/tasks/index"]

  initialize: (options) ->
    @collection = options.tasks
    @listenTo(@collection, 'reset', @addAll);
    @listenTo(@collection, 'add', @addOne);
    @listenTo(@collection, 'remove', @orderTasks);

  addAll: () =>
    @collection.each(@addOne)

  addOne: (task) =>
    view = new BackboneTodo.Views.Tasks.TaskView({model : task})
    @$("#tasks_list").append(view.render().el)

  orderTasks: () =>
    @collection.each(
      (task, index) ->
        task.save(priority: index + 1)
    )

  render: =>
    $(@el).html(@template(tasks: @collection.toJSON() ))
    @addAll()
    return this