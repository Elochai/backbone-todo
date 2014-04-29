class BackboneTodo.Models.TodoList extends Backbone.RelationalModel
  paramRoot: 'todo_list'

  defaults:
    name: "New TODO list"

  relations: [
    type: Backbone.HasMany
    key: 'tasks'
    relatedModel: 'BackboneTodo.Models.Task'
    collectionType: 'BackboneTodo.Collections.TasksCollection'
    includeInJSON: false
    reverseRelation:
      key: 'todo_list_id',
      includeInJSON: 'id'
  ]

  initialize: ->
    @on "invalid", (model, error) ->
      alertify.error error

  validate: (attrs) ->
    "Todo list name should not be empty!"  if attrs.name is ''

class BackboneTodo.Collections.TodoListsCollection extends Backbone.Collection
  model: BackboneTodo.Models.TodoList
  url: '/todo_lists'
  comparator: (todo_list) ->
    todo_list.get('created_at')

