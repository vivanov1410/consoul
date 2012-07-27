process_command = (command) ->
  command = command.trim().toLowerCase()
  switch command
    when "login" then $("#it-line").val "facebook or twitter?"
    when "login twitter" then window.location.href = '/auth/twitter'
    when "login facebook" then window.location.href = '/auth/facebook'

$ ->
  $("#it-line").val "hi..."

  $("#command-line").keypress (e) ->
    if e.keyCode is 13 # Enter
      console.log "Enter pressed"
      command = $(this).val()
      process_command(command)
      $(this).val ""

