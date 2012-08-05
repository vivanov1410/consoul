// Generated by CoffeeScript 1.3.3
(function() {
  var process_command;

  process_command = function(command) {
    command = command.trim().toLowerCase();
    switch (command) {
      case "login":
        return $("#it-line").val("facebook or twitter?");
      case "login twitter":
        return window.location.href = '/auth/twitter';
      case "login facebook":
        return window.location.href = '/auth/facebook';
    }
  };

  $(function() {
    $("#it-line").val("hi...");
    return $("#command-line").keypress(function(e) {
      var command;
      if (e.keyCode === 13) {
        console.log("Enter pressed");
        command = $(this).val();
        process_command(command);
        return $(this).val("");
      }
    });
  });

}).call(this);
