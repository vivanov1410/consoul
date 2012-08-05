module.exports = (app) ->

  app.get '/', (req, res) ->
    res.render "main",
      title: "Consoul"

  app.get '/main', (req, res) ->
    res.render "main",
      title: "Consoul"

  app.get '/canvas', (req, res) ->
    res.render "canvas",
      title: "Consoul"

