fs = require 'fs'
{ spawn, exec } = require 'child_process'

option '-d'

run = (cmd, args) ->
  proc = spawn cmd, args
  proc.stderr.pipe process.stderr, end: false
  proc.stdout.pipe process.stdout, end: false
  proc.on 'exit', (status) ->
    process.kill(1) if status != 0

task 'start', 'Start the app', ->
  exec 'coffee --compile --output public/javascripts lib/consoul.coffee', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + err

  run 'node', ['server.js']

task 'watch', 'Watch .coffee files and relaunch app.coffee', ->
  exec 'nodemon --watch lib server.js', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + err

task 'test', 'Run mocha tests', ->
  run 'node', [
    'node_modules/mocha/bin/mocha'
               '--colors'
               '--require', 'should'
               '--reporter', 'spec'
               '--compilers', 'coffee:coffee-script'
  ]
