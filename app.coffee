express = require("express")
routes = require("./routes")
http = require("http")
util = require("util")
logger = require("./lib/logger")
everyauth = require("everyauth")

everyauth.twitter
.consumerKey('IPRIsihBy75vv4zDJrmeeQ')
.consumerSecret('T8VYXk56XrQ2N2WFw31z1EZkjdfmWbE8TU5rAdCsOA')
.findOrCreateUser (session, token, secret, user) ->
  promise = @.Promise().fulfill user
  logger.info "User logged in by twitter #{user}"
.redirectPath '/main'

app = express()

app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger(format: "short", stream: logger.stream)
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser("your secret here")
  app.use express.session()
  app.use everyauth.middleware()
  app.use app.router
  app.use require("stylus").middleware(src: __dirname + "/views", dest: __dirname + "/public")
  app.use express.static(__dirname + "/public")

app.configure "development", ->
  app.use express.errorHandler()

app.get "/", routes.index
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
