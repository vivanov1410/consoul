winston = require 'winston'

logger = new winston.Logger
    transports:[
        new winston.transports.Console()
        new winston.transports.File filename: './log/general.log'
      ]

logger.stream =
  write: (str) ->
    logger.info str

module.exports = logger