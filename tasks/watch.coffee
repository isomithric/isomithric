gulp = require "gulp"

gulp.task "watch", ->
  gulp.watch "./src/**/*", [ "default" ]
