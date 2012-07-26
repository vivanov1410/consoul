eval_input = (input) ->
  result = eval(input)
  #result = (result+"").replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/\r\n|\r|\n/g, '<br>')

#input.addEventListener 'blur', eval_input(), false
#window.setInterval eval_input(), 500
$ ->
  $("#input").keyup ->
    input = $("#input").val()
    $("#output").val eval_input input

  $("#test-button").click ->
    input_function = new Function(a, "var x = 10; console.log(x);")
    $("#output").val sum
    console.log input_function

  $("#it-line").val "hi..."

  $("#command-line").keypress (e) ->
    console.log e.keyCode
    if e.keyCode is 13
      console.log "Enter pressed"
      command = $(this).val()
      if command.trim() is "login"
        $("#it-line").val "facebook or twitter?"
      $(this).val ""
