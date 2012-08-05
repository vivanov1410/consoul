$ ->
  editor = ace.edit("editor")
  editor.renderer.setShowPrintMargin false
  editor.getSession().setUseSoftTabs true

  JavaScriptMode = require("ace/mode/javascript").Mode
  editor.getSession().setMode new JavaScriptMode()

  sharejs.open 'hello', 'text', (error, doc) ->
    doc.attach_ace(editor)
    editor.getSession().setValue '''
    <!DOCTYPE HTML>
    <html>
      <head>
        <style>
          body {
            margin: 0px;
            padding: 0px;
          }
          canvas {
            border: 1px solid #9C9898;
          }
        </style>
        <script>
          window.onload = function() {
            var canvas = document.getElementById('canvas');
            if (canvas && canvas.getContext) {
              var ctx = canvas.getContext("2d");
              if (ctx) {
                ctx.fillStyle = "lightGray";
                ctx.fillRect(0,0, ctx.canvas.width, ctx.canvas.height);
              }
            }
          };

        </script>
      </head>
      <body>
        <canvas id="canvas">
          WOW! Back off! This browser doesn't support canvas
        </canvas>
      </body>
    </html>
    '''

    updatePreview = ->
      previewFrame = document.getElementById 'preview'
      preview =  previewFrame.contentDocument or previewFrame.contentWindow.document
      preview.open()
      console.log editor.getSession().getValue()
      preview.write editor.getSession().getValue()

      preview.close()

    editor.getSession().on 'change', (e) ->
      #clearTimeout delay
      #delay = setTimeout updatePreview, 300
      updatePreview()