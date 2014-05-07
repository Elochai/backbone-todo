BackboneTodo.Views.Tasks ||= {}

class BackboneTodo.Views.Tasks.IndexView extends Backbone.View
  template: JST["backbone/templates/tasks/index"]

  events:
    "update-sort": "updateSort"

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
    @collection.sort()
    @collection.each(
      (task, index) ->
        task.save(priority: index + 1)
    )

  updateSort: (event, model, position) ->
    @collection.each(
      (task, index) =>
        priority = task.get('priority')
        if model.get('priority') < position + 1
          if task.get('priority') <= position + 1
            priority -= 1
        if model.get('priority') > position + 1
          if task.get('priority') >= position + 1
            priority += 1
        task.save(priority: priority)
    )
    model.save(priority: position + 1)
    @orderTasks()


  render: =>
    $(@el).html(@template(tasks: @collection.toJSON() ))
    @addAll()
    @$("#tasks_list").sortable stop: (event, ui) ->
      ui.item.trigger "drop", ui.item.index()
      return
    return this