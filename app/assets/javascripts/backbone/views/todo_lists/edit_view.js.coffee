BackboneTodo.Views.TodoLists ||= {}

class BackboneTodo.Views.TodoLists.EditView extends Backbone.View
  template : JST["backbone/templates/todo_lists/edit"]

  events :
    "click #update_todo_list" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()
    
    @model.save({name: @$('#input_edited_name').val().trim()},
      success : (todo_list) =>
        alertify.success("Todo list was successfully updated!")
        window.location.hash = "#/index"
      )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    return this