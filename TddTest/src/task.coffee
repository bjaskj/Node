class Task
  constructor: (@name) ->
    @status = 'incomplete'

  complete: ->
    if @parent? and @parent.status isnt 'completed'
      throw "Dependent task '#{@parent.name}' is not completed."
    @status = 'complete'
    true

  dependsOn: (@parent) ->
      @parent.child = @
      @status = 'dependent'


root = exports ? window
root.Task = Task