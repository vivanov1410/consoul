$ ->

  editor = ace.edit("editor")
  #editor.renderer.setShowGutter false
  editor.renderer.setShowPrintMargin false
  editor.getSession().setUseSoftTabs true

  output = ace.edit("output")
  output.renderer.setShowGutter false
  output.renderer.setShowPrintMargin false
  output.renderer.setHScrollBarAlwaysVisible false

  JavaScriptMode = require("ace/mode/javascript").Mode
  editor.getSession().setMode new JavaScriptMode()
  output.getSession().setMode new JavaScriptMode()

  sharejs.open 'hello', 'text', (error, doc) ->
    doc.attach_ace(editor)
    editor.getSession().setValue '''
    function foo(a, b) {

      var c = 5;

      var sum = a + b + c;
      return sum;
    }
    '''

  #editor.getSession().on 'change', (e) ->
  args = new Object()
  $('#button').click ->
    #output.getSession().setValue
    #console.log editor.getSession().getDocument().getAllLines()
    #output.getSession().getDocument().insertLines editor.selection.getCursor().row, editor.getSession().getLine(editor.selection.getCursor().row)
    function_code = editor.getSession().getValue()

    function_args = function_code.match(/function\s.*\((.*)\)\s{/)[1] # match function args
    if function_args isnt old_function_args
      old_function_args = function_args
      args_array = function_args.split(',')

      for arg in args_array
        key = arg.trim()
        value = "undefined"
        args[key] = value

    new_output = ''
    for arg, value of args
      new_output = new_output + "#{arg} = #{value}\n"

    output.getSession().setValue new_output

  $('#button2').click ->
    output_str = output.getSession().getValue()
    for arg, value of args
      reg_exp = new RegExp("#{arg}\\s*=\\s*(.*)")
      args[arg] = output_str.match(reg_exp)[1]

  $('#button3').click ->
    function_body = editor.getSession().getLines(1, editor.getSession().getLength() - 2)
    function_body = function_body.join("").replace("return ", "")

    new_function = ''
    for arg, value of args
      new_function = new_function + "var #{arg} = #{value};\n"
    new_function = new_function + function_body
    log eval new_function