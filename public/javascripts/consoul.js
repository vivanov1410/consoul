// Generated by CoffeeScript 1.3.3
(function() {

  $(function() {
    var JavaScriptMode, args, editor, output;
    editor = ace.edit("editor");
    editor.renderer.setShowPrintMargin(false);
    editor.getSession().setUseSoftTabs(true);
    output = ace.edit("output");
    output.renderer.setShowGutter(false);
    output.renderer.setShowPrintMargin(false);
    output.renderer.setHScrollBarAlwaysVisible(false);
    JavaScriptMode = require("ace/mode/javascript").Mode;
    editor.getSession().setMode(new JavaScriptMode());
    output.getSession().setMode(new JavaScriptMode());
    sharejs.open('hello', 'text', function(error, doc) {
      doc.attach_ace(editor);
      return editor.getSession().setValue('function foo(a, b) {\n\n  var c = 5;\n\n  var sum = a + b + c;\n  return sum;\n}');
    });
    args = new Object();
    $('#button').click(function() {
      var arg, args_array, function_args, function_code, key, new_output, old_function_args, value, _i, _len;
      function_code = editor.getSession().getValue();
      function_args = function_code.match(/function\s.*\((.*)\)\s{/)[1];
      if (function_args !== old_function_args) {
        old_function_args = function_args;
        args_array = function_args.split(',');
        for (_i = 0, _len = args_array.length; _i < _len; _i++) {
          arg = args_array[_i];
          key = arg.trim();
          value = "undefined";
          args[key] = value;
        }
      }
      new_output = '';
      for (arg in args) {
        value = args[arg];
        new_output = new_output + ("" + arg + " = " + value + "\n");
      }
      return output.getSession().setValue(new_output);
    });
    $('#button2').click(function() {
      var arg, output_str, reg_exp, value, _results;
      output_str = output.getSession().getValue();
      _results = [];
      for (arg in args) {
        value = args[arg];
        reg_exp = new RegExp("" + arg + "\\s*=\\s*(.*)");
        _results.push(args[arg] = output_str.match(reg_exp)[1]);
      }
      return _results;
    });
    return $('#button3').click(function() {
      var arg, function_body, new_function, value;
      function_body = editor.getSession().getLines(1, editor.getSession().getLength() - 2);
      function_body = function_body.join("").replace("return ", "");
      new_function = '';
      for (arg in args) {
        value = args[arg];
        new_function = new_function + ("var " + arg + " = " + value + ";\n");
      }
      new_function = new_function + function_body;
      return log(eval(new_function));
    });
  });

}).call(this);
