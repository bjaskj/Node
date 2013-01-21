chai = require 'chai'
chai.should()
expect = chai.expect

{TaskList, Task} = require '../src/task'

describe 'Task instance', ->
  task1 = task2 = null

  it 'should have a name', ->
    task1 = new Task 'feed the cat'
    task1.name.should.equal 'feed the cat'

  it 'should be initially incomplete', ->
    task1.status.should.equal 'incomplete'

  it 'should be able to be completed', ->
    task1.complete().should.be.true
    task1.status.should.equal 'complete'

  it 'should be able to be dependent on another task', ->
    task1 = new Task 'wash dishes'
    task2 = new Task 'dry dishes'
    task2.dependsOn task1
    task2.status.should.equal 'dependent'
    task2.parent.should.equal task1
    task1.child.should.equal task2

  it 'should refuse completion it is dependent on an uncompleted task', ->
    (-> task2.complete()).should.throw "Dependent task 'wash dishes' is not completed."

describe 'TaskList', ->
  taskList = null
  it 'should start with no tasks', ->
    taskList = new TaskList
    taskList.tasks.length.should.equal 0
    taskList.length.should.equal 0