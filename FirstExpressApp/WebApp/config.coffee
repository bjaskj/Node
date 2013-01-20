coffeeScript = require 'coffee-script'
coffeeScriptConnect = require 'connect-coffee-script'
expressLayouts = require 'express-ejs-layouts'
lessConnect = require 'less-middleware'
path = require 'path'

exports.config = (app, express) ->
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
    app.use lessConnect({
      dest: __dirname + '/public'
      src: __dirname + '/src'
      compress: true
    })
    app.use coffeeScriptConnect({
      dest: __dirname + '/public'
      src: __dirname + '/src'
      bare: true
    })
    app.use express.static(path.join(__dirname, '/public'))
  )

  app.configure 'development', () ->
    console.log 'Starting in development mode'

    app.use express.errorHandler({
    dumpExceptions: true
    showStack     : true
    })

  app.configure 'production', () ->
    console.log 'Starting in production mode'
    app.use express.errorHandler()