exports.routes = (app) ->
  routes = require './routes/index'
  user = require './routes/user'

  app.get '/', routes.index
  app.get '/users', user.list