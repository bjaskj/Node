express = require 'express'
routes = require './routes'
user = require './routes/user'
http = require 'http'
path = require 'path'
expressLayouts = require 'express-ejs-layouts'

app = express()

app.configure(() ->
  app.set 'new'
  app.set 'port', process.env.PORT || 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'ejs'
  app.set 'layout', 'layout.ejs'
  app.use expressLayouts
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use require('less-middleware')({
      src: __dirname + '/public'
    })
  app.use express.static(path.join(__dirname, 'public'))
)

app.configure 'development', () ->
  app.use express.errorHandler({
  dumpExceptions: true
  showStack     : true
  })

app.configure 'production', () ->
  app.use express.errorHandler()

app.get '/', routes.index
app.get '/users', user.list


http.createServer(app).listen(app.get('port'), () ->
  console.log "Express server listening on port " + app.get('port')
)