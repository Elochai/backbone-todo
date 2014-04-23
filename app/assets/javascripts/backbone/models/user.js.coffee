class BackboneTodo.Models.User extends Backbone.RelationalModel
  paramRoot: 'user'

  defaults:
    email: null
    password: null

  relations: [
    type: Backbone.HasMany
    key: 'todo_lists'
    relatedModel: 'BackboneTodo.Models.TodoList'
    collectionType: 'BackboneTodo.Collections.TodoListsCollection'
    includeInJSON: false
    reverseRelation:
      key: 'user_id',
      includeInJSON: 'id'
  ]

class BackboneTodo.Collections.UsersCollection extends Backbone.Collection
  model: BackboneTodo.Models.User
  url: '/users'
