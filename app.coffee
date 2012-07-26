express = require("express")
routes = require("./routes")
http = require("http")
logger = require("./lib/logger")

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
  app.use app.router
  app.use require("stylus").middleware(src: __dirname + "/views", dest: __dirname + "/public")
  app.use express.static(__dirname + "/public")

app.configure "development", ->
  app.use express.errorHandler()

app.get "/", routes.index
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
