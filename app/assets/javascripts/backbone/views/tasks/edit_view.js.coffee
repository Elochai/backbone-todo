BackboneTodo.Views.Tasks ||= {}

class BackboneTodo.Views.Tasks.EditView extends Backbone.View
  template : JST["backbone/templates/tasks/edit"]

  events :
    "click #update_task" : "update"
    "click #input_deadline" : "showDTPicker"
    "click #input_edited_desc" : "hideDTPicker"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save({desc: @$('#input_edited_desc').val().trim(), deadline: @$('#input_deadline').val().trim(), completed: @$('.edit_check#check_completed').prop('checked')},
      success : (task) =>
        alertify.success("Task was successfully updated!")
        window.location.hash = "#/index"
      )

  showDTPicker : (e) ->
    e.preventDefault()
    e.stopPropagation()
    @$('#input_deadline').appendDtpicker(
      "futureOnly": true,
      "minuteInterval": 5,
      "closeOnSelected": true
    )
    @$('#input_deadline').handleDtpicker('show')

  hideDTPicker: ->
    @$('#input_deadline').handleDtpicker('hide')

  render : ->
    $(@el).html(@template(@model.toJSON() ))
    @$('#check_completed').attr('checked', @model.get('completed'))

    return this